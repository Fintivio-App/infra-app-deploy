# Fresh fallback — functional demo with NO prod backup and NO Key Vault

Use this when the subscription/backup are NOT available and you need a demo up fast.
Everything is self-contained in this folder; nothing is pulled from Azure.

## What makes it work
- **Schema**: `db/fresh/10-schema.sql` — 12 schemas + 110 tables, generated from the
  Sequelize models, validated to apply clean. The 6 Java services create their own
  ~23 extra tables on first boot via `SPRING_JPA_HIBERNATE_DDL_AUTO=update` (set by the
  fresh script).
- **Auth**: `keycloak/import/realm-fintivio.json` — realm `fintivio`, client
  `fintivio-gateway` (fixed secret/UUID), demo user. `90-fresh-db-no-backup.sh` injects
  the matching client creds into `.env`.
- **Authorization seed**: `db/fresh/20-seed.sql` — authorization is data-driven (empty
  DB = 403 on everything), so this seeds a catch-all access → administrator role →
  role_access, and links the demo user → organization (USD) → accepted membership →
  one entity. Verified against the schema (idempotent, zero errors).

## Activate (≈ the normal flow, with FRESH_DB=1)
```bash
# prereqs: VM (80/443), DNS (apex + *.fintivio.rosfin.tech), `docker login` (admacc1),
#          13 UI repos cloned on demo-version at $REPO_ROOT
cp .env.example .env          # set infra creds + EODHD; leave KEYCLOAK_* (fresh script sets them)
./scripts/01-provision-vm.sh
./scripts/02-issue-tls.sh selfsigned        # or: letsencrypt
./scripts/03-build-frontends.sh
FRESH_DB=1 ./scripts/05-up.sh               # schema + seed + Java auto-create + bootstrap realm
./scripts/06-healthcheck.sh
```
**Login:** `https://fintivio.rosfin.tech` → user **`demo`** / **`Demo!2026Fintivio`**.

## What works vs. what to expect
- ✅ Login + authorization (the demo user is an administrator with access to all routes).
- ✅ All Node services + core schema; Java services boot and auto-create their tables.
- ✅ **Rich demo dataset** (`db/fresh/30-demo-data.sql`): the Smith family office — 6 entities
  (trust/LLC/individuals) + 5 family members, 3 brokerage/bank accounts, ~$12.2M of public-markets
  holdings with 3 years of monthly history, 3 PI funds (VC/PE/RE) with capital calls/distributions,
  3 cars + 2 artworks, and ownership of every asset assigned to a family member/entity. Validated
  against Postgres (0 errors). Add/seed more via the app as needed.
- ⚠️ **Java `ddl-auto=update` is unvalidated here** (no JVM/Docker at authoring time) — it
  creates missing tables but could make minor alterations to shared tables. Watch the
  Java logs on first boot.
- ⚠️ **Org switcher**: the gateway `/login` org list reads a token `organization*` claim
  the bootstrap realm doesn't emit; the `/administration/me` path auto-derives the org
  from the DB seed, so data access works. If the UI switcher is empty, add a Keycloak
  user-attribute → claim mapper for the org.
- ⚠️ Dashboards: the encryption key is a generated value, so widgets created in this
  instance work; there's no pre-existing encrypted data to decrypt.

## When the backup/KV come back, prefer them
The backup path (`05-up.sh` without `FRESH_DB=1`, dump in `db/backup/`) is more faithful:
real data, all tables (no Java auto-create needed), the real Keycloak realm (client
secret recovered from the restored DB), and `00-fetch-secrets.sh` fills `.env` from KV.
Use the fresh path only as the no-dependency fallback.
