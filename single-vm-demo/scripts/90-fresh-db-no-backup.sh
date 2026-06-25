#!/usr/bin/env bash
# 90 — FRESH DB (no backup, no KV): create the app DB, apply the generated schema
# (db/fresh/10-schema.sql — all 12 schemas + 110 tables, derived from the Sequelize
# models), apply any seed files, then create the keycloak DB.
#
# Used by `FRESH_DB=1 ./scripts/05-up.sh`. Keycloak then imports the bootstrap realm
# (keycloak/import/realm-fintivio.json) — so KEYCLOAK_CLIENT/_SECRET/_CLIENT_UUID in
# .env MUST match that realm (no restored DB to recover them from).
set -euo pipefail
cd "$(dirname "$0")/.."
set -a; . ./.env; set +a
PG="docker exec -i fintivio-postgres"
SU="-U $POSTGRES_USER"
APPDB="${DATABASE_NAME:-fintivio}"
ENVFILE="$(pwd)/.env"

# Bootstrap-realm constants — MUST equal keycloak/import/realm-fintivio.json
BS_REALM=fintivio
BS_CLIENT=fintivio-gateway
BS_UUID=11111111-1111-1111-1111-111111111111
BS_SECRET=fY8d2Lq7Rs4Tv9Xz1Bc3Nm5Pk6Hj0Wg

patch_env(){ NEWVAL="$2" awk -F= -v k="$1" 'BEGIN{v=ENVIRON["NEWVAL"];d=0} $1==k{print k"="v;d=1;next}{print} END{if(!d)print k"="ENVIRON["NEWVAL"]}' "$ENVFILE" > "$ENVFILE.tmp" && mv "$ENVFILE.tmp" "$ENVFILE" && chmod 600 "$ENVFILE"; }

echo "==> Creating app DB '$APPDB' + keycloak DB (idempotent)"
$PG psql $SU -d postgres <<SQL
SELECT 'CREATE DATABASE $APPDB'   WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname='$APPDB')\gexec
SELECT 'CREATE DATABASE keycloak' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname='keycloak')\gexec
SQL

echo "==> Applying db/fresh/*.sql to '$APPDB' (schema first, then seed; ON_ERROR_STOP=0)"
shopt -s nullglob
applied=0
for f in db/fresh/*.sql; do
  echo "   - $(basename "$f")"
  $PG psql $SU -v ON_ERROR_STOP=0 -d "$APPDB" < "$f"
  applied=$((applied+1))
done
[ "$applied" -gt 0 ] || echo "   !! no db/fresh/*.sql found — generate 10-schema.sql first"

echo "==> Aligning .env Keycloak client to the bootstrap realm (fresh path, no KV/DB to recover from)"
patch_env KEYCLOAK_REALM       "$BS_REALM"
patch_env KEYCLOAK_CLIENT      "$BS_CLIENT"
patch_env KEYCLOAK_CLIENT_UUID "$BS_UUID"
patch_env KEYCLOAK_SECRET      "$BS_SECRET"

# 10-schema.sql covers Node-model tables only. ~23 Java tables (the whole `reports`
# schema + import/mail-parser tables in main + some public_markets/provider detail)
# are NOT in it. Let Hibernate create its own missing tables on first boot
# (update = create-missing, NO drops). Backup path leaves this unset (=none),
# since the prod dump already contains every table.
patch_env SPRING_JPA_HIBERNATE_DDL_AUTO update

echo "==> Fresh DB ready. Tables per schema:"
$PG psql $SU -d "$APPDB" -tAc \
  "SELECT table_schema, count(*) FROM information_schema.tables WHERE table_schema NOT IN ('pg_catalog','information_schema') GROUP BY 1 ORDER BY 2 DESC" | sed 's/^/   /'
echo "==> Keycloak imports keycloak/import/realm-fintivio.json (realm '$BS_REALM', client '$BS_CLIENT',"
echo "    demo user 'demo' / 'Demo!2026Fintivio'). Restart gateway after seeding so it reloads the access tree."
