# Fintivio — single-VM demo (`fintivio.rosfin.tech`)

One-time, single-VM deployment of the whole platform with Docker Compose + nginx.
Backends are pulled from Docker Hub as-is; the 13 frontends are rebuilt locally
because they bake the domain in at build time.

## Routing model

```
                          ┌─────────────── nginx (TLS, :80/:443) ───────────────┐
 https://fintivio.rosfin.tech ─────────────────────────────► fintivio-main-ui:80
 https://remotes.fintivio.rosfin.tech/<app>/… ─── rewrite ──► fintivio-<app>-ui:80
 https://gateway.fintivio.rosfin.tech ──── CORS+proxy ──────► fintivio-gateway:8080
 https://auth.fintivio.rosfin.tech ─────────────────────────► fintivio-keycloak:8080
 https://files.fintivio.rosfin.tech ────────────────────────► fintivio-minio:9000
                          └──────────────────────────────────────────────────────┘

 gateway internal hop:  http://fintivio-<svc>-api.application/…  (Host-based, :80)
   → those names are network-aliased to nginx → nginx strips ".application"
   → proxies to  fintivio-<svc>-api:8080   (mirrors the old k8s Service 80→8080)
```

The frontend derives the API host at runtime as `gateway.<window.location.hostname>`,
so on host `fintivio.rosfin.tech` it automatically targets `gateway.fintivio.rosfin.tech`.

## Prerequisites

1. A VM (Ubuntu 22.04+) with public IP, ports **80/443** open.
2. **DNS** → VM IP:
   - `fintivio.rosfin.tech`            (A record)
   - `*.fintivio.rosfin.tech`          (wildcard A — covers remotes/gateway/auth/files)
3. All repos cloned **on branch `demo-version`** side-by-side in one directory
   (`$REPO_ROOT`), including `infra-app-deploy` and `fintivio-database-migrations`.

## Run it

```bash
# from infra-app-deploy/single-vm-demo
cp .env.example .env          # then edit secrets (Postgres/Redis/MinIO/Keycloak, EODHD, Keycloak client secret)
./scripts/01-provision-vm.sh  # docker + compose (skip if already installed)
./scripts/02-issue-tls.sh letsencrypt   # or: selfsigned
./scripts/03-build-frontends.sh         # builds the 13 UI images :demo
./scripts/05-up.sh            # infra → DB init → apps  (calls 04-init-db.sh)
./scripts/06-healthcheck.sh   # smoke test
```

`REPO_ROOT` defaults to the parent of `infra-app-deploy`; override if your clones
live elsewhere: `REPO_ROOT=/srv/fintivio ./scripts/03-build-frontends.sh`.

## What's in here

| Path | Purpose |
|------|---------|
| `docker-compose.yml` | infra + 17 backends + 13 UIs + nginx; `.application` aliases on nginx |
| `.env.example` | single source of truth for every service's env |
| `nginx/templates/00-public.conf.template` | public TLS vhosts + gateway CORS |
| `nginx/templates/10-internal.conf.template` | `*.application` → `svc:8080` resolver |
| `db/init/00-bootstrap.sql` | schemas + keycloak DB (first-boot only) |
| `keycloak/import/realm-fintivio.json` | bootstrap realm (replace with real export — see keycloak/README.md) |
| `scripts/0*.sh` | provision → TLS → build FE → init DB → up → healthcheck |

## Code changes that back this (already pushed to `demo-version`)

- **13 UI repos** — `vite.config.ts` (both ternary arms) + `get-base-url.ts` fallback
  rewritten `*.fintivio.com → fintivio.rosfin.tech`.
- **user-management-api** — hardcoded invitation link → `fintivio.rosfin.tech`.
- Backends otherwise unchanged: Java DB hardcodes are overridden by `SPRING_DATASOURCE_URL`
  in `.env`; the gateway/port wiring is handled by nginx, not code.

## ⚠️ Known risks to validate on first bring-up

1. **Java services + Azure Key Vault.** accounts/public-markets/reports/brokerage-sync/
   provider-management/report-parser pull secrets from Azure Key Vault in prod. With
   `AZURE_KEYVAULT_URL` empty they must fall back to `SPRING_DATASOURCE_*` + `JASYPT_ENCRYPTION_KEY`
   env. If one refuses to boot, check its logs — it may need the Key Vault property source
   explicitly disabled, or the secret provided via env. **Most likely point of failure.**
2. **DB completeness.** `fintivio-database-migrations` seeds schema `main` + v1.0 data.
   Whether it creates *every* table for *every* service (vs. ORM auto-create) is unverified —
   watch for "relation does not exist" on first boot and re-run/extend migrations.
3. **Keycloak realm.** The bundled realm is minimal (login works, but not the full
   role/access tree). Export the real realm for a faithful demo (keycloak/README.md).
4. **Internal hop is HTTP.** Assumes the gateway sets no `x-secure-req` header internally
   (so it calls `:80`). If you see it calling `https`, add a `:443` server to the internal
   nginx template with the self-signed cert.
5. **Optional services.** `fintivio-document-api` / `fintivio-notifications-api` are
   referenced by some services but not in the prod set — uncomment in compose if a demoed
   flow needs them. Brokerage (SnapTrade/Plaid/Wealthreader) + email are left disabled.
6. **EODHD key.** Without `EODHD_API_KEY`, market-data-driven screens will be empty.
