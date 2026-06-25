--
-- PostgreSQL database dump
--

\restrict ivjqf855Xf1mXmEAwpYA1oLiWzmfGvZBxJwQJ2czKygO7PNabb9YC6cJem9GXDV

-- Dumped from database version 15.18 (Homebrew)
-- Dumped by pg_dump version 15.18 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: audit; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA audit;


--
-- Name: dashboard; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA dashboard;


--
-- Name: entity_management; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA entity_management;


--
-- Name: family_management; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA family_management;


--
-- Name: lifestyle_assets; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA lifestyle_assets;


--
-- Name: main; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA main;


--
-- Name: notifications; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA notifications;


--
-- Name: private_investments; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA private_investments;


--
-- Name: provider_management; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA provider_management;


--
-- Name: public_markets; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public_markets;


--
-- Name: real_estate; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA real_estate;


--
-- Name: user-managment; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "user-managment";


--
-- Name: enum_dashboard_access_type; Type: TYPE; Schema: dashboard; Owner: -
--

CREATE TYPE dashboard.enum_dashboard_access_type AS ENUM (
    'READ',
    'WRITE',
    'OWNER',
    'UNASSIGNED'
);


--
-- Name: enum_source_type; Type: TYPE; Schema: dashboard; Owner: -
--

CREATE TYPE dashboard.enum_source_type AS ENUM (
    'SQL',
    'HTTP'
);


--
-- Name: enum_widget_type; Type: TYPE; Schema: dashboard; Owner: -
--

CREATE TYPE dashboard.enum_widget_type AS ENUM (
    'bar',
    'line',
    'pie',
    'summary',
    'list',
    'table',
    'tree',
    'candlestick'
);


--
-- Name: enum_family_member_address_address_type; Type: TYPE; Schema: family_management; Owner: -
--

CREATE TYPE family_management.enum_family_member_address_address_type AS ENUM (
    'PRIMARY',
    'MAILING',
    'OTHER'
);


--
-- Name: enum_family_member_family_role; Type: TYPE; Schema: family_management; Owner: -
--

CREATE TYPE family_management.enum_family_member_family_role AS ENUM (
    'PATRIARCH',
    'MATRIARCH',
    'CHILD',
    'SPOUSE'
);


--
-- Name: enum_family_member_generation; Type: TYPE; Schema: family_management; Owner: -
--

CREATE TYPE family_management.enum_family_member_generation AS ENUM (
    'G1',
    'G2',
    'G3',
    'G4',
    'G5_PLUS'
);


--
-- Name: enum_family_member_legal_capacity; Type: TYPE; Schema: family_management; Owner: -
--

CREATE TYPE family_management.enum_family_member_legal_capacity AS ENUM (
    'FULL',
    'PARTIAL',
    'INCAPACITATED'
);


--
-- Name: enum_family_member_relationship_to_wealth; Type: TYPE; Schema: family_management; Owner: -
--

CREATE TYPE family_management.enum_family_member_relationship_to_wealth AS ENUM (
    'CREATOR',
    'INHERITOR',
    'SPOUSE',
    'DESCENDANT'
);


--
-- Name: enum_family_relationship_relationship_type; Type: TYPE; Schema: family_management; Owner: -
--

CREATE TYPE family_management.enum_family_relationship_relationship_type AS ENUM (
    'FATHER',
    'MOTHER',
    'SPOUSE',
    'LEGAL_GUARDIAN',
    'DECISION_CONTROLLER',
    'CHILD',
    'SIBLING',
    'OTHER'
);


--
-- Name: enum_power_of_attorney_agent_type; Type: TYPE; Schema: family_management; Owner: -
--

CREATE TYPE family_management.enum_power_of_attorney_agent_type AS ENUM (
    'FAMILY',
    'EXTERNAL'
);


--
-- Name: enum_power_of_attorney_poa_type; Type: TYPE; Schema: family_management; Owner: -
--

CREATE TYPE family_management.enum_power_of_attorney_poa_type AS ENUM (
    'DURABLE',
    'NONDURABLE',
    'SPRINGING'
);


--
-- Name: enum_power_of_attorney_scope; Type: TYPE; Schema: family_management; Owner: -
--

CREATE TYPE family_management.enum_power_of_attorney_scope AS ENUM (
    'FINANCIAL',
    'HEALTHCARE',
    'FINANCIAL_AND_HEALTHCARE',
    'LIMITED',
    'OTHER'
);


--
-- Name: enum_asset_access_type_asset; Type: TYPE; Schema: main; Owner: -
--

CREATE TYPE main.enum_asset_access_type_asset AS ENUM (
    'account',
    'private_investments',
    'lifestyle',
    'entity',
    'real_estate'
);


--
-- Name: enum_asset_document_link_source_type; Type: TYPE; Schema: main; Owner: -
--

CREATE TYPE main.enum_asset_document_link_source_type AS ENUM (
    'loan_payment',
    'rent_collection',
    'distribution',
    'exit',
    'rate_adjustment',
    'payment_plan',
    'portfolio_company',
    'portfolio_company_update',
    'capital_call',
    'nav_update',
    'hf_subscription',
    'hf_redemption',
    'recurring_expense',
    'tenant'
);


--
-- Name: enum_document_ref_entity_type; Type: TYPE; Schema: main; Owner: -
--

CREATE TYPE main.enum_document_ref_entity_type AS ENUM (
    'provider',
    'account',
    'payment',
    'photo',
    'poa',
    'family',
    'lifestyle',
    'private-investments',
    'report',
    'entity',
    'maintenance',
    'loan',
    'valuation',
    'insurance',
    'real_estate'
);


--
-- Name: enum_financial_job_log_event_type; Type: TYPE; Schema: main; Owner: -
--

CREATE TYPE main.enum_financial_job_log_event_type AS ENUM (
    'DIVIDEND',
    'LAST_PRICE',
    'DIVIDEND_INCOME'
);


--
-- Name: enum_loan_rate_type; Type: TYPE; Schema: main; Owner: -
--

CREATE TYPE main.enum_loan_rate_type AS ENUM (
    'FIXED',
    'VARIABLE'
);


--
-- Name: enum_note_ref_type; Type: TYPE; Schema: main; Owner: -
--

CREATE TYPE main.enum_note_ref_type AS ENUM (
    'provider',
    'account',
    'payment',
    'photo',
    'poa',
    'family',
    'lifestyle',
    'private-investments',
    'report',
    'entity',
    'maintenance',
    'loan',
    'valuation',
    'insurance',
    'real_estate'
);


--
-- Name: enum_ownership_asset_type; Type: TYPE; Schema: main; Owner: -
--

CREATE TYPE main.enum_ownership_asset_type AS ENUM (
    'account',
    'private_investments',
    'lifestyle',
    'entity',
    'real_estate'
);


--
-- Name: enum_rate_adjustments_adjustment_reason; Type: TYPE; Schema: main; Owner: -
--

CREATE TYPE main.enum_rate_adjustments_adjustment_reason AS ENUM (
    'SCHEDULED',
    'RATE_CHANGE',
    'REFINANCE',
    'MODIFICATION',
    'MANUAL'
);


--
-- Name: enum_rate_adjustments_index_type; Type: TYPE; Schema: main; Owner: -
--

CREATE TYPE main.enum_rate_adjustments_index_type AS ENUM (
    'SOFR',
    'PRIME',
    'LIBOR',
    'T_BILL',
    'CMT',
    'COFI',
    'OTHER'
);


--
-- Name: enum_restore_credentials_event_name_event; Type: TYPE; Schema: main; Owner: -
--

CREATE TYPE main.enum_restore_credentials_event_name_event AS ENUM (
    'init',
    'sendRestoreLink',
    'passwordRestored'
);


--
-- Name: enum_sale_asset_type; Type: TYPE; Schema: main; Owner: -
--

CREATE TYPE main.enum_sale_asset_type AS ENUM (
    'lifestyle',
    'private_investments'
);


--
-- Name: enum_sale_buyer_type; Type: TYPE; Schema: main; Owner: -
--

CREATE TYPE main.enum_sale_buyer_type AS ENUM (
    'internal',
    'external'
);


--
-- Name: enum_sale_sale_type; Type: TYPE; Schema: main; Owner: -
--

CREATE TYPE main.enum_sale_sale_type AS ENUM (
    'full_sale',
    'partial_sale',
    'gift',
    'donation',
    'loss',
    'write_off'
);


--
-- Name: enum_users_organization_status_membership; Type: TYPE; Schema: main; Owner: -
--

CREATE TYPE main.enum_users_organization_status_membership AS ENUM (
    'invited',
    'accepted',
    'inactive'
);


--
-- Name: enum_asset_reminders_channels; Type: TYPE; Schema: notifications; Owner: -
--

CREATE TYPE notifications.enum_asset_reminders_channels AS ENUM (
    'DESKTOP',
    'EMAIL',
    'SMS',
    'PUSH'
);


--
-- Name: enum_asset_reminders_recurrence_type; Type: TYPE; Schema: notifications; Owner: -
--

CREATE TYPE notifications.enum_asset_reminders_recurrence_type AS ENUM (
    'ONE_TIME',
    'RECURRING'
);


--
-- Name: enum_asset_reminders_reminder_type; Type: TYPE; Schema: notifications; Owner: -
--

CREATE TYPE notifications.enum_asset_reminders_reminder_type AS ENUM (
    'VALUATION',
    'INSURANCE',
    'MAINTENANCE',
    'EXPENSES',
    'COMPLIANCE',
    'FLIGHT_HOURS',
    'ENGINE_HOURS',
    'MILEAGE',
    'APPRAISAL',
    'CONSERVATION',
    'AUTHENTICATION',
    'NAV_UPDATE',
    'CAPITAL_CALL',
    'DISTRIBUTION',
    'REDEMPTION_WINDOW',
    'SUBSCRIPTION_WINDOW',
    'MANAGEMENT_FEE',
    'K1_TAX',
    'FUND_REPORTING',
    'AUDIT_REPORT',
    'PORTFOLIO_REVIEW',
    'ANNUAL_MEETING',
    'DOCUMENT_EXPIRY'
);


--
-- Name: enum_email_jobs_status; Type: TYPE; Schema: notifications; Owner: -
--

CREATE TYPE notifications.enum_email_jobs_status AS ENUM (
    'SENT',
    'FAILED',
    'RETRYING'
);


--
-- Name: enum_notifications_status; Type: TYPE; Schema: notifications; Owner: -
--

CREATE TYPE notifications.enum_notifications_status AS ENUM (
    'PENDING',
    'SENT',
    'READ',
    'FAILED'
);


--
-- Name: enum_push_tokens_platform; Type: TYPE; Schema: notifications; Owner: -
--

CREATE TYPE notifications.enum_push_tokens_platform AS ENUM (
    'ios',
    'android'
);


--
-- Name: enum_asset_asset_type; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_asset_asset_type AS ENUM (
    'FUND',
    'INVESTMENT',
    'COMPANY',
    'REAL_STATE',
    'VENTURE_ROUND',
    'INFRASTRUCTURE'
);


--
-- Name: enum_asset_config_version; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_asset_config_version AS ENUM (
    'INFRASTRUCTURE_V1',
    'VENTURE_V1',
    'PRIVATE_EQUITY_V1',
    'REAL_STATE_V1',
    'FUND_V1'
);


--
-- Name: enum_asset_history_type; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_asset_history_type AS ENUM (
    'CREATE_CAPITAL_CALL',
    'CREATE_DESTRIBUTION'
);


--
-- Name: enum_distribution_type; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_distribution_type AS ENUM (
    'DIVIDEND',
    'PROFIT_DISTRIBUTION',
    'RETURN_OF_CAPITAL',
    'PERFORMANCE_FEE_REBATE'
);


--
-- Name: enum_exit_type; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_exit_type AS ENUM (
    'IPO',
    'ACQUISITION',
    'MERGER',
    'SECONDARY_SALE',
    'BUYBACK',
    'WRITE_OFF_LIQUIDATION'
);


--
-- Name: enum_fee_type; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_fee_type AS ENUM (
    'MANAGEMENT_FEE',
    'CARRY_INTEREST',
    'PERFORMANCE_FEE',
    'FUND_EXPENSES'
);


--
-- Name: enum_fund_fund_structure; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_fund_fund_structure AS ENUM (
    'LP',
    'LLC',
    'OFFSORE_FUND',
    'CORP',
    'SPV',
    'OTHER'
);


--
-- Name: enum_integration_status; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_integration_status AS ENUM (
    'PENDING',
    'DISABLED',
    'ACTIVE'
);


