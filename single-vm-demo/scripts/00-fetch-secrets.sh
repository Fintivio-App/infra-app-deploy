#!/usr/bin/env bash
# 00 — Populate ./.env from Azure Key Vault `fintivio-prod`.
# Re-run this once the prod subscription is re-enabled — it fills EVERY secret
# (DB creds, Keycloak client/secret/uuid/realm, EODHD, dashboard enc key, email,
# brokerage, etc.) with the real prod values. Secret VALUES are never printed.
#
#   az login   # as a user with data-plane read on fintivio-prod
#   ./scripts/00-fetch-secrets.sh
set -uo pipefail
VAULT="${VAULT:-fintivio-prod}"
ENV="$(cd "$(dirname "$0")/.." && pwd)/.env"

kv(){ az keyvault secret show --vault-name "$VAULT" --name "$1" --query value -o tsv 2>/dev/null || true; }

# Fail fast if the vault is unreadable (e.g. subscription disabled).
probe="$(az keyvault secret show --vault-name "$VAULT" --name DB-USER --query value -o tsv 2>&1 || true)"
case "$probe" in
  *Forbidden*|*disabled*|*ERROR*|"") echo "!! Cannot read $VAULT (sub disabled / no access?). Re-enable the subscription, then re-run."; echo "   detail: ${probe:0:120}"; exit 1 ;;
esac

echo "==> fetching from Key Vault $VAULT ..."
DBUSER=$(kv DB-USER);            DBPASS=$(kv DB-PASSWORD)
JASYPT=$(kv JASYPT-ENCRYPTION-KEY)
EODHD=$(kv EODHD-API-TOKEN-NEW)
KCCLIENT=$(kv KEYCLOAK-CLIENT);  KCSECRET=$(kv KEYCLOAK-SECRET);  KCUUID=$(kv KEYCLOAK-CLIENT-UUID)
KCREALM=$(kv KEYCLOAK-REALM);    KCADMINU=$(kv KEYCLOAK-ADMIN-USERNAME); KCADMINP=$(kv KEYCLOAK-ADMIN-PASSWORD)
MINIOUSER=$(kv MINIO-USER);      MINIOPASS=$(kv MINIO-PASSWORD)
REDISPASS=$(kv REDIS-PASSWORD)
EMAILADDR=$(kv EMAIL-SERVICE-ADDRESS); EMAILNRP=$(kv EMAIL-NO-REPLY-PASSWORD); EMAILRESP=$(kv EMAIL-RESTORE-PASSWORD)
DASHENC=$(kv DASHBOARD-API-ENCRYPTION-KEY)
PLAIDID=$(kv PLAID-CLIENT-ID);   PLAIDSEC=$(kv PLAID-CLIENT-SECRET);  PLAIDENV=$(kv PLAID-ENVIRONMENT)
SNAPID=$(kv SNAPTRADE-CLIENT-ID); SNAPKEY=$(kv SNAPTRADE-CONSUMER-KEY)
WEALTH=$(kv WEALTHREADER-API-KEY)
CBONDSL=$(kv CBONDS-API-LOGIN);  CBONDSP=$(kv CBONDS-API-PASSWORD)
OPENFIGI=$(kv OPENFIGI-API-KEY)
RABBITURL=$(kv RABBITMQ-URL)

: > "$ENV"; chmod 600 "$ENV"
sec(){ printf '\n# %s\n' "$1" >> "$ENV"; }
put(){ printf '%s=%s\n' "$1" "$2" >> "$ENV"; }

sec "Fintivio single-VM demo .env — generated from Key Vault $VAULT. DO NOT COMMIT."
put DOMAIN fintivio.rosfin.tech

sec "Postgres (prod app-user creds so restored data + service auth line up)"
put POSTGRES_HOST postgres;    put POSTGRES_PORT 5432;  put POSTGRES_DB postgres
put POSTGRES_USER "$DBUSER";   put POSTGRES_PASSWORD "$DBPASS"
put DATABASE_HOST postgres;    put DATABASE_PORT 5432
put DATABASE_NAME fintivio;    put DATABASE_USERNAME "$DBUSER"; put DATABASE_PASSWORD "$DBPASS"
put DATABASE_SCHEMA main
put SPRING_DATASOURCE_URL "jdbc:postgresql://postgres:5432/fintivio"
put SPRING_DATASOURCE_USERNAME "$DBUSER"; put SPRING_DATASOURCE_PASSWORD "$DBPASS"
put SPRING_DATASOURCE_HIKARI_SCHEMA main

sec "Java: Key Vault disabled at runtime; secrets supplied here"
put AZURE_KEYVAULT_URL ""; put AZURE_CLIENT_ID ""; put AZURE_CLIENT_SECRET ""; put AZURE_TENANT_ID ""
put DB_USER "$DBUSER"; put DB_PASSWORD "$DBPASS"
put EODHD_API_TOKEN_NEW "$EODHD"
put JASYPT_ENCRYPTION_KEY "${JASYPT:-demo-not-load-bearing}"

