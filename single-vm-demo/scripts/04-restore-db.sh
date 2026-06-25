#!/usr/bin/env bash
# 04 — Restore the FULL production database backup into the demo Postgres,
# then rewrite Keycloak redirect URIs / web origins to the demo domain.
#
# This is the PRIMARY db path (real tables + real data + the real Keycloak realm).
# For a no-backup/fresh run use scripts/90-fresh-db-no-backup.sh instead.
#
# Supported backup formats (drop the file in db/backup/ or pass a path):
#   * pg_dumpall plain SQL        (.sql / .sql.gz)  — recommended, restores ALL dbs + roles
#   * single-db custom dump       (.dump)           — restored with pg_restore --create
#
# Run AFTER postgres is up and BEFORE keycloak starts (05-up.sh does this).
set -euo pipefail
cd "$(dirname "$0")/.."
set -a; . ./.env; set +a

BACKUP="${1:-}"
if [ -z "$BACKUP" ]; then
  BACKUP="$(ls -t db/backup/*.sql db/backup/*.sql.gz db/backup/*.dump 2>/dev/null | head -1 || true)"
fi
[ -n "$BACKUP" ] && [ -f "$BACKUP" ] || { echo "!! No backup file. Put the prod dump in db/backup/ or pass a path: $0 /path/to/dump"; exit 1; }
echo "==> Restoring from: $BACKUP"

PG="docker exec -i fintivio-postgres"
SUPER="-U $POSTGRES_USER"

case "$BACKUP" in
  *.sql.gz)
    echo "   (gzip plain SQL — pg_dumpall style, restoring all databases + roles)"
    gunzip -c "$BACKUP" | $PG psql $SUPER -v ON_ERROR_STOP=0 -d postgres
    ;;
  *.sql)
    echo "   (plain SQL — pg_dumpall style, restoring all databases + roles)"
    $PG psql $SUPER -v ON_ERROR_STOP=0 -d postgres < "$BACKUP"
    ;;
  *.dump)
    echo "   (custom-format single-db dump — pg_restore --create)"
    $PG pg_restore $SUPER -d postgres --create --clean --if-exists < "$BACKUP"
    ;;
  *) echo "!! Unrecognised backup extension: $BACKUP"; exit 1 ;;
esac

echo "==> Databases now present:"
$PG psql $SUPER -d postgres -tAc "SELECT datname FROM pg_database WHERE datistemplate=false ORDER BY 1" | sed 's/^/   - /'
echo "   >>> Make sure .env DATABASE_NAME / SPRING_DATASOURCE_URL match the APP database above."

# ── Rewrite Keycloak redirect URIs + web origins to the demo domain ───────────
KC_DB="$(echo "$KC_DB_URL" | sed -E 's#.*/([^/?]+).*#\1#')"   # db name from KC_DB_URL
if $PG psql $SUPER -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$KC_DB'" | grep -q 1; then
  echo "==> Rewriting Keycloak client URLs in db '$KC_DB'  (*.fintivio.com -> $DOMAIN)"
  $PG psql $SUPER -d "$KC_DB" <<SQL || echo "   (warn: KC url rewrite returned non-zero; table names may differ by KC version)"
UPDATE redirect_uris SET value = replace(replace(value,'app.fintivio.com','$DOMAIN'),'dev.fintivio.com','$DOMAIN');
UPDATE web_origins   SET value = replace(replace(value,'app.fintivio.com','$DOMAIN'),'dev.fintivio.com','$DOMAIN');
SQL
  echo "   Done. (Issuer/hostname itself is forced by KC_HOSTNAME_URL=https://auth.$DOMAIN in compose.)"
else
  echo "==> No '$KC_DB' database in the backup — Keycloak will import the bootstrap realm instead."
fi

echo "==> Restore complete."
