#!/usr/bin/env bash
# 05 — Bring the stack up in order: infra first, init DB, then apps.
set -euo pipefail
cd "$(dirname "$0")/.."
[ -f .env ] || { echo "!! .env missing — copy .env.example to .env and fill it in."; exit 1; }
[ -f tls/fullchain.pem ] || { echo "!! tls/fullchain.pem missing — run scripts/02-issue-tls.sh first."; exit 1; }

echo "==> Pulling backend + infra images (frontends are local, ignore their pull misses)"
docker compose pull --ignore-pull-failures

echo "==> Starting infrastructure (postgres, redis, minio, keycloak)"
docker compose up -d postgres redis minio
echo "   waiting for postgres to be healthy..."
until [ "$(docker inspect -f '{{.State.Health.Status}}' fintivio-postgres 2>/dev/null)" = "healthy" ]; do sleep 2; done

echo "==> Initialising database"
./scripts/04-init-db.sh

echo "==> Starting Keycloak (imports realm on first boot)"
docker compose up -d keycloak

echo "==> Starting backends + frontends + nginx"
docker compose up -d

echo "==> Up. Container status:"
docker compose ps
echo
echo "Open: https://${DOMAIN%$'\n'}/   (run scripts/06-healthcheck.sh to verify)"
