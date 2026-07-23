-- AI orchestrator demo setup (Phase 1.5 document extraction).
-- Run once against the demo Postgres:
--   docker exec -i fintivio-postgres psql -U fintivioadm -d fintivio -f - < db/ai/ai-demo-setup.sql
-- Then RESTART THE GATEWAY (docker compose restart fintivio-gateway) — role→URI
-- permissions are loaded into memory at gateway boot.

-- 1) `ai` schema (mirror of fintivio-ai-orchestrator/db/ai_schema.sql; demo services all
--    connect as the same superuser, so no grant gymnastics here).
CREATE SCHEMA IF NOT EXISTS ai;

CREATE TABLE IF NOT EXISTS ai.conversation (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id text NOT NULL,
  user_id         text NOT NULL,
  title           text,
  isdeleted       boolean NOT NULL DEFAULT false,
  created_at      timestamptz NOT NULL DEFAULT now(),
  updated_at      timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS conversation_org_user_idx
  ON ai.conversation (organization_id, user_id) WHERE isdeleted = false;

CREATE TABLE IF NOT EXISTS ai.message (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id uuid NOT NULL REFERENCES ai.conversation(id),
  role            text NOT NULL CHECK (role IN ('user','assistant','tool')),
  content         text,
  evidence        jsonb,
  created_at      timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS message_conv_created_idx
  ON ai.message (conversation_id, created_at);

CREATE TABLE IF NOT EXISTS ai.tool_call_audit (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id uuid,
  organization_id text NOT NULL,
  user_id         text NOT NULL,
  user_role       text,
  tool_name       text NOT NULL,
  tool_args       jsonb NOT NULL,
  result_status   int,
  latency_ms      int,
  request_id      text,
  created_at      timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS tool_call_audit_org_created_idx
  ON ai.tool_call_audit (organization_id, created_at);

-- 2) Gateway route permission. The authorize middleware matches req.url against the
--    caller's access request_uri_template globs + their role's accesses (loaded at boot).
INSERT INTO "user-managment".access (id, display_name, parent_id, request_uri_template, is_child, is_hide)
SELECT 'ai-assistant', 'AI Assistant', NULL,
       '["/fintivio-ai-orchestrator.application/*"]'::jsonb, false, false
WHERE NOT EXISTS (SELECT 1 FROM "user-managment".access WHERE id = 'ai-assistant');

-- Grant to every role so all demo users can use extraction.
INSERT INTO "user-managment".role_access (role_id, access_id)
SELECT r.id, 'ai-assistant'
FROM "user-managment".role r
WHERE NOT EXISTS (
  SELECT 1 FROM "user-managment".role_access ra
  WHERE ra.role_id = r.id AND ra.access_id = 'ai-assistant'
);
