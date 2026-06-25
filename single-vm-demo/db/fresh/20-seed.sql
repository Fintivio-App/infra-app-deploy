-- =============================================================================
-- Fresh-path demo seed (no backup / no KV). Applied by 90-fresh-db-no-backup.sh
-- AFTER 10-schema.sql. Idempotent. Schema-qualified, column-accurate (verified
-- against db/fresh/10-schema.sql).
--
-- Gives the bootstrap-realm demo user a working, authorized session:
--   * authorization is data-driven (no admin bypass) — empty DB = 403 on everything,
--     so we seed: one catch-all access ['*'] -> administrator role -> role_access.
--   * the demo user (Keycloak id pinned in realm-fintivio.json) is linked to one
--     organization with that role, plus one entity so screens aren't empty.
--
-- DEMO_USER_SUB is the pinned Keycloak user id from keycloak/import/realm-fintivio.json.
-- =============================================================================

BEGIN;

-- Currency referenced by organization.local_currency_id (NOT NULL; PK = iso_code).
INSERT INTO main.currency (iso_code, name, symbol, created_at, updated_at)
VALUES ('USD', 'US Dollar', '$', now(), now())
ON CONFLICT (iso_code) DO NOTHING;

-- Administrator role (schema "user-managment"; id is UUID, used as users_organization.role_id).
INSERT INTO "user-managment".role (id, display_name)
VALUES ('00000000-0000-0000-0000-0000000000a1', 'administrator')
ON CONFLICT (id) DO NOTHING;

-- Catch-all access: request_uri_template is JSONB array; '*' is regex-expanded to '.*'
-- by the gateway, so this single row authorizes every route.
INSERT INTO "user-managment".access (id, display_name, parent_id, request_uri_template, is_child, is_hide)
VALUES ('access-all', 'All routes', NULL, '["*"]'::jsonb, false, false)
ON CONFLICT (id) DO NOTHING;

-- Link administrator role -> catch-all access (INNER JOIN in getAllRoles requires this row).
INSERT INTO "user-managment".role_access (role_id, access_id)
VALUES ('00000000-0000-0000-0000-0000000000a1', 'access-all')
ON CONFLICT DO NOTHING;

-- Application user row: id MUST equal the Keycloak token `sub` (pinned demo user id).
INSERT INTO main."user" (id, enabled, is_external, created_at, updated_at)
VALUES ('11111111-2222-3333-4444-555555555555', true, false, now(), now())
ON CONFLICT (id) DO NOTHING;

-- Demo organization (local_currency_id NOT NULL -> USD above).
INSERT INTO main.organization (id, group_id, name, local_currency_id, created_at, updated_at)
VALUES ('00000000-0000-0000-0000-0000000000b1', '00000000-0000-0000-0000-0000000000b1',
        'Demo Organization', 'USD', now(), now())
ON CONFLICT (id) DO NOTHING;

-- Membership: demo user <-> org with administrator role; 'accepted' so it's usable now.
INSERT INTO main.users_organization (id, user_id, organization_id, role_id, status_membership, not_before)
VALUES ('00000000-0000-0000-0000-0000000000c1',
        '11111111-2222-3333-4444-555555555555',
        '00000000-0000-0000-0000-0000000000b1',
        '00000000-0000-0000-0000-0000000000a1',
        'accepted', NULL)
ON CONFLICT (id) DO NOTHING;

-- One entity so asset/portfolio screens are not empty (type app-enforced GENERAL/FAMILY).
INSERT INTO main.entity (id, organization_id, name, type, created_at, updated_at)
VALUES ('00000000-0000-0000-0000-0000000000d1', '00000000-0000-0000-0000-0000000000b1',
        'Demo Entity', 'GENERAL', now(), now())
ON CONFLICT (id) DO NOTHING;

COMMIT;
