# single-vm-demo — key info & design memory

Everything needed to understand and run the one-time single-VM Docker demo of the
Fintivio platform at **`fintivio.rosfin.tech`**. Self-contained: copy this whole
folder to the VM. `README.md` = the runbook; this file = the "why" + the gotchas.

---

## 1. Goal & shape

Run the entire platform (17 backends + 13 micro-frontends + infra) on ONE VM via
Docker Compose + nginx, on a NEW domain `fintivio.rosfin.tech`. One-time; all code
changes live on a **`demo-version`** branch per repo (cut from `origin/main`).

- **Backend images**: reused as-is from Docker Hub `admacc1/<svc>:latest` (config via env).
- **Frontend images**: MUST be rebuilt — the domain is baked into the bundle at build
  time (the Helm `VITE_*` build-args are vestigial/unused). Built by `scripts/03`.

## 2. Routing model

```
nginx (TLS :80/:443)
  https://fintivio.rosfin.tech            → fintivio-main-ui:80      (MF host)
  https://remotes.fintivio.rosfin.tech/<app>/…  → fintivio-<app>-ui:80  (path rewrite)
  https://gateway.fintivio.rosfin.tech    → fintivio-gateway:8080    (+ credentialed CORS)
  https://auth.fintivio.rosfin.tech       → fintivio-keycloak:8080
  https://files.fintivio.rosfin.tech      → fintivio-minio:9000      (optional)

gateway internal hop:  http://fintivio-<svc>-api.application/…  (Host-based, port 80, http)
  → those hostnames are network-aliased to nginx
  → nginx strips ".application" and proxies to  fintivio-<svc>-api:8080
  → mirrors the old k8s Service (port 80 → targetPort 8080); backends stay UNTOUCHED on 8080
```
Frontend derives the API host at runtime as `gateway.<window.location.hostname>`, so
host `fintivio.rosfin.tech` auto-targets `gateway.fintivio.rosfin.tech` (prod build).

DNS: apex `fintivio.rosfin.tech` (A) + wildcard `*.fintivio.rosfin.tech` (A) → VM IP.
TLS is REQUIRED (auth cookies are `Secure`; plain HTTP breaks login).

## 3. Repos changed (all on branch `demo-version`, pushed to origin = Fintivio-App)

**13 UI repos** — `vite.config.ts` (BOTH ternary arms) + `src/shared/lib/get-base-url.ts`
fallback: `*.fintivio.com → fintivio.rosfin.tech`:
main-ui, dashboard-ui, reports-ui, calendar-ui, accounts-ui, public-markets-ui,
private-investments-ui, lifestyle-assets-ui, provider-management-ui, user-management-ui,
entity-management-ui, family-management-ui, real-estate-ui.

**fintivio-user-management-api** — hardcoded invitation link → rosfin.tech.

**infra-app-deploy** — original copy of this orchestration (this folder is the
consolidated standalone copy).

Backends otherwise unchanged. `fintivio-permission-api` is NOT deployed — skip it.

## 4. Backend services (compose)

Node (Express, :8080, `npm start`): gateway, user-management-api, dashboard-api,
asset-management-api, entity-management-api, family-management-api, lifestyle-assets-api,
private-investments-api, calendar-api, real-estate-api, financial-job (cron, no port).

Java (Spring Boot, :8080): accounts-api, public-markets-api, reports-api,
brokerage-sync-api, provider-management-api, report-parser-api.

Optional (referenced but not in prod set; commented in compose): document-api,
notifications-api.

## 5. Critical gotchas / decisions

- **Env-overridable config**: Node `Configurator` does `Object.assign(this, process.env)`
  → any field (incl. `SERVER_PORT`) is overridable by env. We keep backends on 8080 and
  let nginx do the `.application`→:8080 mapping (chosen over `SERVER_PORT=80`).
