#!/usr/bin/env bash
# 02 — Provide TLS certs at ./tls/{fullchain.pem,privkey.pem}.
# Auth cookies are Secure, so HTTPS is REQUIRED for login to work.
#
# Usage:
#   ./02-issue-tls.sh letsencrypt   # certbot --standalone for the explicit hostnames (port 80 must be free)
#   ./02-issue-tls.sh selfsigned    # quick self-signed wildcard (browser will warn)
set -euo pipefail
cd "$(dirname "$0")/.."
set -a; . ./.env; set +a
MODE="${1:-selfsigned}"
mkdir -p tls

HOSTS=("$DOMAIN" "remotes.$DOMAIN" "gateway.$DOMAIN" "auth.$DOMAIN" "files.$DOMAIN")

if [ "$MODE" = "letsencrypt" ]; then
  echo "==> Requesting Let's Encrypt certs (standalone). Ensure DNS A records point here and port 80 is free."
  domain_args=(); for h in "${HOSTS[@]}"; do domain_args+=(-d "$h"); done
  sudo certbot certonly --standalone --non-interactive --agree-tos \
    -m "admin@$DOMAIN" "${domain_args[@]}"
  sudo cp "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" tls/fullchain.pem
  sudo cp "/etc/letsencrypt/live/$DOMAIN/privkey.pem"   tls/privkey.pem
  sudo chown "$USER" tls/*.pem
  echo "==> Installed Let's Encrypt certs (covers: ${HOSTS[*]})."
  echo "    NOTE: a true wildcard (*.$DOMAIN) needs DNS-01; this issues SANs for the listed hosts."
else
  echo "==> Generating self-signed wildcard cert for *.$DOMAIN and $DOMAIN"
  openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
    -keyout tls/privkey.pem -out tls/fullchain.pem \
    -subj "/CN=$DOMAIN" \
    -addext "subjectAltName=DNS:$DOMAIN,DNS:*.$DOMAIN"
  echo "==> Self-signed cert written to tls/. Browsers will warn (fine for an internal demo)."
fi
ls -l tls/