sec "Redis"
put REDIS_HOST redis; put REDIS_PORT 6379; put REDIS_PASSWORD "$REDISPASS"

sec "MinIO"
put MINIO_HOST minio; put MINIO_PORT 9000; put MINIO_USERNAME "$MINIOUSER"; put MINIO_PASSWORD "$MINIOPASS"

sec "Keycloak (client/secret/uuid/realm from KV; match the restored realm)"
put KC_ADMIN "$KCADMINU"; put KC_ADMIN_PASSWORD "$KCADMINP"
put KC_DB_URL "jdbc:postgresql://postgres:5432/keycloak"
put KC_DB_USERNAME "$DBUSER"; put KC_DB_PASSWORD "$DBPASS"
put KEYCLOAK_HOST keycloak:8080; put KEYCLOAK_PORT 8080; put KEYCLOAK_SSL NONE
put KEYCLOAK_REALM "$KCREALM"; put KEYCLOAK_CLIENT "$KCCLIENT"
put KEYCLOAK_CLIENT_UUID "$KCUUID"; put KEYCLOAK_SECRET "$KCSECRET"
put KEYCLOAK_ADMIN_USERNAME "$KCADMINU"; put KEYCLOAK_ADMIN_PASSWORD "$KCADMINP"
put KEYCLOAK_EXTERNAL_BASE_URL "https://auth.fintivio.rosfin.tech"

sec "Gateway middleware"
put AUTH_MIDDLEWERE true; put LOGGING_MIDDLEWERE true; put ERROR_MIDDLEWERE true
put SERVER_LOGGING_JSON true; put SERVER_TYPE_OF_STAND prod; put SERVER_SIZE_OF_BODY 200mb

sec "Inter-service hosts (internal docker DNS)"
put USER_MANAGEMENT_API_HOST fintivio-user-management-api; put USER_MANAGEMENT_API_PORT 8080
put USER_MANAGEMENT_HOST fintivio-user-management-api;     put USER_MANAGEMENT_PORT 8080
put ENTITY_MANAGEMENT_HOST fintivio-entity-management-api; put ENTITY_MANAGEMENT_PORT 8080
put FAMILY_MANAGER_HOST fintivio-family-management-api;    put FAMILY_MANAGER_PORT 8080
put ASSET_MANAGEMENT_API_HOST fintivio-asset-management-api; put ASSET_MANAGEMENT_API_PORT 8080
put FILE_MANAGER_HOST fintivio-document-api; put FILE_MANAGER_PORT 8080
put FILE_MANAGER_EXTERNAL "https://gateway.fintivio.rosfin.tech/fintivio-document-api.application"
put ACCOUNTS_API_BASE_URL http://fintivio-accounts-api:8080
put DOCUMENTS_API_BASE_URL http://fintivio-document-api:8080
put NOTIFICATIONS_API_BASE_URL http://fintivio-notifications-api:8080
put ASSET_MANAGEMENT_API_BASE_URL http://fintivio-asset-management-api:8080
put NOTIFICATION_SERVICE_URL http://fintivio-notifications-api:8080

sec "Email"
put EMAIL_HOST smtp.gmail.com; put EMAIL_PORT 465
put EMAIL_RESTORE_MAIL "$EMAILADDR"; put EMAIL_RESTORE_PASSWORD "$EMAILRESP"
put EMAIL_NO_REPLY_MAIL "$EMAILADDR"; put EMAIL_NO_REPLY_PASSWORD "$EMAILNRP"

sec "Market data / integrations"
put EODHD_API_KEY "$EODHD"; put EODHD_API_TOKEN "$EODHD"
put DASHBOARD_API_KEY_OF_ENCRYPTION "$DASHENC"
put OPENFIGI_API_KEY "$OPENFIGI"
put CBONDS_API_LOGIN "$CBONDSL"; put CBONDS_API_PASSWORD "$CBONDSP"
put SNAPSHOT_SCHEDULER_ENABLED false; put LEASE_SCHEDULER_ENABLED false
put SNAPTRADE_CLIENT_ID "$SNAPID"; put SNAPTRADE_CONSUMER_KEY "$SNAPKEY"; put SNAPTRADE_CLIENT_SECRET "$SNAPKEY"
put PLAID_CLIENT_ID "$PLAIDID"; put PLAID_CLIENT_SECRET "$PLAIDSEC"; put PLAID_ENVIRONMENT "${PLAIDENV:-sandbox}"
put WEALTHREADER_API_KEY "$WEALTH"
put RABBITMQ_URL "$RABBITURL"

sec "Image coordinates"
put BACKEND_IMAGE_NAMESPACE admacc1; put BACKEND_IMAGE_TAG latest; put FRONTEND_IMAGE_TAG demo

echo "==> wrote $ENV"
echo "==> populated keys (value lengths, masked):"
while IFS='=' read -r k v; do case "$k" in ''|\#*) continue;; esac; printf '   %-32s %s\n' "$k" "$([ -n "$v" ] && echo "set(${#v})" || echo EMPTY)"; done < "$ENV"
