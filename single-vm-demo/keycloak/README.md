# Keycloak realm for the demo

`import/realm-fintivio.json` is a **minimal bootstrap realm** so that login works
on a clean VM. It defines one confidential client (`fintivio-gateway`) and a single
`demo` user with the `administrator` role.

⚠️ **It does NOT reproduce the production role/access tree.** The gateway and
user-management-api load a hierarchy of roles/accesses; with the minimal realm,
authorization-heavy screens may be empty or restricted. For a faithful demo,
replace it with a real export from the existing Keycloak.

## Export the real realm (recommended)

From a machine that can reach the live Keycloak (or exec into its pod/container):

```bash
# Inside a Keycloak 26.x container:
/opt/keycloak/bin/kc.sh export \
  --dir /tmp/export --realm fintivio --users realm_file
# then copy /tmp/export/fintivio-realm.json out
```

Then, in the exported JSON, **find/replace the old domain** so redirects work on
the demo:

- `app.fintivio.com`  → `fintivio.rosfin.tech`
- `dev.fintivio.com`  → `fintivio.rosfin.tech`
- ensure every client's `redirectUris` include `https://fintivio.rosfin.tech/*`
- ensure `webOrigins` include `https://fintivio.rosfin.tech` and
  `https://remotes.fintivio.rosfin.tech`
- set `sslRequired` to `none` (TLS is terminated at nginx; Keycloak runs behind it
  with `KC_PROXY=edge`)

Drop the result in `import/` (replacing the bootstrap file) **before** the first
`docker compose up` — Keycloak imports `*.json` from here on first boot via
`start-dev --import-realm`.

## Keep `.env` in sync

Whichever realm you use, these must match what the gateway expects:

| .env var                | must equal                                            |
|-------------------------|-------------------------------------------------------|
| `KEYCLOAK_REALM`        | the realm name (`fintivio`)                           |
| `KEYCLOAK_CLIENT`       | the gateway client's `clientId`                       |
| `KEYCLOAK_SECRET`       | that client's `secret`                                |
| `KEYCLOAK_CLIENT_UUID`  | that client's internal `id` (UUID)                    |

For the bootstrap file: client `id` is `11111111-1111-1111-1111-111111111111`,
`clientId` is `fintivio-gateway`, secret is the placeholder `CHANGE_ME_client_secret`.
