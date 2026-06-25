#!/usr/bin/env bash
# 05 — Bring the stack up in order: infra → restore prod DB → keycloak → apps.
#
# DB strategy (pick one):
#   * RESTORE (default): drop the prod dump in db/backup/ — uses scripts/04-restore-db.sh
#   * FRESH (no backup):  set FRESH_DB=1 — uses scripts/90-fresh-db-no-backup.sh
set -euo pipefail
cd "$(dirname "$0")/.."
[ -f .env ] || { echo "!! .env missing — copy .env.example to .env and fill it in."; exit 1; }
[ -f tls/fullchain.pem ] || { echo "!! tls/fullchain.pem missing — run scripts/02-issue-tls.sh first."; exit 1; }
set -a; . ./.env; set +a

echo "==> Pulling backend + infra images (frontends are local; ignore their pull misses)"
docker compose pull --ignore-pull-failures

echo "==> Starting infrastructure (postgres, redis, minio)"
docker compose up -d postgres redis minio
echo "   waiting for postgres health..."
until [ "$(docker inspect -f '{{.State.Health.Status}}' fintivio-postgres 2>/dev/null)" = "healthy" ]; do sleep 2; done

if [ "${FRESH_DB:-0}" = "1" ]; then
  echo "==> FRESH_DB=1 → fresh schema + migrations (no backup)"
  ./scripts/90-fresh-db-no-backup.sh
else
  echo "==> Restoring production DB backup (set FRESH_DB=1 to skip)"
  ./scripts/04-restore-db.sh
fi

echo "==> Starting Keycloak (uses restored realm; imports bootstrap only if realm absent)"
docker compose up -d keycloak

echo "==> Starting backends + frontends + nginx"
docker compose up -d

echo "==> Up. Container status:"
docker compose ps
echo
echo "Open: https://${DOMAIN}/   — then run scripts/06-healthcheck.sh"
