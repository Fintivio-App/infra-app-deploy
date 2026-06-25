#!/usr/bin/env bash
# 06 — Smoke-test the public endpoints and show container health.
set -uo pipefail
cd "$(dirname "$0")/.."
set -a; . ./.env; set +a

echo "==> Container status"
docker compose ps

echo; echo "==> HTTPS endpoints (-k allows self-signed)"
check() {
  local url="$1" code
  code=$(curl -ksS -o /dev/null -w '%{http_code}' --max-time 10 "$url" || echo "ERR")
  printf "  %-55s %s\n" "$url" "$code"
}
check "https://$DOMAIN/"
check "https://remotes.$DOMAIN/dashboard/assets/remoteEntry.js"
check "https://gateway.$DOMAIN/gateway/services/health"
check "https://auth.$DOMAIN/realms/$KEYCLOAK_REALM/.well-known/openid-configuration"

echo; echo "==> Internal gateway->service hop (should reach a backend via nginx alias)"
docker exec fintivio-gateway sh -lc \
  'wget -qS -O /dev/null http://fintivio-dashboard-api.application/ 2>&1 | head -3' || \
  echo "  (gateway container has no wget, or service not ready — check 'docker compose logs fintivio-dashboard-api')"

echo; echo "Tips: 'docker compose logs -f <service>' to debug a specific container."
