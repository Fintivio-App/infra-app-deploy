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

echo "==> Fresh DB ready. Tables per schema:"
$PG psql $SU -d "$APPDB" -tAc \
  "SELECT table_schema, count(*) FROM information_schema.tables WHERE table_schema NOT IN ('pg_catalog','information_schema') GROUP BY 1 ORDER BY 2 DESC" | sed 's/^/   /'
echo "==> Note: seed/business data is sparse (migrations seed has drifted vs current models)."
echo "    Seed demo data via the app, or restore the prod backup for full fidelity."
