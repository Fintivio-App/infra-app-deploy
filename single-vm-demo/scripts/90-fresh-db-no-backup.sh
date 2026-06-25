#!/usr/bin/env bash
# 04 — Initialise the database: schemas + keycloak DB, then run the migrations
# (Liquibase changelogs / seed data) from fintivio-database-migrations.
#
# Run AFTER `postgres` is up (05 starts infra first). Connects over the demo network.
set -euo pipefail
cd "$(dirname "$0")/.."
set -a; . ./.env; set +a

REPO_ROOT="${REPO_ROOT:-$(cd ../.. && pwd)}"
MIGRATIONS_DIR="$REPO_ROOT/fintivio-database-migrations"
NET="fintivio-demo-net"

echo "==> Ensuring schemas + keycloak database (idempotent)"
docker exec -i fintivio-postgres psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<SQL
CREATE SCHEMA IF NOT EXISTS main;
CREATE SCHEMA IF NOT EXISTS sandbox;
CREATE SCHEMA IF NOT EXISTS real_estate;
SELECT 'CREATE DATABASE keycloak' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname='keycloak')\gexec
SQL

if [ ! -d "$MIGRATIONS_DIR" ]; then
  echo "!! $MIGRATIONS_DIR not found. Clone fintivio-database-migrations next to the other repos."
  exit 1
fi

# Try to locate a Liquibase master changelog.
MASTER="$(cd "$MIGRATIONS_DIR" && find db -maxdepth 3 -iname '*master*' \( -name '*.xml' -o -name '*.yaml' -o -name '*.yml' -o -name '*.json' -o -name '*.sql' \) 2>/dev/null | head -1 || true)"

if [ -n "$MASTER" ]; then
  echo "==> Running Liquibase update with changeLogFile=$MASTER"
  docker run --rm --network "$NET" \
    -v "$MIGRATIONS_DIR/db:/liquibase/changelog" \
    liquibase/liquibase:4.29 \
    --url="jdbc:postgresql://postgres:5432/${POSTGRES_DB}" \
    --username="$POSTGRES_USER" --password="$POSTGRES_PASSWORD" \
    --searchPath=/liquibase/changelog \
    --changeLogFile="${MASTER#db/}" \
    --defaultSchemaName=main \
    update
else
  echo "==> No Liquibase master changelog found; loading raw SQL (init + release data) via psql"
  # init schema
  [ -f "$MIGRATIONS_DIR/db/changelog/init/init.sql" ] && \
    docker exec -i fintivio-postgres psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" < "$MIGRATIONS_DIR/db/changelog/init/init.sql"
  # seed data (sorted)
  while IFS= read -r f; do
    echo "   loading $(basename "$f")"
    docker exec -i fintivio-postgres psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" < "$f" || echo "   (warn: $f returned non-zero)"
  done < <(find "$MIGRATIONS_DIR/db/changelog/releases" -name '*.sql' 2>/dev/null | sort)
fi

echo "==> DB init complete. Verify with:"
echo "    docker exec -it fintivio-postgres psql -U $POSTGRES_USER -d $POSTGRES_DB -c '\\dt main.*'"