--
-- Name: enum_integration_type; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_integration_type AS ENUM (
    'ARCH'
);


--
-- Name: enum_intergration_events_event_type; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_intergration_events_event_type AS ENUM (
    'TRANSACTION',
    'FILES',
    'ACCOUNT',
    'ASSET',
    'VALUATION'
);


--
-- Name: enum_intergration_events_type; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_intergration_events_type AS ENUM (
    'MISSED',
    'CONFLICT'
);


--
-- Name: enum_investment_investment_format; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_investment_investment_format AS ENUM (
    'FUND',
    'FUND_SECONDARY',
    'DIRECT_SECONDARY',
    'DIRECT_CO',
    'DIRECT'
);


--
-- Name: enum_investment_projection_model; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_investment_projection_model AS ENUM (
    'TAKAHASHI_ALEXANDER'
);


--
-- Name: enum_notification_type; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_notification_type AS ENUM (
    'CAPITAL_CALL',
    'DISTRIBUTION',
    'VALUATION',
    'FUND_REPORTING',
    'K_1_TAX',
    'ANNUAL_MEETING'
);


--
-- Name: enum_projection_level; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_projection_level AS ENUM (
    'HIGH',
    'MEDIUM',
    'LOW'
);


--
-- Name: enum_projection_purpose; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_projection_purpose AS ENUM (
    'NEW_INVESTMENT'
);


--
-- Name: enum_projection_source; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_projection_source AS ENUM (
    'MY_ESTIMATION'
);


--
-- Name: enum_projection_type_date; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_projection_type_date AS ENUM (
    'QUARTER',
    'YEAR',
    'DATE'
);


--
-- Name: enum_valuation_config_version; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_valuation_config_version AS ENUM (
    'HEDGE_FUND_V1',
    'COMMON_V1',
    'ENTRY_VENTURE_V1',
    'ENNTY_COMMON_V1'
);


--
-- Name: enum_valuation_valustion_source; Type: TYPE; Schema: private_investments; Owner: -
--

CREATE TYPE private_investments.enum_valuation_valustion_source AS ENUM (
    'LATEST_FUNDING_ROUND',
    'VALUATION_409A',
    'SECONDARY_TRANSACTION',
    'THIRD_PARTY_APPRAISAL',
    'COMPARABLE_COMPANIES',
    'COMPARABLE_TRANSACTIONS',
    'DISCOUNTED_CASH_FLOW',
    'INTERNAL_ESTIMATE'
);


--
-- Name: enum_provider_assets_asset_type; Type: TYPE; Schema: provider_management; Owner: -
--