- **CORS**: the gateway's own `cors()` emits `ACAO:*`, invalid with credentials. nginx
  hides upstream CORS headers and sets the specific origin + `Allow-Credentials: true`
  (see `nginx/templates/00-public.conf.template`).
- **CI safety**: each repo's `deploy.yaml` is `workflow_dispatch`-only → pushing
  `demo-version` triggers only an image BUILD, never a deploy. `build-and-push` fires on
  push to any branch and (for a plain push) builds with `NODE_ENV=development` — which is
  exactly why both vite ternary arms had to be edited.
- **Java DB hardcode**: public-markets/brokerage-sync/provider-management `application.yml`
  hardcode `dev.fintivio.com` — overridden by `SPRING_DATASOURCE_URL` env (no code change).
- **Frontend build deps**: npm hits MUI peer conflicts (use `--legacy-peer-deps`) and
  occasionally corrupted `node_modules` `.d.ts` (fix: clean reinstall). The Docker build
  uses `yarn`, which sidesteps the peer conflict.

## 6. Database (restore is primary)

Restore the FULL prod backup via `scripts/04-restore-db.sh` (drop dump in `db/backup/`).
- **App DB = `fintivio`**, schema `main` (real-estate uses `real_estate`). `.env` is set
  to this.
- Keycloak realm/users/clients come from the restored `keycloak` DB. The script rewrites
  client `redirect_uris`/`web_origins` `*.fintivio.com → fintivio.rosfin.tech`; the issuer
  is forced by `KC_HOSTNAME_URL`.
- No-backup fallback: `FRESH_DB=1 ./scripts/05-up.sh` → `90-fresh-db-no-backup.sh` +
  the bootstrap realm in `keycloak/import/`.

## 7. Deploy order (scripts)

`01-provision-vm` → `02-issue-tls` → `03-build-frontends` → `05-up` (calls
`04-restore-db`) → `06-healthcheck`. Set `REPO_ROOT` for `03` to where the UI repos
are cloned (default: parent of this folder).

## 8. Top risks to validate on the VM

1. **Java + Azure Key Vault** (most likely failure): the 6 Spring services pull secrets
   from Key Vault in prod. With `AZURE_KEYVAULT_URL` empty they must fall back to
   `SPRING_DATASOURCE_*` + `JASYPT_ENCRYPTION_KEY` env. If one won't boot, check its log
   and disable the Key Vault property source.
2. **EODHD_API_KEY** unset → market-data screens empty.
3. **Internal hop assumed HTTP** — if the gateway ever sets `x-secure-req` it would call
   `:443`; add a self-signed 443 server to `10-internal.conf.template` if so.
4. **nginx config** not yet `nginx -t`-validated (no local Docker daemon at authoring time).

## 9. Credentials model (NO Key Vault, NO GitHub secrets at runtime)

The demo gets ALL runtime config from the single `.env` file. Neither Azure Key Vault
nor GitHub secrets are used at runtime.

- **Node services** read everything from `process.env` (`.env`) — same as prod, just a
  different source.
- **Java services** (accounts/public-markets/reports/brokerage-sync/provider-management/
  report-parser) use, in prod, `spring.cloud.azure.keyvault.secret.property-sources` with
  endpoint `${AZURE_KEYVAULT_URL}` + SP creds `${AZURE_CLIENT_ID/SECRET}`+`${AZURE_TENANT_ID}`.
  For the demo we leave `AZURE_KEYVAULT_URL` **blank** so that source is skipped, and supply
  what it would have given via plain env:
  - `spring.datasource.{url,username,password}` ← `SPRING_DATASOURCE_*` (overrides the yml,
    so `${DB-USER}`/`${DB-PASSWORD}` need not resolve). `DB_USER`/`DB_PASSWORD` env also
    provided as belt-and-suspenders (relaxed binding `DB_USER`→`${DB-USER}`).
  - `${JASYPT-ENCRYPTION-KEY}` ← `JASYPT_ENCRYPTION_KEY` — **must equal prod's** if any
    value is `ENC(...)`-encrypted.
  - `${EODHD-API-TOKEN-NEW}` ← `EODHD_API_TOKEN_NEW` (has a yml fallback default).
  - redis password has a yml fallback; we set `REDIS_PASSWORD`.
