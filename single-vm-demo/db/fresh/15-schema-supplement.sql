-- =============================================================================
-- Schema supplement for the FRESH path. The model-sync (10-schema.sql) dropped a
-- few tables due to Sequelize modelName collisions across schemas, and the
-- public_markets asset/brokerage tables are owned by the Java services. The demo
-- seed (30-demo-data.sql) inserts into these, so we create them here (IF NOT EXISTS;
-- harmless if a real migration / Java ddl-auto already made them). Columns match the
-- Sequelize models / JPA entities. No FK constraints (consistent with 10-schema.sql).
-- =============================================================================

-- ── private_investments.transaction (cash-flow amounts/dates live here) ──────
CREATE TABLE IF NOT EXISTS private_investments.transaction (
    id uuid NOT NULL PRIMARY KEY,
    asset_id uuid NOT NULL,
    currency varchar(3) NOT NULL,
    amount numeric(38,8) NOT NULL,
    type varchar(128) NOT NULL,
    description varchar(512),
    is_deleted boolean DEFAULT false NOT NULL,
    original_datetime timestamptz DEFAULT now(),
    created_at timestamptz DEFAULT now() NOT NULL,
    updated_at timestamptz DEFAULT now() NOT NULL
);

-- ── lifestyle_assets parent asset + type lookup ─────────────────────────────
CREATE TABLE IF NOT EXISTS lifestyle_assets.asset_type (
    id uuid DEFAULT gen_random_uuid() NOT NULL PRIMARY KEY,
    code varchar(50) NOT NULL UNIQUE,
    name varchar(256) NOT NULL,
    description text,
    keywords varchar[],
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);
CREATE TABLE IF NOT EXISTS lifestyle_assets.asset (
    id uuid DEFAULT gen_random_uuid() NOT NULL PRIMARY KEY,
    organization_id uuid NOT NULL,
    asset_type_id uuid NOT NULL,
    purchase_method_id uuid,
    name varchar(256) NOT NULL,
    description text,
    status varchar(100),
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ── main.valuation (lifestyle / real-estate valuation history) ──────────────
CREATE TABLE IF NOT EXISTS main.valuation (
    id uuid DEFAULT gen_random_uuid() NOT NULL PRIMARY KEY,
    asset_type varchar(50) NOT NULL,          -- 'LIFESTYLE' | 'PRIVATE_INVESTMENT' | 'REAL_ESTATE'
    asset_id uuid NOT NULL,
    amount numeric(18,2) NOT NULL,
    valuation_date timestamptz NOT NULL,
    valuation_type varchar(100),
    currency_id varchar(3) NOT NULL,
    source varchar(100),
    methodology varchar(100) NOT NULL,
    reference_number varchar(256),
    notes text,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- ── public_markets: asset + brokerage-connection chain (Java-owned tables) ──
CREATE TABLE IF NOT EXISTS public_markets.asset (
    id uuid DEFAULT gen_random_uuid() NOT NULL PRIMARY KEY,
    asset_type_id uuid,
    name varchar(255),
    ticker_symbol varchar(64),
    market_identifier_code varchar(8),
    currency_id varchar(3),
    isin varchar(12),
    last_price numeric(38,8),
    last_price_currency varchar(3),
    sector varchar(255),
    gic_sector varchar(255),
    dividend_yield numeric(10,6),
    beta numeric(10,4),
    description text,
    last_sync timestamptz,
    last_sync_status varchar(64),
    created_at timestamptz DEFAULT now() NOT NULL,
    updated_at timestamptz DEFAULT now() NOT NULL
);
CREATE TABLE IF NOT EXISTS public_markets.brokerage (
    id uuid NOT NULL PRIMARY KEY,
    code varchar(255), name varchar(255), website_url varchar(255), logo_url varchar(255),
    description text, is_recommended boolean,
    created_at timestamptz DEFAULT now(), updated_at timestamptz DEFAULT now()
);
CREATE TABLE IF NOT EXISTS public_markets.connector (
    id uuid NOT NULL PRIMARY KEY,
    code varchar(64), name varchar(255), website_url varchar(255), logo_url varchar(255),
    created_at timestamptz DEFAULT now(), updated_at timestamptz DEFAULT now()
);
CREATE TABLE IF NOT EXISTS public_markets.brokerage_connector (
    brokerage_id uuid NOT NULL,
    connector_id uuid NOT NULL,
    is_default boolean,
    created_at timestamptz DEFAULT now(), updated_at timestamptz DEFAULT now(),
    PRIMARY KEY (brokerage_id, connector_id)
);
CREATE TABLE IF NOT EXISTS public_markets.aggregator_connection (
    id uuid NOT NULL PRIMARY KEY,
    entity_id uuid NOT NULL,
    brokerage_id uuid,
    connector_id uuid,
    status varchar(64),
    snaptrade_user_id varchar(255),
    last_sync timestamptz,
    created_at timestamptz DEFAULT now(), updated_at timestamptz DEFAULT now()
);