CREATE TYPE provider_management.enum_provider_assets_asset_type AS ENUM (
    'account',
    'private_investments',
    'lifestyle',
    'entity',
    'real_estate'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: requests; Type: TABLE; Schema: audit; Owner: -
--

CREATE TABLE audit.requests (
    request_id character varying(255) NOT NULL,
    user_id uuid,
    organization_id uuid,
    module_name character varying(255),
    action_name character varying(255),
    request_uri character varying(255),
    response_code integer,
    request_method character varying(255),
    created_at timestamp with time zone
);


--
-- Name: dashboard; Type: TABLE; Schema: dashboard; Owner: -
--

CREATE TABLE dashboard.dashboard (
    id uuid NOT NULL,
    name character varying(128) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    isdeleted boolean NOT NULL,
    is_global boolean DEFAULT false NOT NULL
);


--
-- Name: dashboard_access; Type: TABLE; Schema: dashboard; Owner: -
--

CREATE TABLE dashboard.dashboard_access (
    dashboard_id uuid NOT NULL,
    users_organization_id uuid NOT NULL,
    type dashboard.enum_dashboard_access_type NOT NULL,
    created_at timestamp with time zone
);


--
-- Name: dashboard_body; Type: TABLE; Schema: dashboard; Owner: -
--

CREATE TABLE dashboard.dashboard_body (
    id uuid NOT NULL,
    dashboard_id uuid NOT NULL,
    widget_id uuid NOT NULL,
    "position" jsonb NOT NULL
);


--
-- Name: filter; Type: TABLE; Schema: dashboard; Owner: -
--

CREATE TABLE dashboard.filter (
    id character varying(128) NOT NULL,
    config jsonb NOT NULL
);


--
-- Name: source; Type: TABLE; Schema: dashboard; Owner: -
--

CREATE TABLE dashboard.source (
    id uuid NOT NULL,
    type dashboard.enum_source_type NOT NULL,
    config jsonb NOT NULL,
    formatting jsonb NOT NULL
);


--
-- Name: widget; Type: TABLE; Schema: dashboard; Owner: -
--

CREATE TABLE dashboard.widget (
    id uuid NOT NULL,
    access_id character varying(128) NOT NULL,
    category_id character varying(128) NOT NULL,
    description character varying(255),
    type dashboard.enum_widget_type,
    name character varying(512) NOT NULL,
    config jsonb
);


--
-- Name: widget_category; Type: TABLE; Schema: dashboard; Owner: -
--

CREATE TABLE dashboard.widget_category (
    id character varying(128) NOT NULL,
    name character varying(512) NOT NULL
);


--
-- Name: widget_filters; Type: TABLE; Schema: dashboard; Owner: -
--

CREATE TABLE dashboard.widget_filters (
    widget_id uuid NOT NULL,
    filter_id character varying(128) NOT NULL
);


--
-- Name: widget_sources; Type: TABLE; Schema: dashboard; Owner: -
--

CREATE TABLE dashboard.widget_sources (
    widget_id uuid NOT NULL,
    source_id uuid NOT NULL
);


--
-- Name: entity_address; Type: TABLE; Schema: entity_management; Owner: -
--

CREATE TABLE entity_management.entity_address (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    entity_id uuid NOT NULL,
    address_type character varying(50) NOT NULL,
    is_primary boolean DEFAULT false NOT NULL,
    street_line_1 character varying(255) NOT NULL,
    street_line_2 character varying(255),
    city character varying(120) NOT NULL,
    state_region character varying(120),
    postal_code character varying(32) NOT NULL,
    country character varying(100) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: entity_identifier; Type: TABLE; Schema: entity_management; Owner: -
--

CREATE TABLE entity_management.entity_identifier (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    entity_id uuid NOT NULL,
    identifier_type character varying(50) NOT NULL,
    identifier_value character varying(128) NOT NULL,
    issuing_country character varying(100),
    issued_date date,
    expires_date date,
    is_primary boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: entity_member; Type: TABLE; Schema: entity_management; Owner: -
--

CREATE TABLE entity_management.entity_member (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    entity_id uuid NOT NULL,
    member_ref_type character varying(50) DEFAULT 'External'::character varying NOT NULL,
    member_ref_id uuid,
    full_name character varying(255) NOT NULL,
    email character varying(255),
    phone character varying(64),
    role character varying(80) NOT NULL,
    title character varying(120),
    start_date date,
    end_date date,
    is_primary_contact boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: entity_profile; Type: TABLE; Schema: entity_management; Owner: -
--

CREATE TABLE entity_management.entity_profile (
    entity_id uuid NOT NULL,
    legal_entity_type character varying(100) NOT NULL,
    jurisdiction_country character varying(100) NOT NULL,
    jurisdiction_state_region character varying(100),
    purpose character varying(255),
    status character varying(50) DEFAULT 'Active'::character varying NOT NULL,
    formation_date date,
    fiscal_year_end_month integer,
    fiscal_year_end_day integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: address; Type: TABLE; Schema: family_management; Owner: -
--

CREATE TABLE family_management.address (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    street_address text NOT NULL,
    street_address2 text,
    city text NOT NULL,
    country text NOT NULL,
    postal_code text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: family; Type: TABLE; Schema: family_management; Owner: -
--

CREATE TABLE family_management.family (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid,
    name text NOT NULL,
    description text,
    primary_contact_family_member_id uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: family_member; Type: TABLE; Schema: family_management; Owner: -
--

CREATE TABLE family_management.family_member (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    family_id uuid NOT NULL,
    family_member_entity_id uuid,
    full_name text NOT NULL,
    preferred_name text,
    date_of_birth date,
    email text,
    phone text,
    marital_status text,
    legal_capacity family_management.enum_family_member_legal_capacity DEFAULT 'FULL'::family_management.enum_family_member_legal_capacity,
    tax_residency text,
    citizenship text,
    generation family_management.enum_family_member_generation,
    relationship_to_wealth family_management.enum_family_member_relationship_to_wealth,
    family_role family_management.enum_family_member_family_role,
    account_user_id uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: family_member_address; Type: TABLE; Schema: family_management; Owner: -
--

CREATE TABLE family_management.family_member_address (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    family_member_id uuid NOT NULL,
    address_id uuid NOT NULL,
    address_type family_management.enum_family_member_address_address_type DEFAULT 'PRIMARY'::family_management.enum_family_member_address_address_type,
    is_primary boolean DEFAULT true,
    valid_from date,
    valid_to date,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: family_member_note; Type: TABLE; Schema: family_management; Owner: -
--

CREATE TABLE family_management.family_member_note (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    family_member_id uuid NOT NULL,
    created_by_user_id uuid NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: family_relationship; Type: TABLE; Schema: family_management; Owner: -
--

CREATE TABLE family_management.family_relationship (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    family_id uuid NOT NULL,
    from_family_member_id uuid NOT NULL,
    to_family_member_id uuid NOT NULL,
    relationship_type family_management.enum_family_relationship_relationship_type NOT NULL,
    valid_from date,
    valid_to date,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: power_of_attorney; Type: TABLE; Schema: family_management; Owner: -
--

CREATE TABLE family_management.power_of_attorney (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    principal_family_member_id uuid NOT NULL,
    agent_type family_management.enum_power_of_attorney_agent_type NOT NULL,
    agent_family_member_id uuid,
    external_agent_name text,
    document_title text NOT NULL,
    execution_date timestamp with time zone NOT NULL,
    expiration_date timestamp with time zone,
    scope family_management.enum_power_of_attorney_scope NOT NULL,
    other_scope text,
    poa_type family_management.enum_power_of_attorney_poa_type NOT NULL,
    notarized boolean DEFAULT false,
    notarized_date timestamp with time zone,
    witness_requirements boolean DEFAULT false,
    notes text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: artwork; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.artwork (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    asset_id uuid,
    type character varying(255) NOT NULL,
    artist character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    year integer,
    medium character varying(255) NOT NULL,
    purpose character varying(255) NOT NULL,
    nickname character varying(255),
    edition_size character varying(255),
    edition_type character varying(255),
    condition_id uuid NOT NULL,
    certification_id uuid,
    authenticity_id uuid,
    dimensions_id uuid NOT NULL,
    storage_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: asset_valuation_snapshot; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.asset_valuation_snapshot (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    asset_id uuid NOT NULL,
    asset_type_id uuid NOT NULL,
    asset_type_code character varying(50) NOT NULL,
    snapshot_at timestamp with time zone NOT NULL,
    native_currency_id character varying(3),
    native_amount numeric(18,2),
    fx_rate_to_home numeric(18,6),
    home_currency_code character varying(3),
    home_amount numeric(18,2),
    valuation_id uuid,
    valuation_date timestamp with time zone,
    source character varying(100),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: authenticity; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.authenticity (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    authentication_status character varying(100) NOT NULL,
    coa_on_file boolean DEFAULT false NOT NULL,
    provenance_docs_on_file boolean DEFAULT false NOT NULL,
    provenance_details text,
    authentication_method character varying(255),
    authenticated_by character varying(255),
    authentication_date timestamp with time zone,
    coa_issuer character varying(255),
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: automobile; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.automobile (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    asset_id uuid,
    category character varying(100) NOT NULL,
    make character varying(100) NOT NULL,
    model character varying(100) NOT NULL,
    year integer,
    body_style character varying(100),
    vin_number character varying(20) NOT NULL,
    distance_unit character varying(3),
    current_mileage integer,
    usage_pattern character varying(100),
    condition_id uuid NOT NULL,
    storage_id uuid NOT NULL,
    exterior_color character varying(100) NOT NULL,
    interior_color character varying(100) NOT NULL,
    maintenance_provider_id uuid,
    maintenance_interval integer,
    last_maintenance_date timestamp with time zone,
    next_maintenance_date timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: aviation; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.aviation (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    asset_id uuid,
    aircraft_type character varying(100),
    registration_number character varying(20),
    manufacturer character varying(100),
    model character varying(100),
    variant character varying(255),
    serial_number character varying(100),
    year integer,
    passenger_setting integer,
    crew_setting integer,
    current_flight_hours integer,
    expected_annual_hours integer,
    storage_id uuid,
    registration_country character varying(255),
    home_base_airport character varying(50),
    home_base_fbo character varying(255),
    management_company_id uuid,
    annual_management_fee numeric(15,2),
    management_currency_id character varying(3),
    management_contract_start timestamp with time zone,
    management_contract_end timestamp with time zone,
    maintenance_provider_id uuid,
    maintenance_interval integer,
    last_maintenance_date timestamp with time zone,
    next_maintenance_date timestamp with time zone,
    certification_id uuid,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: certification; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.certification (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    certification_type character varying(100) NOT NULL,
    issuing_body character varying(255) NOT NULL,
    certificate_number character varying(100),
    grade character varying(50),
    issue_date timestamp with time zone NOT NULL,
    expiry_date timestamp with time zone,
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: collectible; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.collectible (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    asset_id uuid NOT NULL,
    collectible_type_id uuid,
    custom_category character varying(100),
    item_type character varying(100),
    manufacturer character varying(255),
    model character varying(255),
    year integer,
    serial_number character varying(255),
    nickname character varying(255),
    special_characteristics text,
    condition_id uuid NOT NULL,
    storage_id uuid NOT NULL,
    certification_id uuid NOT NULL,
    authenticity_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: collectible_book; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.collectible_book (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    collectible_id uuid NOT NULL,
    title character varying(255),
    author character varying(255),
    publisher character varying(255),
    edition character varying(100),
    isbn character varying(50),
    issue_number numeric(10,0),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: collectible_card_game; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.collectible_card_game (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    collectible_id uuid NOT NULL,
    game_sport character varying(100),
    set_name character varying(255),
    card_name character varying(255),
    card_number numeric(10,0),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: collectible_numismatics; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.collectible_numismatics (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    collectible_id uuid NOT NULL,
    country character varying(100),
    denomination character varying(50),
    mint_mark character varying(50),
    series character varying(100),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: collectible_sport_memo; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.collectible_sport_memo (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    collectible_id uuid NOT NULL,
    sport character varying(100),
    team character varying(255),
    player character varying(255),
    season character varying(50),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: collectible_type; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.collectible_type (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: condition; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.condition (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    overall_condition character varying(100) NOT NULL,
    condition_details character varying(255)[],
    last_inspection_date timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: dimensions; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.dimensions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    height numeric(10,2),
    width numeric(10,2),
    depth numeric(10,2),
    diameter numeric(10,2),
    length numeric(10,2),
    beam numeric(10,2),
    draft numeric(10,2),
    unit character varying(20) NOT NULL,
    weight numeric(10,2),
    weight_unit character varying(20),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: jewellery; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.jewellery (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    asset_id uuid,
    type character varying(100) NOT NULL,
    designer character varying(255),
    model character varying(255),
    reference_number character varying(255),
    serial_number character varying(255),
    year integer,
    piece_nickname character varying(255),
    watch_movement_type character varying(100),
    metal_type character varying(100),
    metal_karat numeric(5,2),
    metal_weight numeric(10,2),
    metal_weight_unit character varying(20),
    gemstone_type character varying(100),
    gemstones_number numeric(10,0),
    total_carat_weight numeric(10,2),
    wear_frequency character varying(100),
    purpose character varying(100),
    condition_id uuid NOT NULL,
    storage_id uuid NOT NULL,
    certification_id uuid,
    authenticity_id uuid,
    dimensions_id uuid,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: marina_berth; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.marina_berth (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    marina_provider_id uuid NOT NULL,
    marina_name character varying(255) NOT NULL,
    marina_full_address text NOT NULL,
    berth_number character varying(50) NOT NULL,
    monthly_berth_fee numeric(10,2),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: marine; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.marine (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    asset_id uuid,
    vessel_type character varying(100) NOT NULL,
    vessel_name character varying(256) NOT NULL,
    builder character varying(100) NOT NULL,
    model character varying(100) NOT NULL,
    year integer,
    registration_number character varying(20),
    hull_number character varying(100),
    registration_country character varying(255),
    cabins integer NOT NULL,
    marina_name character varying(255),
    berth_number character varying(50),
    marina_provider_id uuid,
    monthly_berth_fee numeric(10,2),
    maintenance_provider_id uuid,
    dimensions_id uuid,
    storage_id uuid,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: storage; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.storage (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    storage_location character varying(255) NOT NULL,
    specific_location character varying(255),
    storage_conditions character varying(255)[],
    display_method character varying(100),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: warranty; Type: TABLE; Schema: lifestyle_assets; Owner: -
--

CREATE TABLE lifestyle_assets.warranty (
    id uuid NOT NULL,
    asset_id uuid NOT NULL,
    warranty_type character varying(100) NOT NULL,
    start_date timestamp with time zone NOT NULL,
    expiry_date timestamp with time zone NOT NULL,
    coverage_details text,
    provider_id uuid NOT NULL,
    warranty_number character varying(255),
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: asset_access; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.asset_access (
    type_asset main.enum_asset_access_type_asset,
    user_id uuid NOT NULL,
    asset_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: asset_document_link; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.asset_document_link (
    id uuid NOT NULL,
    asset_id uuid NOT NULL,
    document_id uuid NOT NULL,
    source_type main.enum_asset_document_link_source_type NOT NULL,
    source_id uuid NOT NULL,
    display_type character varying(100) NOT NULL,
    display_name character varying(255),
    organization_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: COLUMN asset_document_link.asset_id; Type: COMMENT; Schema: main; Owner: -
--

COMMENT ON COLUMN main.asset_document_link.asset_id IS 'Parent asset ID (private investment or lifestyle asset)';


--
-- Name: COLUMN asset_document_link.document_id; Type: COMMENT; Schema: main; Owner: -
--

COMMENT ON COLUMN main.asset_document_link.document_id IS 'Document ID from the Documents API';


--
-- Name: COLUMN asset_document_link.source_type; Type: COMMENT; Schema: main; Owner: -
--

COMMENT ON COLUMN main.asset_document_link.source_type IS 'Type of record the document was attached to';


--
-- Name: COLUMN asset_document_link.source_id; Type: COMMENT; Schema: main; Owner: -
--

COMMENT ON COLUMN main.asset_document_link.source_id IS 'ID of the specific record (loan payment, distribution, etc.)';


--
-- Name: COLUMN asset_document_link.display_type; Type: COMMENT; Schema: main; Owner: -
--

COMMENT ON COLUMN main.asset_document_link.display_type IS 'Document category/type for display';


--
-- Name: COLUMN asset_document_link.display_name; Type: COMMENT; Schema: main; Owner: -
--

COMMENT ON COLUMN main.asset_document_link.display_name IS 'User-friendly document name';


--
-- Name: COLUMN asset_document_link.organization_id; Type: COMMENT; Schema: main; Owner: -
--

COMMENT ON COLUMN main.asset_document_link.organization_id IS 'Organization ID for multi-tenancy';


--
-- Name: currency; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.currency (
    iso_code character varying(3) NOT NULL,
    name character varying(255) NOT NULL,
    symbol character varying(5) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: document; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.document (
    id uuid NOT NULL,
    display_name character varying(512),
    display_type character varying(64),
    mime_type character varying(128),
    bucket character varying(255),
    file_size_bytes integer,
    metadata jsonb,
    description character varying(50),
    expiration_date timestamp with time zone,
    created_by uuid,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: document_ref; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.document_ref (
    document_id uuid NOT NULL,
    entity_type main.enum_document_ref_entity_type NOT NULL,
    reference_id uuid NOT NULL,
    isdelete boolean DEFAULT false
);


--
-- Name: entity; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.entity (
    id uuid NOT NULL,
    organization_id uuid,
    name character varying(256),
    type character varying(50),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: financial_job_log; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.financial_job_log (
    event_id uuid NOT NULL,
    event_type main.enum_financial_job_log_event_type,
    status character varying(64),
    message jsonb,
    is_error boolean DEFAULT false,
    created_at timestamp with time zone
);


--
-- Name: insurance; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.insurance (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    entity_type character varying(50) NOT NULL,
    reference_id uuid NOT NULL,
    policy_number character varying(255) NOT NULL,
    policy_holder_id uuid NOT NULL,
    coverage_amount numeric(15,2) NOT NULL,
    currency_id character varying(3) NOT NULL,
    insurance_renewal_date timestamp with time zone NOT NULL,
    valuation_basis character varying(100),
    last_appraisal_date timestamp with time zone,
    appraiser_id uuid,
    notes text,
    policy_start_date timestamp with time zone,
    appraisal_amount numeric(15,2),
    premium_amount numeric(15,2),
    payment_frequency character varying(20),
    insurance_type character varying(30),
    deductible numeric(15,2),
    account_id uuid,
    last_premium_paid_date timestamp with time zone,
    next_premium_due_date timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: insurance_payment; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.insurance_payment (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    insurance_id uuid NOT NULL,
    payment_id uuid NOT NULL,
    created_at timestamp with time zone
);


--
-- Name: loan; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.loan (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    entity_type character varying(50) NOT NULL,
    reference_id uuid NOT NULL,
    lender_id uuid NOT NULL,
    currency_id character varying(3) NOT NULL,
    original_amount numeric(18,2) NOT NULL,
    current_balance numeric(18,2) NOT NULL,
    interest_rate numeric(8,4) NOT NULL,
    rate_type main.enum_loan_rate_type NOT NULL,
    monthly_payment numeric(18,2) NOT NULL,
    maturity_date timestamp with time zone NOT NULL,
    loan_start_date timestamp with time zone,
    loan_name character varying(255),
    loan_type character varying(50),
    payment_frequency character varying(20),
    next_payment_date timestamp with time zone,
    escrow_amount numeric(18,2),
    prepayment_penalty boolean,
    is_interest_only boolean,
    adjustment_period integer,
    rate_index character varying(50),
    rate_margin numeric(8,4),
    rate_cap numeric(8,4),
    rate_floor numeric(8,4),
    next_adjustment_date timestamp with time zone,
    last_adjustment_date timestamp with time zone,
    current_index_rate numeric(5,3),
    initial_rate numeric(5,3),
    lifetime_cap numeric(5,3),
    periodic_cap numeric(5,3),
    loan_number character varying(50),
    pmi_amount numeric(18,2),
    points numeric(5,3),
    closing_costs numeric(18,2),
    is_secured boolean,
    collateral_description character varying(500),
    notes character varying(1000),
    last_payment_date timestamp with time zone,
    total_paid_to_date numeric(18,2) DEFAULT 0,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: loan_payments; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.loan_payments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    loan_id uuid NOT NULL,
    payment_id uuid,
    principal_amount numeric(18,2),
    interest_amount numeric(18,2),
    remaining_balance numeric(18,2) NOT NULL,
    reference_number character varying(100),
    notes text,
    due_date timestamp with time zone,
    payment_number integer,
    escrow_amount numeric(18,2),
    total_amount numeric(18,2),
    amount_paid numeric(18,2),
    payment_date timestamp with time zone,
    currency_id character varying(3),
    status character varying(20),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: maintenance; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.maintenance (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    entity_type character varying(50) NOT NULL,
    reference_id uuid NOT NULL,
    category character varying(100) NOT NULL,
    provider_id uuid NOT NULL,
    maintenance_date timestamp with time zone NOT NULL,
    usage_metric_value numeric(10,2),
    location character varying(255),
    description text NOT NULL,
    cost numeric(15,2) NOT NULL,
    currency_id character varying(3) NOT NULL,
    warranty_coverage_amount numeric(15,2),
    insurance_coverage_amount numeric(15,2),
    warranty_id uuid,
    insurance_id uuid,
    insurance_deductible numeric(15,2),
    notes text,
    priority character varying(20),
    status character varying(20),
    vendor_payment_status character varying(20),
    payment_id uuid,
    payment_account_id uuid,
    custom_payment_account_name character varying(255),
    is_recurring boolean DEFAULT false,
    recurrence_frequency character varying(20),
    next_scheduled_date timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: note; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.note (
    id uuid NOT NULL,
    title text,
    content text,
    created_by uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: note_ref; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.note_ref (
    note_id uuid NOT NULL,
    type main.enum_note_ref_type NOT NULL,
    reference_id uuid NOT NULL
);


--
-- Name: organization; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.organization (
    id uuid NOT NULL,
    group_id uuid,
    name character varying(255),
    local_currency_id character varying(3) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: ownership; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.ownership (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    ownership_type character varying(100) NOT NULL,
    asset_id uuid,
    asset_type main.enum_ownership_asset_type,
    owner_id uuid,
    share_percent numeric(5,2),
    entitled_days integer,
    contract_start_date timestamp with time zone,
    contract_end_date timestamp with time zone,
    annual_management_fee numeric(15,2),
    usage_rate numeric(15,2),
    managing_partner character varying(255),
    decision_threshold numeric(5,2),
    partners jsonb,
    external_partner_name character varying(255),
    external_partner_role character varying(255),
    lessor_name character varying(255),
    lease_type character varying(100),
    lease_start_date timestamp with time zone,
    lease_end_date timestamp with time zone,
    payment_amount numeric(15,2),
    security_deposit numeric(15,2),
    lease_currency_id character varying(3),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: COLUMN ownership.id; Type: COMMENT; Schema: main; Owner: -
--

COMMENT ON COLUMN main.ownership.id IS 'Primary key for ownership record';


--
-- Name: COLUMN ownership.partners; Type: COMMENT; Schema: main; Owner: -
--

COMMENT ON COLUMN main.ownership.partners IS 'Deprecated: Use externalPartnerName/externalPartnerRole for external partners';


--
-- Name: COLUMN ownership.external_partner_name; Type: COMMENT; Schema: main; Owner: -
--

COMMENT ON COLUMN main.ownership.external_partner_name IS 'Name of external partner (when ownerId is NULL)';


--
-- Name: COLUMN ownership.external_partner_role; Type: COMMENT; Schema: main; Owner: -
--

COMMENT ON COLUMN main.ownership.external_partner_role IS 'Role of external partner (when ownerId is NULL)';


--
-- Name: COLUMN ownership.lease_currency_id; Type: COMMENT; Schema: main; Owner: -
--

COMMENT ON COLUMN main.ownership.lease_currency_id IS 'Currency for lease payment amount and security deposit';


--
-- Name: payment_asset; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.payment_asset (
    payment_id uuid NOT NULL,
    asset_type character varying(255) NOT NULL,
    asset_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: payments; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.payments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    account_id uuid,
    payment_direction character varying(20),
    payment_asset_id uuid,
    amount numeric(19,4),
    currency_id character varying(3),
    type character varying(128),
    note character varying(1024),
    status character varying(128),
    due_date timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    description character varying(128)
);


--
-- Name: permissions_users; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.permissions_users (
    role_id uuid NOT NULL,
    user_organization_id uuid,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: purchase_method; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.purchase_method (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    method_type character varying(100) NOT NULL,
    purchase_date timestamp with time zone NOT NULL,
    purchase_price numeric(15,2) NOT NULL,
    additional_costs numeric(15,2) DEFAULT 0 NOT NULL,
    currency_id character varying(3) NOT NULL,
    provider_contact_id uuid,
    reference_number character varying(255),
    exchange_details text,
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: rate_adjustments; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.rate_adjustments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    loan_id uuid NOT NULL,
    effective_date timestamp with time zone NOT NULL,
    previous_rate numeric(5,3) NOT NULL,
    new_rate numeric(5,3) NOT NULL,
    index_rate_at_adjustment numeric(5,3),
    index_type main.enum_rate_adjustments_index_type,
    previous_payment numeric(12,2) NOT NULL,
    new_payment numeric(12,2) NOT NULL,
    payment_change numeric(12,2),
    payment_change_percent numeric(5,2),
    remaining_balance numeric(14,2) NOT NULL,
    remaining_term_months integer NOT NULL,
    adjustment_reason main.enum_rate_adjustments_adjustment_reason NOT NULL,
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: restore_credentials; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.restore_credentials (
    id uuid NOT NULL,
    user_id uuid,
    created_at timestamp with time zone
);


--
-- Name: restore_credentials_event; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.restore_credentials_event (
    restore_id uuid NOT NULL,
    name_event main.enum_restore_credentials_event_name_event NOT NULL,
    status boolean NOT NULL,
    created_at timestamp with time zone
);


--
-- Name: review_payments; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.review_payments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    payment_direction character varying(255) NOT NULL,
    amount numeric(19,4) NOT NULL,
    due_date date,
    type character varying(255) NOT NULL,
    description text,
    status character varying(255),
    currency_id character varying(3) NOT NULL,
    asset_type character varying(255) NOT NULL,
    asset_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: sale; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.sale (
    id uuid NOT NULL,
    asset_id uuid NOT NULL,
    asset_type main.enum_sale_asset_type NOT NULL,
    seller_id uuid NOT NULL,
    sale_date date NOT NULL,
    sale_price numeric(19,4) NOT NULL,
    sale_currency_id character varying(3) NOT NULL,
    sale_type main.enum_sale_sale_type NOT NULL,
    percentage_sold numeric(5,2),
    additional_costs numeric(19,4),
    buyer_type main.enum_sale_buyer_type,
    buyer_id uuid,
    buyer_name character varying(255),
    buyer_contact_info text,
    reference_number character varying(255),
    notes text,
    purchase_price numeric(19,4),
    total_cost_basis numeric(19,4),
    purchase_date date,
    realized_capital_gain numeric(19,4),
    holding_period_months integer,
    historical_rental_income numeric(19,4),
    historical_expenses numeric(19,4),
    total_realized_return numeric(19,4),
    roi_percent numeric(10,4),
    annualized_roi_percent numeric(10,4),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: transaction; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.transaction (
    id uuid NOT NULL,
    entity_type character varying(50) NOT NULL,
    reference_id uuid NOT NULL,
    transaction_type character varying(20) NOT NULL,
    category character varying(50) NOT NULL,
    amount numeric(18,2) NOT NULL,
    currency_id character varying(3) NOT NULL,
    transaction_date timestamp with time zone NOT NULL,
    description text,
    payee character varying(255),
    status character varying(20) DEFAULT 'completed'::character varying NOT NULL,
    external_reference character varying(255),
    notes text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: user; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main."user" (
    id uuid NOT NULL,
    photo_id uuid,
    enabled boolean DEFAULT true,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    is_external boolean DEFAULT false
);


--
-- Name: users_organization; Type: TABLE; Schema: main; Owner: -
--

CREATE TABLE main.users_organization (
    id uuid NOT NULL,
    user_id uuid,
    organization_id uuid,
    role_id uuid,
    status_membership main.enum_users_organization_status_membership DEFAULT 'invited'::main.enum_users_organization_status_membership,
    not_before timestamp with time zone
);


--
-- Name: asset_reminders; Type: TABLE; Schema: notifications; Owner: -
--

CREATE TABLE notifications.asset_reminders (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    asset_module character varying(255) NOT NULL,
    asset_id uuid NOT NULL,
    reminder_type notifications.enum_asset_reminders_reminder_type NOT NULL,
    title character varying(255) NOT NULL,
    body text,
    channels notifications.enum_asset_reminders_channels[] NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    recurrence_type notifications.enum_asset_reminders_recurrence_type NOT NULL,
    recurrence_interval_days integer,
    start_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: email_jobs; Type: TABLE; Schema: notifications; Owner: -
--

CREATE TABLE notifications.email_jobs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    job_id uuid NOT NULL,
    to_email character varying(255)[] NOT NULL,
    subject text NOT NULL,
    status notifications.enum_email_jobs_status NOT NULL,
    retries integer DEFAULT 0 NOT NULL,
    error_message text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: notifications; Type: TABLE; Schema: notifications; Owner: -
--

CREATE TABLE notifications.notifications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    user_id uuid NOT NULL,
    module_name character varying(255),
    title character varying(255) NOT NULL,
    body text,
    status notifications.enum_notifications_status DEFAULT 'PENDING'::notifications.enum_notifications_status NOT NULL,
    scheduled_for timestamp with time zone,
    sent_at timestamp with time zone,
    read_at timestamp with time zone,
    reminder_id uuid,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: push_tokens; Type: TABLE; Schema: notifications; Owner: -
--

CREATE TABLE notifications.push_tokens (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    organization_id uuid NOT NULL,
    token character varying(255) NOT NULL,
    platform notifications.enum_push_tokens_platform NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: reminder_recipients; Type: TABLE; Schema: notifications; Owner: -
--

CREATE TABLE notifications.reminder_recipients (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    reminder_id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: asset; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.asset (
    id uuid NOT NULL,
    asset_type private_investments.enum_asset_asset_type NOT NULL,
    investment_id uuid NOT NULL,
    currency character varying(3),
    name character varying(512),
    description character varying(2048),
    ownership double precision,
    amount numeric(38,8),
    config_version private_investments.enum_asset_config_version,
    config jsonb,
    is_deleted boolean DEFAULT false NOT NULL,
    date timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: asset_history; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.asset_history (
    id uuid NOT NULL,
    investment_id uuid,
    user_id uuid,
    type private_investments.enum_asset_history_type,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: capital_call; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.capital_call (
    id uuid NOT NULL,
    transaction_id uuid NOT NULL,
    due_date timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: distribution; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.distribution (
    id uuid NOT NULL,
    type private_investments.enum_distribution_type NOT NULL,
    transaction_id uuid NOT NULL,
    is_recallable boolean DEFAULT false NOT NULL,
    recallable_amount numeric(38,8),
    recallable_last_date timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: exit; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.exit (
    id uuid NOT NULL,
    type private_investments.enum_exit_type NOT NULL,
    percent numeric(8,4),
    transaction_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: fee; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.fee (
    id uuid NOT NULL,
    type private_investments.enum_fee_type NOT NULL,
    transaction_id uuid NOT NULL,
    taxed_transaction_id uuid,
    basis_amount numeric(38,8) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: fund; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.fund (
    id uuid NOT NULL,
    name character varying(256) NOT NULL,
    organization_id uuid NOT NULL,
    fund_structure private_investments.enum_fund_fund_structure,
    dominical character varying(256),
    size numeric(38,8),
    vintige_year integer,
    currency character varying(3) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: integration; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.integration (
    id uuid NOT NULL,
    investment_id uuid,
    external_id character varying(256) NOT NULL,
    type private_investments.enum_integration_type NOT NULL,
    status private_investments.enum_integration_status NOT NULL
);


--
-- Name: intergration_events; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.intergration_events (
    integration_id character varying(255) NOT NULL,
    internal_id character varying(255) NOT NULL,
    external_id character varying(255),
    is_solved boolean NOT NULL,
    type private_investments.enum_intergration_events_type NOT NULL,
    event_type private_investments.enum_intergration_events_event_type NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: investment; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.investment (
    id uuid NOT NULL,
    organization_id uuid NOT NULL,
    investment_type character varying(128) NOT NULL,
    name character varying(512),
    investment_format private_investments.enum_investment_investment_format NOT NULL,
    sponsor_id uuid,
    sponsor_name character varying(256),
    fee_config jsonb DEFAULT '{}'::jsonb,
    term_config jsonb DEFAULT '{}'::jsonb,
    provision_config jsonb DEFAULT '{}'::jsonb,
    right_config jsonb DEFAULT '{}'::jsonb,
    is_deleted boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: investment_fund; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.investment_fund (
    id uuid NOT NULL,
    fund_id uuid NOT NULL,
    general_partner_id uuid,
    fund_stratagy character varying(256),
    investment_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: investment_projection; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.investment_projection (
    id uuid NOT NULL,
    model private_investments.enum_investment_projection_model NOT NULL,
    investment_id uuid NOT NULL,
    config jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: investment_type; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.investment_type (
    id character varying(128) NOT NULL,
    name character varying(512) NOT NULL
);


--
-- Name: notification; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.notification (
    investment_id uuid NOT NULL,
    type private_investments.enum_notification_type NOT NULL,
    is_avtive boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: projection; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.projection (
    id uuid NOT NULL,
    investment_id uuid NOT NULL,
    type_date private_investments.enum_projection_type_date,
    quarter integer,
    year integer,
    date timestamp with time zone,
    is_range boolean DEFAULT false NOT NULL,
    amount_from numeric(38,8),
    amount_to numeric(38,8),
    purpose private_investments.enum_projection_purpose,
    source private_investments.enum_projection_source NOT NULL,
    level private_investments.enum_projection_level NOT NULL,
    description character varying(1024),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: redemption; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.redemption (
    id uuid NOT NULL,
    transaction_id uuid NOT NULL,
    effective_date timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: subscription; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.subscription (
    id uuid NOT NULL,
    transaction_id uuid NOT NULL,
    effective_date timestamp with time zone,
    nav_per_share numeric(38,8),
    shares_purchased numeric(38,8),
    share_class character varying(255),
    lockup_expiration timestamp with time zone,
    early_redemption_penalty numeric(8,4),
    high_water_mark numeric(38,8),
    hwm_date timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: transaction_payment; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.transaction_payment (
    id uuid NOT NULL,
    transaction_id uuid NOT NULL,
    payment_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: valuation; Type: TABLE; Schema: private_investments; Owner: -
--

CREATE TABLE private_investments.valuation (
    id uuid NOT NULL,
    asset_id uuid NOT NULL,
    currency character varying(3) NOT NULL,
    amount numeric(38,8) NOT NULL,
    unrealized_gain numeric(38,8),
    realized_gain numeric(38,8),
    is_nav boolean DEFAULT false NOT NULL,
    is_entry boolean DEFAULT false NOT NULL,
    valustion_source private_investments.enum_valuation_valustion_source,
    config_version private_investments.enum_valuation_config_version,
    config jsonb,
    valuation_timestamp timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false
);


--
-- Name: provider; Type: TABLE; Schema: provider_management; Owner: -
--

CREATE TABLE provider_management.provider (
    id uuid NOT NULL,
    entity_id uuid,
    provider_category_id uuid,
    name character varying(255),
    is_draft boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: provider_assets; Type: TABLE; Schema: provider_management; Owner: -
--

CREATE TABLE provider_management.provider_assets (
    provider_id uuid NOT NULL,
    asset_type provider_management.enum_provider_assets_asset_type NOT NULL,
    asset_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: provider_contact; Type: TABLE; Schema: provider_management; Owner: -
--

CREATE TABLE provider_management.provider_contact (
    id uuid NOT NULL,
    provider_id uuid NOT NULL,
    is_primary boolean DEFAULT false NOT NULL,
    full_name character varying(255) NOT NULL,
    title character varying(128),
    department character varying(128),
    email character varying(512),
    phone character varying(64),
    secondary_contact character varying(64),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: provider_document; Type: TABLE; Schema: provider_management; Owner: -
--

CREATE TABLE provider_management.provider_document (
    provider_id uuid,
    document_id uuid,
    "documentId" uuid NOT NULL,
    "providerId" uuid NOT NULL
);


--
-- Name: account; Type: TABLE; Schema: public_markets; Owner: -
--

CREATE TABLE public_markets.account (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    entity_id uuid NOT NULL,
    account_type character varying(64),
    account_subtype character varying(64),
    note character varying(1024),
    currency_id character varying(3),
    status character varying(64),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    account_mask character varying(255),
    external_current_balance numeric(19,2),
    plaid_account_id character varying(255),
    snaptrade_account_id character varying(255),
    aggregator_connection_id uuid,
    last_sync timestamp with time zone,
    import_source character varying(50),
    last_sync_status character varying(50),
    account_name character varying(550)
);


--
-- Name: asset_type; Type: TABLE; Schema: public_markets; Owner: -
--

CREATE TABLE public_markets.asset_type (
    id uuid NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(256) NOT NULL,
    description text,
    keywords character varying(255)[],
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: dividend; Type: TABLE; Schema: public_markets; Owner: -
--

CREATE TABLE public_markets.dividend (
    id character varying(128) NOT NULL,
    ticker_symbol character varying(64),
    amount numeric(38,8),
    "declarationDate" timestamp with time zone,
    "paymentDate" timestamp with time zone,
    currency character varying(3),
    period character varying(64),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: holding; Type: TABLE; Schema: public_markets; Owner: -
--

CREATE TABLE public_markets.holding (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    account_id uuid NOT NULL,
    asset_id uuid NOT NULL,
    quantity numeric(38,8) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    status character varying(50),
    last_sync timestamp with time zone,
    last_sync_status character varying(50),
    price numeric(19,2),
    open_pnl numeric(19,2),
    average_purchase_price numeric(19,2)
);


--
-- Name: holding_snapshot; Type: TABLE; Schema: public_markets; Owner: -
--

CREATE TABLE public_markets.holding_snapshot (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    holding_id uuid NOT NULL,
    account_id uuid NOT NULL,
    currency_id character varying(3),
    asset_id uuid NOT NULL,
    quantity numeric(18,8) NOT NULL,
    price numeric(18,8),
    snapshot_timestamp timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: org_dividend_income; Type: TABLE; Schema: public_markets; Owner: -
--

CREATE TABLE public_markets.org_dividend_income (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    payment_date timestamp with time zone NOT NULL,
    ticker_symbol character varying(64) NOT NULL,
    amount_per_share numeric(38,8) NOT NULL,
    quantity_held numeric(38,8) NOT NULL,
    gross_income numeric(38,8) NOT NULL,
    currency character varying(3) NOT NULL,
    gross_income_local numeric(38,8),
    local_currency character varying(3),
    calculated_at timestamp with time zone DEFAULT now()
);


--
-- Name: property; Type: TABLE; Schema: real_estate; Owner: -
--

CREATE TABLE real_estate.property (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    property_type character varying(255) NOT NULL,
    status character varying(255) DEFAULT 'OWNED'::character varying NOT NULL,
    usage_type character varying(255),
    address_id uuid,
    acquisition_date date,
    acquisition_price numeric(18,2),
    acquisition_currency_id character varying(3),
    closing_costs numeric(18,2),
    disposition_date date,
    disposition_price numeric(18,2),
    parcel_number character varying(255),
    year_built integer,
    square_footage_interior numeric(12,2),
    lot_size_sqft numeric(12,2),
    bedrooms integer,
    bathrooms numeric(4,1),
    parking_spaces integer,
    zoning character varying(255),
    featured_image_document_id uuid,
    notes text,
    config jsonb,
    is_deleted boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: property_address; Type: TABLE; Schema: real_estate; Owner: -
--

CREATE TABLE real_estate.property_address (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    street_address_1 character varying(255),
    street_address_2 character varying(255),
    city character varying(255),
    state_region character varying(255),
    postal_code character varying(255),
    country character varying(255),
    latitude numeric(10,7),
    longitude numeric(10,7),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: property_valuation_snapshot; Type: TABLE; Schema: real_estate; Owner: -
--

CREATE TABLE real_estate.property_valuation_snapshot (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    property_id uuid NOT NULL,
    snapshot_at timestamp with time zone NOT NULL,
    valuation_amount numeric(18,2) NOT NULL,
    currency_id character varying(3) NOT NULL,
    methodology character varying(50),
    source_valuation_id uuid,
    created_at timestamp with time zone NOT NULL
);


--
-- Name: rental_lease; Type: TABLE; Schema: real_estate; Owner: -
--

CREATE TABLE real_estate.rental_lease (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    property_id uuid NOT NULL,
    tenant_name character varying(255) NOT NULL,
    tenant_contact jsonb,
    lease_start_date date NOT NULL,
    lease_end_date date,
    rent_amount numeric(18,2) NOT NULL,
    rent_currency_id character varying(3) NOT NULL,
    rent_frequency character varying(255) DEFAULT 'MONTHLY'::character varying NOT NULL,
    payment_day_of_month smallint,
    security_deposit numeric(18,2),
    status character varying(255) DEFAULT 'ACTIVE'::character varying NOT NULL,
    lease_document_id uuid,
    auto_generate_payments boolean DEFAULT false NOT NULL,
    notes text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: access; Type: TABLE; Schema: user-managment; Owner: -
--

CREATE TABLE "user-managment".access (
    id character varying(255) NOT NULL,
    display_name character varying(255),
    parent_id character varying(255),
    request_uri_template jsonb,
    is_child boolean DEFAULT false,
    is_hide boolean DEFAULT false
);


--
-- Name: role; Type: TABLE; Schema: user-managment; Owner: -
--

CREATE TABLE "user-managment".role (
    id uuid NOT NULL,
    display_name character varying(255)
);


--
-- Name: role_access; Type: TABLE; Schema: user-managment; Owner: -
--

CREATE TABLE "user-managment".role_access (
    role_id uuid NOT NULL,
    access_id character varying(255)
);


--
-- Name: users_organization_access; Type: TABLE; Schema: user-managment; Owner: -
--

CREATE TABLE "user-managment".users_organization_access (
    access_id character varying(255) NOT NULL,
    users_organization_id uuid NOT NULL,
    enabled boolean DEFAULT true,
    created_at timestamp with time zone
);


--
-- Name: requests requests_pkey; Type: CONSTRAINT; Schema: audit; Owner: -
--

ALTER TABLE ONLY audit.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (request_id);


--
-- Name: dashboard_access dashboard_access_pkey; Type: CONSTRAINT; Schema: dashboard; Owner: -
--

ALTER TABLE ONLY dashboard.dashboard_access
    ADD CONSTRAINT dashboard_access_pkey PRIMARY KEY (dashboard_id, users_organization_id);


--
-- Name: dashboard_body dashboard_body_dashboard_id_widget_id_key; Type: CONSTRAINT; Schema: dashboard; Owner: -
--

ALTER TABLE ONLY dashboard.dashboard_body
    ADD CONSTRAINT dashboard_body_dashboard_id_widget_id_key UNIQUE (dashboard_id, widget_id);


--
-- Name: dashboard_body dashboard_body_pkey; Type: CONSTRAINT; Schema: dashboard; Owner: -
--

ALTER TABLE ONLY dashboard.dashboard_body
    ADD CONSTRAINT dashboard_body_pkey PRIMARY KEY (id);


--
-- Name: dashboard dashboard_pkey; Type: CONSTRAINT; Schema: dashboard; Owner: -
--

ALTER TABLE ONLY dashboard.dashboard
    ADD CONSTRAINT dashboard_pkey PRIMARY KEY (id);


--
-- Name: filter filter_pkey; Type: CONSTRAINT; Schema: dashboard; Owner: -
--

ALTER TABLE ONLY dashboard.filter
    ADD CONSTRAINT filter_pkey PRIMARY KEY (id);


--
-- Name: source source_pkey; Type: CONSTRAINT; Schema: dashboard; Owner: -
--

ALTER TABLE ONLY dashboard.source
    ADD CONSTRAINT source_pkey PRIMARY KEY (id);


--
-- Name: widget_category widget_category_pkey; Type: CONSTRAINT; Schema: dashboard; Owner: -
--

ALTER TABLE ONLY dashboard.widget_category
    ADD CONSTRAINT widget_category_pkey PRIMARY KEY (id);


--
-- Name: widget_filters widget_filters_pkey; Type: CONSTRAINT; Schema: dashboard; Owner: -
--

ALTER TABLE ONLY dashboard.widget_filters
    ADD CONSTRAINT widget_filters_pkey PRIMARY KEY (widget_id, filter_id);


--
-- Name: widget widget_pkey; Type: CONSTRAINT; Schema: dashboard; Owner: -
--

ALTER TABLE ONLY dashboard.widget
    ADD CONSTRAINT widget_pkey PRIMARY KEY (id);


--
-- Name: widget_sources widget_sources_pkey; Type: CONSTRAINT; Schema: dashboard; Owner: -
--

ALTER TABLE ONLY dashboard.widget_sources
    ADD CONSTRAINT widget_sources_pkey PRIMARY KEY (widget_id, source_id);


--
-- Name: entity_address entity_address_pkey; Type: CONSTRAINT; Schema: entity_management; Owner: -
--

ALTER TABLE ONLY entity_management.entity_address
    ADD CONSTRAINT entity_address_pkey PRIMARY KEY (id);


--
-- Name: entity_identifier entity_identifier_pkey; Type: CONSTRAINT; Schema: entity_management; Owner: -
--

ALTER TABLE ONLY entity_management.entity_identifier
    ADD CONSTRAINT entity_identifier_pkey PRIMARY KEY (id);


--
-- Name: entity_member entity_member_pkey; Type: CONSTRAINT; Schema: entity_management; Owner: -
--

ALTER TABLE ONLY entity_management.entity_member
    ADD CONSTRAINT entity_member_pkey PRIMARY KEY (id);


--
-- Name: entity_profile entity_profile_pkey; Type: CONSTRAINT; Schema: entity_management; Owner: -
--

ALTER TABLE ONLY entity_management.entity_profile
    ADD CONSTRAINT entity_profile_pkey PRIMARY KEY (entity_id);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: family_management; Owner: -
--

ALTER TABLE ONLY family_management.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: family_member_address family_member_address_pkey; Type: CONSTRAINT; Schema: family_management; Owner: -
--

ALTER TABLE ONLY family_management.family_member_address
    ADD CONSTRAINT family_member_address_pkey PRIMARY KEY (id);


--
-- Name: family_member_note family_member_note_pkey; Type: CONSTRAINT; Schema: family_management; Owner: -
--

ALTER TABLE ONLY family_management.family_member_note
    ADD CONSTRAINT family_member_note_pkey PRIMARY KEY (id);


--
-- Name: family_member family_member_pkey; Type: CONSTRAINT; Schema: family_management; Owner: -
--

ALTER TABLE ONLY family_management.family_member
    ADD CONSTRAINT family_member_pkey PRIMARY KEY (id);


--
-- Name: family family_pkey; Type: CONSTRAINT; Schema: family_management; Owner: -
--

ALTER TABLE ONLY family_management.family
    ADD CONSTRAINT family_pkey PRIMARY KEY (id);


--
-- Name: family_relationship family_relationship_pkey; Type: CONSTRAINT; Schema: family_management; Owner: -
--

ALTER TABLE ONLY family_management.family_relationship
    ADD CONSTRAINT family_relationship_pkey PRIMARY KEY (id);


--
-- Name: power_of_attorney power_of_attorney_pkey; Type: CONSTRAINT; Schema: family_management; Owner: -
--

ALTER TABLE ONLY family_management.power_of_attorney
    ADD CONSTRAINT power_of_attorney_pkey PRIMARY KEY (id);


--
-- Name: artwork artwork_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.artwork
    ADD CONSTRAINT artwork_pkey PRIMARY KEY (id);


--
-- Name: asset_valuation_snapshot asset_valuation_snapshot_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.asset_valuation_snapshot
    ADD CONSTRAINT asset_valuation_snapshot_pkey PRIMARY KEY (id);


--
-- Name: authenticity authenticity_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.authenticity
    ADD CONSTRAINT authenticity_pkey PRIMARY KEY (id);


--
-- Name: automobile automobile_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.automobile
    ADD CONSTRAINT automobile_pkey PRIMARY KEY (id);


--
-- Name: aviation aviation_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.aviation
    ADD CONSTRAINT aviation_pkey PRIMARY KEY (id);


--
-- Name: certification certification_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.certification
    ADD CONSTRAINT certification_pkey PRIMARY KEY (id);


--
-- Name: collectible_book collectible_book_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.collectible_book
    ADD CONSTRAINT collectible_book_pkey PRIMARY KEY (id);


--
-- Name: collectible_card_game collectible_card_game_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.collectible_card_game
    ADD CONSTRAINT collectible_card_game_pkey PRIMARY KEY (id);


--
-- Name: collectible_numismatics collectible_numismatics_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.collectible_numismatics
    ADD CONSTRAINT collectible_numismatics_pkey PRIMARY KEY (id);


--
-- Name: collectible collectible_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.collectible
    ADD CONSTRAINT collectible_pkey PRIMARY KEY (id);


--
-- Name: collectible_sport_memo collectible_sport_memo_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.collectible_sport_memo
    ADD CONSTRAINT collectible_sport_memo_pkey PRIMARY KEY (id);


--
-- Name: collectible_type collectible_type_code_key; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.collectible_type
    ADD CONSTRAINT collectible_type_code_key UNIQUE (code);


--
-- Name: collectible_type collectible_type_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.collectible_type
    ADD CONSTRAINT collectible_type_pkey PRIMARY KEY (id);


--
-- Name: condition condition_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.condition
    ADD CONSTRAINT condition_pkey PRIMARY KEY (id);


--
-- Name: dimensions dimensions_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.dimensions
    ADD CONSTRAINT dimensions_pkey PRIMARY KEY (id);


--
-- Name: jewellery jewellery_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.jewellery
    ADD CONSTRAINT jewellery_pkey PRIMARY KEY (id);


--
-- Name: marina_berth marina_berth_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.marina_berth
    ADD CONSTRAINT marina_berth_pkey PRIMARY KEY (id);


--
-- Name: marine marine_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.marine
    ADD CONSTRAINT marine_pkey PRIMARY KEY (id);


--
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (id);


--
-- Name: warranty warranty_pkey; Type: CONSTRAINT; Schema: lifestyle_assets; Owner: -
--

ALTER TABLE ONLY lifestyle_assets.warranty
    ADD CONSTRAINT warranty_pkey PRIMARY KEY (id);


--
-- Name: asset_access asset_access_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.asset_access
    ADD CONSTRAINT asset_access_pkey PRIMARY KEY (user_id, asset_id);


--
-- Name: asset_document_link asset_document_link_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.asset_document_link
    ADD CONSTRAINT asset_document_link_pkey PRIMARY KEY (id);


--
-- Name: currency currency_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (iso_code);


--
-- Name: document document_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.document
    ADD CONSTRAINT document_pkey PRIMARY KEY (id);


--
-- Name: document_ref document_ref_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.document_ref
    ADD CONSTRAINT document_ref_pkey PRIMARY KEY (document_id, entity_type, reference_id);


--
-- Name: entity entity_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.entity
    ADD CONSTRAINT entity_pkey PRIMARY KEY (id);


--
-- Name: financial_job_log financial_job_log_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.financial_job_log
    ADD CONSTRAINT financial_job_log_pkey PRIMARY KEY (event_id);


--
-- Name: insurance_payment insurance_payment_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.insurance_payment
    ADD CONSTRAINT insurance_payment_pkey PRIMARY KEY (id);


--
-- Name: insurance insurance_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.insurance
    ADD CONSTRAINT insurance_pkey PRIMARY KEY (id);


--
-- Name: loan_payments loan_payments_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.loan_payments
    ADD CONSTRAINT loan_payments_pkey PRIMARY KEY (id);


--
-- Name: loan loan_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.loan
    ADD CONSTRAINT loan_pkey PRIMARY KEY (id);


--
-- Name: maintenance maintenance_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.maintenance
    ADD CONSTRAINT maintenance_pkey PRIMARY KEY (id);


--
-- Name: note note_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.note
    ADD CONSTRAINT note_pkey PRIMARY KEY (id);


--
-- Name: note_ref note_ref_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.note_ref
    ADD CONSTRAINT note_ref_pkey PRIMARY KEY (note_id, type, reference_id);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- Name: ownership ownership_owner_id_asset_id_key; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.ownership
    ADD CONSTRAINT ownership_owner_id_asset_id_key UNIQUE (owner_id, asset_id);


--
-- Name: ownership ownership_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.ownership
    ADD CONSTRAINT ownership_pkey PRIMARY KEY (id);


--
-- Name: payment_asset payment_asset_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.payment_asset
    ADD CONSTRAINT payment_asset_pkey PRIMARY KEY (payment_id, asset_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: permissions_users permissions_users_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.permissions_users
    ADD CONSTRAINT permissions_users_pkey PRIMARY KEY (role_id);


--
-- Name: purchase_method purchase_method_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.purchase_method
    ADD CONSTRAINT purchase_method_pkey PRIMARY KEY (id);


--
-- Name: rate_adjustments rate_adjustments_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.rate_adjustments
    ADD CONSTRAINT rate_adjustments_pkey PRIMARY KEY (id);


--
-- Name: restore_credentials_event restore_credentials_event_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.restore_credentials_event
    ADD CONSTRAINT restore_credentials_event_pkey PRIMARY KEY (restore_id, name_event);


--
-- Name: restore_credentials restore_credentials_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.restore_credentials
    ADD CONSTRAINT restore_credentials_pkey PRIMARY KEY (id);


--
-- Name: review_payments review_payments_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.review_payments
    ADD CONSTRAINT review_payments_pkey PRIMARY KEY (id);


--
-- Name: sale sale_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.sale
    ADD CONSTRAINT sale_pkey PRIMARY KEY (id);


--
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: users_organization users_organization_pkey; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.users_organization
    ADD CONSTRAINT users_organization_pkey PRIMARY KEY (id);


--
-- Name: users_organization users_organization_user_id_organization_id_key; Type: CONSTRAINT; Schema: main; Owner: -
--

ALTER TABLE ONLY main.users_organization
    ADD CONSTRAINT users_organization_user_id_organization_id_key UNIQUE (user_id, organization_id);


--
-- Name: asset_reminders asset_reminders_pkey; Type: CONSTRAINT; Schema: notifications; Owner: -
--

ALTER TABLE ONLY notifications.asset_reminders
    ADD CONSTRAINT asset_reminders_pkey PRIMARY KEY (id);


--
-- Name: email_jobs email_jobs_pkey; Type: CONSTRAINT; Schema: notifications; Owner: -
--

ALTER TABLE ONLY notifications.email_jobs
    ADD CONSTRAINT email_jobs_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: notifications; Owner: -
--

ALTER TABLE ONLY notifications.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: push_tokens push_tokens_pkey; Type: CONSTRAINT; Schema: notifications; Owner: -
--

ALTER TABLE ONLY notifications.push_tokens
    ADD CONSTRAINT push_tokens_pkey PRIMARY KEY (id);


--
-- Name: push_tokens push_tokens_token_key; Type: CONSTRAINT; Schema: notifications; Owner: -
--

ALTER TABLE ONLY notifications.push_tokens
    ADD CONSTRAINT push_tokens_token_key UNIQUE (token);


--
-- Name: reminder_recipients reminder_recipients_pkey; Type: CONSTRAINT; Schema: notifications; Owner: -
--

ALTER TABLE ONLY notifications.reminder_recipients
    ADD CONSTRAINT reminder_recipients_pkey PRIMARY KEY (id);


--
-- Name: asset_history asset_history_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.asset_history
    ADD CONSTRAINT asset_history_pkey PRIMARY KEY (id);


--
-- Name: asset asset_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.asset
    ADD CONSTRAINT asset_pkey PRIMARY KEY (id);


--
-- Name: capital_call capital_call_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.capital_call
    ADD CONSTRAINT capital_call_pkey PRIMARY KEY (id);


--
-- Name: distribution distribution_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.distribution
    ADD CONSTRAINT distribution_pkey PRIMARY KEY (id);


--
-- Name: exit exit_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.exit
    ADD CONSTRAINT exit_pkey PRIMARY KEY (id);


--
-- Name: fee fee_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.fee
    ADD CONSTRAINT fee_pkey PRIMARY KEY (id);


--
-- Name: fund fund_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.fund
    ADD CONSTRAINT fund_pkey PRIMARY KEY (id);


--
-- Name: integration integration_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.integration
    ADD CONSTRAINT integration_pkey PRIMARY KEY (id);


--
-- Name: intergration_events intergration_events_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.intergration_events
    ADD CONSTRAINT intergration_events_pkey PRIMARY KEY (integration_id, internal_id);


--
-- Name: investment_fund investment_fund_fund_id_investment_id_key; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.investment_fund
    ADD CONSTRAINT investment_fund_fund_id_investment_id_key UNIQUE (fund_id, investment_id);


--
-- Name: investment_fund investment_fund_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.investment_fund
    ADD CONSTRAINT investment_fund_pkey PRIMARY KEY (id);


--
-- Name: investment investment_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.investment
    ADD CONSTRAINT investment_pkey PRIMARY KEY (id);


--
-- Name: investment_projection investment_projection_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.investment_projection
    ADD CONSTRAINT investment_projection_pkey PRIMARY KEY (id);


--
-- Name: investment_type investment_type_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.investment_type
    ADD CONSTRAINT investment_type_pkey PRIMARY KEY (id);


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (investment_id, type);


--
-- Name: projection projection_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.projection
    ADD CONSTRAINT projection_pkey PRIMARY KEY (id);


--
-- Name: redemption redemption_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.redemption
    ADD CONSTRAINT redemption_pkey PRIMARY KEY (id);


--
-- Name: subscription subscription_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (id);


--
-- Name: transaction_payment transaction_payment_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.transaction_payment
    ADD CONSTRAINT transaction_payment_pkey PRIMARY KEY (id);


--
-- Name: transaction_payment transaction_payment_transaction_id_payment_id_key; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.transaction_payment
    ADD CONSTRAINT transaction_payment_transaction_id_payment_id_key UNIQUE (transaction_id, payment_id);


--
-- Name: valuation valuation_pkey; Type: CONSTRAINT; Schema: private_investments; Owner: -
--

ALTER TABLE ONLY private_investments.valuation
    ADD CONSTRAINT valuation_pkey PRIMARY KEY (id);


--
-- Name: provider_assets provider_assets_pkey; Type: CONSTRAINT; Schema: provider_management; Owner: -
--

ALTER TABLE ONLY provider_management.provider_assets
    ADD CONSTRAINT provider_assets_pkey PRIMARY KEY (provider_id, asset_id);


--
-- Name: provider_contact provider_contact_pkey; Type: CONSTRAINT; Schema: provider_management; Owner: -
--

ALTER TABLE ONLY provider_management.provider_contact
    ADD CONSTRAINT provider_contact_pkey PRIMARY KEY (id);


--
-- Name: provider_document provider_document_pkey; Type: CONSTRAINT; Schema: provider_management; Owner: -
--

ALTER TABLE ONLY provider_management.provider_document
    ADD CONSTRAINT provider_document_pkey PRIMARY KEY ("documentId", "providerId");


--
-- Name: provider provider_pkey; Type: CONSTRAINT; Schema: provider_management; Owner: -
--

ALTER TABLE ONLY provider_management.provider
    ADD CONSTRAINT provider_pkey PRIMARY KEY (id);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public_markets; Owner: -
--

ALTER TABLE ONLY public_markets.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: account account_plaid_account_id_key; Type: CONSTRAINT; Schema: public_markets; Owner: -
--

ALTER TABLE ONLY public_markets.account
    ADD CONSTRAINT account_plaid_account_id_key UNIQUE (plaid_account_id);


--
-- Name: account account_snaptrade_account_id_key; Type: CONSTRAINT; Schema: public_markets; Owner: -
--

ALTER TABLE ONLY public_markets.account
    ADD CONSTRAINT account_snaptrade_account_id_key UNIQUE (snaptrade_account_id);


--
-- Name: asset_type asset_type_code_key; Type: CONSTRAINT; Schema: public_markets; Owner: -
--

ALTER TABLE ONLY public_markets.asset_type
    ADD CONSTRAINT asset_type_code_key UNIQUE (code);


--
-- Name: asset_type asset_type_pkey; Type: CONSTRAINT; Schema: public_markets; Owner: -
--

ALTER TABLE ONLY public_markets.asset_type
    ADD CONSTRAINT asset_type_pkey PRIMARY KEY (id);


--
-- Name: dividend dividend_pkey; Type: CONSTRAINT; Schema: public_markets; Owner: -
--

ALTER TABLE ONLY public_markets.dividend
    ADD CONSTRAINT dividend_pkey PRIMARY KEY (id);


--
-- Name: holding holding_account_id_asset_id_key; Type: CONSTRAINT; Schema: public_markets; Owner: -
--

ALTER TABLE ONLY public_markets.holding
    ADD CONSTRAINT holding_account_id_asset_id_key UNIQUE (account_id, asset_id);


--
-- Name: holding holding_pkey; Type: CONSTRAINT; Schema: public_markets; Owner: -
--

ALTER TABLE ONLY public_markets.holding
    ADD CONSTRAINT holding_pkey PRIMARY KEY (id);


--
-- Name: holding_snapshot holding_snapshot_pkey; Type: CONSTRAINT; Schema: public_markets; Owner: -
--

ALTER TABLE ONLY public_markets.holding_snapshot
    ADD CONSTRAINT holding_snapshot_pkey PRIMARY KEY (id);


--
-- Name: org_dividend_income org_dividend_income_pkey; Type: CONSTRAINT; Schema: public_markets; Owner: -
--

ALTER TABLE ONLY public_markets.org_dividend_income
    ADD CONSTRAINT org_dividend_income_pkey PRIMARY KEY (id);


--
-- Name: property_address property_address_pkey; Type: CONSTRAINT; Schema: real_estate; Owner: -
--

ALTER TABLE ONLY real_estate.property_address
    ADD CONSTRAINT property_address_pkey PRIMARY KEY (id);


--
-- Name: property property_pkey; Type: CONSTRAINT; Schema: real_estate; Owner: -
--

ALTER TABLE ONLY real_estate.property
    ADD CONSTRAINT property_pkey PRIMARY KEY (id);


--
-- Name: property_valuation_snapshot property_valuation_snapshot_pkey; Type: CONSTRAINT; Schema: real_estate; Owner: -
--

ALTER TABLE ONLY real_estate.property_valuation_snapshot
    ADD CONSTRAINT property_valuation_snapshot_pkey PRIMARY KEY (id);


--
-- Name: rental_lease rental_lease_pkey; Type: CONSTRAINT; Schema: real_estate; Owner: -
--

ALTER TABLE ONLY real_estate.rental_lease
    ADD CONSTRAINT rental_lease_pkey PRIMARY KEY (id);


--
-- Name: access access_pkey; Type: CONSTRAINT; Schema: user-managment; Owner: -
--

ALTER TABLE ONLY "user-managment".access
    ADD CONSTRAINT access_pkey PRIMARY KEY (id);


--
-- Name: role_access role_access_pkey; Type: CONSTRAINT; Schema: user-managment; Owner: -
--

ALTER TABLE ONLY "user-managment".role_access
    ADD CONSTRAINT role_access_pkey PRIMARY KEY (role_id);


--
-- Name: role_access role_access_role_id_access_id_key; Type: CONSTRAINT; Schema: user-managment; Owner: -
--

ALTER TABLE ONLY "user-managment".role_access
    ADD CONSTRAINT role_access_role_id_access_id_key UNIQUE (role_id, access_id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: user-managment; Owner: -
--

ALTER TABLE ONLY "user-managment".role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: users_organization_access users_organization_access_pkey; Type: CONSTRAINT; Schema: user-managment; Owner: -
--

ALTER TABLE ONLY "user-managment".users_organization_access
    ADD CONSTRAINT users_organization_access_pkey PRIMARY KEY (access_id, users_organization_id);


--
-- Name: idx_entity_address_country; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_address_country ON entity_management.entity_address USING btree (country);


--
-- Name: idx_entity_address_entity_id; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_address_entity_id ON entity_management.entity_address USING btree (entity_id);


--
-- Name: idx_entity_address_is_primary; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_address_is_primary ON entity_management.entity_address USING btree (is_primary);


--
-- Name: idx_entity_address_type; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_address_type ON entity_management.entity_address USING btree (address_type);


--
-- Name: idx_entity_identifier_entity_id; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_identifier_entity_id ON entity_management.entity_identifier USING btree (entity_id);


--
-- Name: idx_entity_identifier_is_primary; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_identifier_is_primary ON entity_management.entity_identifier USING btree (is_primary);


--
-- Name: idx_entity_identifier_type; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_identifier_type ON entity_management.entity_identifier USING btree (identifier_type);


--
-- Name: idx_entity_identifier_value; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_identifier_value ON entity_management.entity_identifier USING btree (identifier_value);


--
-- Name: idx_entity_member_entity_id; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_member_entity_id ON entity_management.entity_member USING btree (entity_id);


--
-- Name: idx_entity_member_primary_contact; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_member_primary_contact ON entity_management.entity_member USING btree (is_primary_contact);


--
-- Name: idx_entity_member_ref_id; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_member_ref_id ON entity_management.entity_member USING btree (member_ref_id);


--
-- Name: idx_entity_member_ref_type; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_member_ref_type ON entity_management.entity_member USING btree (member_ref_type);


--
-- Name: idx_entity_member_role; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_member_role ON entity_management.entity_member USING btree (role);


--
-- Name: idx_entity_profile_jurisdiction_country; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_profile_jurisdiction_country ON entity_management.entity_profile USING btree (jurisdiction_country);


--
-- Name: idx_entity_profile_jurisdiction_state_region; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_profile_jurisdiction_state_region ON entity_management.entity_profile USING btree (jurisdiction_state_region);


--
-- Name: idx_entity_profile_legal_entity_type; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_profile_legal_entity_type ON entity_management.entity_profile USING btree (legal_entity_type);


--
-- Name: idx_entity_profile_status; Type: INDEX; Schema: entity_management; Owner: -
--

CREATE INDEX idx_entity_profile_status ON entity_management.entity_profile USING btree (status);


--
-- Name: family_member_family_id_email; Type: INDEX; Schema: family_management; Owner: -
--

CREATE UNIQUE INDEX family_member_family_id_email ON family_management.family_member USING btree (family_id, email);


--
-- Name: idx_artwork_asset_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_artwork_asset_id ON lifestyle_assets.artwork USING btree (asset_id);


--
-- Name: idx_artwork_authenticity_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_artwork_authenticity_id ON lifestyle_assets.artwork USING btree (authenticity_id);


--
-- Name: idx_artwork_certification_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_artwork_certification_id ON lifestyle_assets.artwork USING btree (certification_id);


--
-- Name: idx_artwork_condition_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_artwork_condition_id ON lifestyle_assets.artwork USING btree (condition_id);


--
-- Name: idx_artwork_dimensions_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_artwork_dimensions_id ON lifestyle_assets.artwork USING btree (dimensions_id);


--
-- Name: idx_artwork_storage_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_artwork_storage_id ON lifestyle_assets.artwork USING btree (storage_id);


--
-- Name: idx_asset_valuation_snapshot_asset_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_asset_valuation_snapshot_asset_id ON lifestyle_assets.asset_valuation_snapshot USING btree (asset_id);


--
-- Name: idx_asset_valuation_snapshot_org_snapshot; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_asset_valuation_snapshot_org_snapshot ON lifestyle_assets.asset_valuation_snapshot USING btree (organization_id, snapshot_at);


--
-- Name: idx_asset_valuation_snapshot_organization_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_asset_valuation_snapshot_organization_id ON lifestyle_assets.asset_valuation_snapshot USING btree (organization_id);


--
-- Name: idx_asset_valuation_snapshot_snapshot_at; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_asset_valuation_snapshot_snapshot_at ON lifestyle_assets.asset_valuation_snapshot USING btree (snapshot_at);


--
-- Name: idx_automobile_asset_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_automobile_asset_id ON lifestyle_assets.automobile USING btree (asset_id);


--
-- Name: idx_automobile_condition_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_automobile_condition_id ON lifestyle_assets.automobile USING btree (condition_id);


--
-- Name: idx_automobile_storage_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_automobile_storage_id ON lifestyle_assets.automobile USING btree (storage_id);


--
-- Name: idx_aviation_asset_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_aviation_asset_id ON lifestyle_assets.aviation USING btree (asset_id);


--
-- Name: idx_aviation_certification_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_aviation_certification_id ON lifestyle_assets.aviation USING btree (certification_id);


--
-- Name: idx_aviation_storage_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_aviation_storage_id ON lifestyle_assets.aviation USING btree (storage_id);


--
-- Name: idx_collectible_asset_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_collectible_asset_id ON lifestyle_assets.collectible USING btree (asset_id);


--
-- Name: idx_collectible_authenticity_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_collectible_authenticity_id ON lifestyle_assets.collectible USING btree (authenticity_id);


--
-- Name: idx_collectible_book_collectible_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_collectible_book_collectible_id ON lifestyle_assets.collectible_book USING btree (collectible_id);


--
-- Name: idx_collectible_card_game_collectible_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_collectible_card_game_collectible_id ON lifestyle_assets.collectible_card_game USING btree (collectible_id);


--
-- Name: idx_collectible_certification_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_collectible_certification_id ON lifestyle_assets.collectible USING btree (certification_id);


--
-- Name: idx_collectible_collectible_type_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_collectible_collectible_type_id ON lifestyle_assets.collectible USING btree (collectible_type_id);


--
-- Name: idx_collectible_condition_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_collectible_condition_id ON lifestyle_assets.collectible USING btree (condition_id);


--
-- Name: idx_collectible_numismatics_collectible_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_collectible_numismatics_collectible_id ON lifestyle_assets.collectible_numismatics USING btree (collectible_id);


--
-- Name: idx_collectible_sport_memo_collectible_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_collectible_sport_memo_collectible_id ON lifestyle_assets.collectible_sport_memo USING btree (collectible_id);


--
-- Name: idx_collectible_storage_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_collectible_storage_id ON lifestyle_assets.collectible USING btree (storage_id);


--
-- Name: idx_jewellery_asset_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_jewellery_asset_id ON lifestyle_assets.jewellery USING btree (asset_id);


--
-- Name: idx_jewellery_authenticity_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_jewellery_authenticity_id ON lifestyle_assets.jewellery USING btree (authenticity_id);


--
-- Name: idx_jewellery_certification_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_jewellery_certification_id ON lifestyle_assets.jewellery USING btree (certification_id);


--
-- Name: idx_jewellery_condition_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_jewellery_condition_id ON lifestyle_assets.jewellery USING btree (condition_id);


--
-- Name: idx_jewellery_dimensions_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_jewellery_dimensions_id ON lifestyle_assets.jewellery USING btree (dimensions_id);


--
-- Name: idx_jewellery_storage_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_jewellery_storage_id ON lifestyle_assets.jewellery USING btree (storage_id);


--
-- Name: idx_marina_berth_marina_provider_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_marina_berth_marina_provider_id ON lifestyle_assets.marina_berth USING btree (marina_provider_id);


--
-- Name: idx_marine_asset_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_marine_asset_id ON lifestyle_assets.marine USING btree (asset_id);


--
-- Name: idx_marine_dimensions_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_marine_dimensions_id ON lifestyle_assets.marine USING btree (dimensions_id);


--
-- Name: idx_marine_maintenance_provider_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_marine_maintenance_provider_id ON lifestyle_assets.marine USING btree (maintenance_provider_id);


--
-- Name: idx_marine_marina_provider_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_marine_marina_provider_id ON lifestyle_assets.marine USING btree (marina_provider_id);


--
-- Name: idx_marine_storage_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_marine_storage_id ON lifestyle_assets.marine USING btree (storage_id);


--
-- Name: idx_warranty_asset_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_warranty_asset_id ON lifestyle_assets.warranty USING btree (asset_id);


--
-- Name: idx_warranty_provider_id; Type: INDEX; Schema: lifestyle_assets; Owner: -
--

CREATE INDEX idx_warranty_provider_id ON lifestyle_assets.warranty USING btree (provider_id);


--
-- Name: idx_asset_doc_link_asset; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_asset_doc_link_asset ON main.asset_document_link USING btree (asset_id, organization_id);


--
-- Name: idx_asset_doc_link_org; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_asset_doc_link_org ON main.asset_document_link USING btree (organization_id);


--
-- Name: idx_asset_doc_link_source; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_asset_doc_link_source ON main.asset_document_link USING btree (source_type, source_id);


--
-- Name: idx_asset_doc_link_unique; Type: INDEX; Schema: main; Owner: -
--

CREATE UNIQUE INDEX idx_asset_doc_link_unique ON main.asset_document_link USING btree (asset_id, document_id);


--
-- Name: idx_document_ref_entity_ref; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_document_ref_entity_ref ON main.document_ref USING btree (entity_type, reference_id);


--
-- Name: idx_document_ref_reference; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_document_ref_reference ON main.document_ref USING btree (reference_id);


--
-- Name: idx_insurance_account_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_insurance_account_id ON main.insurance USING btree (account_id);


--
-- Name: idx_insurance_currency_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_insurance_currency_id ON main.insurance USING btree (currency_id);


--
-- Name: idx_insurance_entity_ref; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_insurance_entity_ref ON main.insurance USING btree (entity_type, reference_id);


--
-- Name: idx_insurance_entity_type; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_insurance_entity_type ON main.insurance USING btree (entity_type);


--
-- Name: idx_insurance_payment_insurance_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_insurance_payment_insurance_id ON main.insurance_payment USING btree (insurance_id);


--
-- Name: idx_insurance_payment_payment_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_insurance_payment_payment_id ON main.insurance_payment USING btree (payment_id);


--
-- Name: idx_insurance_policy_holder_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_insurance_policy_holder_id ON main.insurance USING btree (policy_holder_id);


--
-- Name: idx_insurance_reference_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_insurance_reference_id ON main.insurance USING btree (reference_id);


--
-- Name: idx_insurance_renewal_date; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_insurance_renewal_date ON main.insurance USING btree (insurance_renewal_date);


--
-- Name: idx_loan_currency_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_loan_currency_id ON main.loan USING btree (currency_id);


--
-- Name: idx_loan_entity_reference; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_loan_entity_reference ON main.loan USING btree (entity_type, reference_id);


--
-- Name: idx_loan_lender_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_loan_lender_id ON main.loan USING btree (lender_id);


--
-- Name: idx_loan_payments_loan_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_loan_payments_loan_id ON main.loan_payments USING btree (loan_id);


--
-- Name: idx_loan_payments_payment_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_loan_payments_payment_id ON main.loan_payments USING btree (payment_id);


--
-- Name: idx_loan_reference_maturity; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_loan_reference_maturity ON main.loan USING btree (reference_id, maturity_date);


--
-- Name: idx_maintenance_category; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_maintenance_category ON main.maintenance USING btree (category);


--
-- Name: idx_maintenance_currency_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_maintenance_currency_id ON main.maintenance USING btree (currency_id);


--
-- Name: idx_maintenance_entity_ref; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_maintenance_entity_ref ON main.maintenance USING btree (entity_type, reference_id);


--
-- Name: idx_maintenance_entity_type; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_maintenance_entity_type ON main.maintenance USING btree (entity_type);


--
-- Name: idx_maintenance_insurance_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_maintenance_insurance_id ON main.maintenance USING btree (insurance_id);


--
-- Name: idx_maintenance_maintenance_date; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_maintenance_maintenance_date ON main.maintenance USING btree (maintenance_date);


--
-- Name: idx_maintenance_payment_account_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_maintenance_payment_account_id ON main.maintenance USING btree (payment_account_id);


--
-- Name: idx_maintenance_provider_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_maintenance_provider_id ON main.maintenance USING btree (provider_id);


--
-- Name: idx_maintenance_reference_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_maintenance_reference_id ON main.maintenance USING btree (reference_id);


--
-- Name: idx_maintenance_warranty_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_maintenance_warranty_id ON main.maintenance USING btree (warranty_id);


--
-- Name: idx_ownership_asset_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_ownership_asset_id ON main.ownership USING btree (asset_id);


--
-- Name: idx_ownership_owner_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_ownership_owner_id ON main.ownership USING btree (owner_id);


--
-- Name: idx_ownership_ownership_type; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_ownership_ownership_type ON main.ownership USING btree (ownership_type);


--
-- Name: idx_payment_asset_asset; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_payment_asset_asset ON main.payment_asset USING btree (asset_type, asset_id);


--
-- Name: idx_payments_account_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_payments_account_id ON main.payments USING btree (account_id);


--
-- Name: idx_payments_currency_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_payments_currency_id ON main.payments USING btree (currency_id);


--
-- Name: idx_payments_due_date; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_payments_due_date ON main.payments USING btree (due_date);


--
-- Name: idx_payments_status; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_payments_status ON main.payments USING btree (status);


--
-- Name: idx_purchase_method_currency_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_purchase_method_currency_id ON main.purchase_method USING btree (currency_id);


--
-- Name: idx_purchase_method_provider_contact_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_purchase_method_provider_contact_id ON main.purchase_method USING btree (provider_contact_id);


--
-- Name: idx_rate_adjustments_effective_date; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_rate_adjustments_effective_date ON main.rate_adjustments USING btree (effective_date);


--
-- Name: idx_rate_adjustments_loan_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_rate_adjustments_loan_id ON main.rate_adjustments USING btree (loan_id);


--
-- Name: idx_review_payments_asset; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_review_payments_asset ON main.review_payments USING btree (asset_type, asset_id);


--
-- Name: idx_review_payments_organization_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_review_payments_organization_id ON main.review_payments USING btree (organization_id);


--
-- Name: idx_review_payments_status; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_review_payments_status ON main.review_payments USING btree (status);


--
-- Name: idx_sale_asset_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_sale_asset_id ON main.sale USING btree (asset_id);


--
-- Name: idx_sale_asset_type; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_sale_asset_type ON main.sale USING btree (asset_type);


--
-- Name: idx_sale_sale_date; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_sale_sale_date ON main.sale USING btree (sale_date);


--
-- Name: idx_sale_sale_type; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_sale_sale_type ON main.sale USING btree (sale_type);


--
-- Name: idx_sale_seller_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_sale_seller_id ON main.sale USING btree (seller_id);


--
-- Name: idx_transaction_category; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_transaction_category ON main.transaction USING btree (category);


--
-- Name: idx_transaction_currency_id; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_transaction_currency_id ON main.transaction USING btree (currency_id);


--
-- Name: idx_transaction_date; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_transaction_date ON main.transaction USING btree (transaction_date);


--
-- Name: idx_transaction_entity_ref; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_transaction_entity_ref ON main.transaction USING btree (entity_type, reference_id);


--
-- Name: idx_transaction_status; Type: INDEX; Schema: main; Owner: -
--

CREATE INDEX idx_transaction_status ON main.transaction USING btree (status);


--
-- Name: uq_insurance_payment; Type: INDEX; Schema: main; Owner: -
--

CREATE UNIQUE INDEX uq_insurance_payment ON main.insurance_payment USING btree (insurance_id, payment_id);


--
-- Name: idx_asset_reminders_active; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_asset_reminders_active ON notifications.asset_reminders USING btree (is_active);


--
-- Name: idx_asset_reminders_asset; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_asset_reminders_asset ON notifications.asset_reminders USING btree (asset_module, asset_id);


--
-- Name: idx_asset_reminders_dates; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_asset_reminders_dates ON notifications.asset_reminders USING btree (start_date, end_date);


--
-- Name: idx_asset_reminders_org_id; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_asset_reminders_org_id ON notifications.asset_reminders USING btree (organization_id);


--
-- Name: idx_email_jobs_job_id; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_email_jobs_job_id ON notifications.email_jobs USING btree (job_id);


--
-- Name: idx_email_jobs_status; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_email_jobs_status ON notifications.email_jobs USING btree (status);


--
-- Name: idx_notifications_org_id; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_notifications_org_id ON notifications.notifications USING btree (organization_id);


--
-- Name: idx_notifications_reminder_id; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_notifications_reminder_id ON notifications.notifications USING btree (reminder_id);


--
-- Name: idx_notifications_scheduled_for; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_notifications_scheduled_for ON notifications.notifications USING btree (scheduled_for);


--
-- Name: idx_notifications_status; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_notifications_status ON notifications.notifications USING btree (status);


--
-- Name: idx_notifications_user_id; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_notifications_user_id ON notifications.notifications USING btree (user_id);


--
-- Name: idx_notifications_user_status; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_notifications_user_status ON notifications.notifications USING btree (user_id, status);


--
-- Name: idx_push_tokens_token; Type: INDEX; Schema: notifications; Owner: -
--

CREATE UNIQUE INDEX idx_push_tokens_token ON notifications.push_tokens USING btree (token);


--
-- Name: idx_push_tokens_user_id; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_push_tokens_user_id ON notifications.push_tokens USING btree (user_id);


--
-- Name: idx_push_tokens_user_org; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_push_tokens_user_org ON notifications.push_tokens USING btree (user_id, organization_id);


--
-- Name: idx_reminder_recipients_reminder_id; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_reminder_recipients_reminder_id ON notifications.reminder_recipients USING btree (reminder_id);


--
-- Name: idx_reminder_recipients_unique; Type: INDEX; Schema: notifications; Owner: -
--

CREATE UNIQUE INDEX idx_reminder_recipients_unique ON notifications.reminder_recipients USING btree (reminder_id, user_id);


--
-- Name: idx_reminder_recipients_user_id; Type: INDEX; Schema: notifications; Owner: -
--

CREATE INDEX idx_reminder_recipients_user_id ON notifications.reminder_recipients USING btree (user_id);


--
-- Name: idx_transaction_payment_payment_id; Type: INDEX; Schema: private_investments; Owner: -
--

CREATE INDEX idx_transaction_payment_payment_id ON private_investments.transaction_payment USING btree (payment_id);


--
-- Name: idx_transaction_payment_transaction_id; Type: INDEX; Schema: private_investments; Owner: -
--

CREATE INDEX idx_transaction_payment_transaction_id ON private_investments.transaction_payment USING btree (transaction_id);


--
-- Name: idx_org_dividend_income_org_date; Type: INDEX; Schema: public_markets; Owner: -
--

CREATE INDEX idx_org_dividend_income_org_date ON public_markets.org_dividend_income USING btree (organization_id, payment_date);


--
-- Name: idx_property_address_id; Type: INDEX; Schema: real_estate; Owner: -
--

CREATE INDEX idx_property_address_id ON real_estate.property USING btree (address_id);


--
-- Name: idx_property_organization_id; Type: INDEX; Schema: real_estate; Owner: -
--

CREATE INDEX idx_property_organization_id ON real_estate.property USING btree (organization_id);


--
-- Name: idx_property_type; Type: INDEX; Schema: real_estate; Owner: -
--

CREATE INDEX idx_property_type ON real_estate.property USING btree (property_type);


--
-- Name: idx_property_valuation_snapshot_property; Type: INDEX; Schema: real_estate; Owner: -
--

CREATE INDEX idx_property_valuation_snapshot_property ON real_estate.property_valuation_snapshot USING btree (property_id, snapshot_at);


--
-- Name: idx_rental_lease_property_id; Type: INDEX; Schema: real_estate; Owner: -
--

CREATE INDEX idx_rental_lease_property_id ON real_estate.rental_lease USING btree (property_id);


--
-- Name: idx_rental_lease_status; Type: INDEX; Schema: real_estate; Owner: -
--

CREATE INDEX idx_rental_lease_status ON real_estate.rental_lease USING btree (status);


--
-- PostgreSQL database dump complete
--

\unrestrict ivjqf855Xf1mXmEAwpYA1oLiWzmfGvZBxJwQJ2czKygO7PNabb9YC6cJem9GXDV