- **GitHub secrets** matter only at IMAGE-BUILD time, not demo runtime:
  `DOCKERHUB_USERNAME/PASSWORD` (build+push), `TECH_USER_SSH_KEY` (backend submodule fetch),
  Azure creds + KUBECONFIG (the AKS deploy job we don't use).
- **Docker Hub login REQUIRED on the VM**: `admacc1` is a PRIVATE namespace, so pulling the
  backend images needs `docker login` with the Docker Hub creds before `05-up.sh`.

### Secrets that must MATCH prod (everything else is our choice)
- `JASYPT_ENCRYPTION_KEY` — to decrypt any `ENC(...)` config.
- `KEYCLOAK_CLIENT` / `KEYCLOAK_SECRET` / `KEYCLOAK_CLIENT_UUID` — must match the gateway
  client in the restored realm (read from prod Keycloak or the restored DB).
- Docker Hub pull creds (private images).
- External API keys for live features: `EODHD_API_KEY`/`EODHD_API_TOKEN(_NEW)`;
  SnapTrade/Plaid/Wealthreader (optional — leave disabled otherwise).

### Our choice (set fresh for the demo)
`POSTGRES_PASSWORD`, `DB_PASSWORD`/`SPRING_DATASOURCE_PASSWORD` (= postgres pw),
`REDIS_PASSWORD`, `MINIO_USERNAME`/`PASSWORD`, `KC_ADMIN`/`KC_ADMIN_PASSWORD`.

### Fetching from Key Vault — `scripts/00-fetch-secrets.sh`
ALL secrets live in Azure Key Vault **`fintivio-prod`** (`https://fintivio-prod.vault.azure.net/`),
incl. `KEYCLOAK-CLIENT/-SECRET/-CLIENT-UUID/-REALM`. After `az login`, run
`scripts/00-fetch-secrets.sh` to write a complete `.env` (overwrites it). Both
`fintivio-prod` and `fintivio-dev` are in subscription `e9875f4b…` — when that sub is
**disabled**, KV data-plane reads return `Forbidden (subscription disabled)` even though
`secret list` still works off cached metadata. Re-enable the sub, then re-run the script.

Keycloak client recovery: `04-restore-db.sh` auto-recovers the gateway client
(`KEYCLOAK_CLIENT`/`_CLIENT_UUID`/`_SECRET`) from the restored `keycloak` DB for realm
**`fintivio`** when `.env` still has FILL placeholders — so auth works even without KV.
It also rewrites client redirect_uris/web_origins `*.fintivio.com → $DOMAIN`.

Load-bearing findings (verified):
- **`DASHBOARD-API-ENCRYPTION-KEY`** — NOT a hard blocker. Used in ONE place
  (`WidgetConfigurator.ts:56`, `parseForceFields`) to AES-decrypt only widget forced-fields
  flagged `isEncrypted:true`. Without the real key: dashboard-api still boots, unencrypted
  widgets render fine; only widgets with encrypted saved fields error ("Malformed UTF-8") or
  show wrong data. Pull the real key from KV for fully-correct dashboards.
- **`JASYPT-ENCRYPTION-KEY`** — NOT load-bearing: `grep ENC( = 0` across all config, so
  any non-empty value resolves the Spring placeholder. Prod value not required.
- `EODHD-API-TOKEN-NEW` — public-markets-api needs *a* value to boot (no yml fallback);
  the real value gives live market data.
- Brokerage (`SNAPTRADE-CONSUMER-KEY`, `PLAID-CLIENT-SECRET`, `WEALTHREADER-API-KEY`) —
  no yml fallback, so the Java services need *a* non-empty value to boot; real values only
  matter if live sync is demoed (schedulers off by default).
