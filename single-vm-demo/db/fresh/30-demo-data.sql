-- =============================================================================
-- FRESH-path DEMO DATA: a realistic family office for client demos.
-- Applied after 10-schema.sql, 15-schema-supplement.sql, 20-seed.sql.
-- Org 00000000-…-b1, currency USD, demo user …-555555555555 already seeded (20-seed).
-- RUN ONCE (referenced rows are ON CONFLICT-safe; leaf rows use gen_random_uuid()).
--
-- Owners (main.entity) -> ownership.owner_id. Family members own via their backing entity.
-- Fixed UUIDs: e1 trust, e2 LLC, e3 patriarch, e4 matriarch, e5/e6 children.
-- =============================================================================
BEGIN;

-- ─────────────────────────── Entities ───────────────────────────────────────
INSERT INTO main.entity (id, organization_id, name, type, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-0000000000e1','00000000-0000-0000-0000-0000000000b1','Smith Family Trust','FAMILY', now(),now()),
 ('00000000-0000-0000-0000-0000000000e2','00000000-0000-0000-0000-0000000000b1','Smith Holdings LLC','GENERAL', now(),now()),
 ('00000000-0000-0000-0000-0000000000e3','00000000-0000-0000-0000-0000000000b1','John Smith (Individual)','GENERAL', now(),now()),
 ('00000000-0000-0000-0000-0000000000e4','00000000-0000-0000-0000-0000000000b1','Mary Smith (Individual)','GENERAL', now(),now()),
 ('00000000-0000-0000-0000-0000000000e5','00000000-0000-0000-0000-0000000000b1','James Smith (Individual)','GENERAL', now(),now()),
 ('00000000-0000-0000-0000-0000000000e6','00000000-0000-0000-0000-0000000000b1','Emily Smith (Individual)','GENERAL', now(),now())
ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────── Family + members ──────────────────────────────
INSERT INTO family_management.family (id, organization_id, name, description, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-0000000000f1','00000000-0000-0000-0000-0000000000b1','The Smith Family','Multi-generational family office', now(),now())
ON CONFLICT (id) DO NOTHING;

INSERT INTO family_management.family_member
 (id, family_id, family_member_entity_id, full_name, preferred_name, date_of_birth, email, phone,
  marital_status, legal_capacity, tax_residency, citizenship, generation, relationship_to_wealth, family_role, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-00000000fa01','00000000-0000-0000-0000-0000000000f1','00000000-0000-0000-0000-0000000000e3','John Smith','John','1955-03-14','john@smith.example','+1-202-555-0101','Married','FULL','United States','United States','G1','CREATOR','PATRIARCH', now(),now()),
 ('00000000-0000-0000-0000-00000000fa02','00000000-0000-0000-0000-0000000000f1','00000000-0000-0000-0000-0000000000e4','Mary Smith','Mary','1958-07-22','mary@smith.example','+1-202-555-0102','Married','FULL','United States','United States','G1','SPOUSE','MATRIARCH', now(),now()),
 ('00000000-0000-0000-0000-00000000fa03','00000000-0000-0000-0000-0000000000f1','00000000-0000-0000-0000-0000000000e5','James Smith','Jim','1985-01-30','james@smith.example','+1-202-555-0103','Married','FULL','United States','United States','G2','INHERITOR','CHILD', now(),now()),
 ('00000000-0000-0000-0000-00000000fa04','00000000-0000-0000-0000-0000000000f1','00000000-0000-0000-0000-0000000000e6','Emily Smith','Em','1988-11-05','emily@smith.example','+1-202-555-0104','Single','FULL','United States','United States','G2','INHERITOR','CHILD', now(),now()),
 ('00000000-0000-0000-0000-00000000fa05','00000000-0000-0000-0000-0000000000f1',NULL,'Sarah Smith','Sarah','1986-06-18','sarah@smith.example','+1-202-555-0105','Married','FULL','United States','United States','G2','SPOUSE','SPOUSE', now(),now())
ON CONFLICT (id) DO NOTHING;

UPDATE family_management.family SET primary_contact_family_member_id='00000000-0000-0000-0000-00000000fa01'
 WHERE id='00000000-0000-0000-0000-0000000000f1';

INSERT INTO family_management.family_relationship (id, family_id, from_family_member_id, to_family_member_id, relationship_type, valid_from, created_at, updated_at) VALUES
 (gen_random_uuid(),'00000000-0000-0000-0000-0000000000f1','00000000-0000-0000-0000-00000000fa01','00000000-0000-0000-0000-00000000fa02','SPOUSE','1980-05-10', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-0000000000f1','00000000-0000-0000-0000-00000000fa01','00000000-0000-0000-0000-00000000fa03','FATHER','1985-01-30', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-0000000000f1','00000000-0000-0000-0000-00000000fa01','00000000-0000-0000-0000-00000000fa04','FATHER','1988-11-05', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-0000000000f1','00000000-0000-0000-0000-00000000fa03','00000000-0000-0000-0000-00000000fa04','SIBLING','1988-11-05', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-0000000000f1','00000000-0000-0000-0000-00000000fa05','00000000-0000-0000-0000-00000000fa03','SPOUSE','2012-09-15', now(),now());

INSERT INTO family_management.address (id, street_address, street_address2, city, country, postal_code, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-00000000fad1','1200 Park Avenue','Apt 14A','New York','United States','10128', now(),now())
ON CONFLICT (id) DO NOTHING;
INSERT INTO family_management.family_member_address (id, family_member_id, address_id, address_type, is_primary, valid_from, created_at, updated_at) VALUES
 (gen_random_uuid(),'00000000-0000-0000-0000-00000000fa01','00000000-0000-0000-0000-00000000fad1','PRIMARY',true,'1990-01-01', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-00000000fa02','00000000-0000-0000-0000-00000000fad1','PRIMARY',true,'1990-01-01', now(),now());

-- ════════════════ PUBLIC MARKETS: brokerage chain + accounts + holdings ══════
INSERT INTO public_markets.asset_type (id, code, name, description, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-0000000a7101','EQUITIES','Equities','Stocks and ETFs', now(),now()),
 ('00000000-0000-0000-0000-0000000a7102','FIXED_INCOME','Fixed Income','Bonds', now(),now())
ON CONFLICT (code) DO NOTHING;

INSERT INTO public_markets.connector (id, code, name, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-00000000c001','SNAPTRADE','SnapTrade', now(),now()) ON CONFLICT (id) DO NOTHING;
INSERT INTO public_markets.brokerage (id, code, name, website_url, is_recommended, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-00000000b001','SCHWAB','Charles Schwab','https://schwab.com',true, now(),now()),
 ('00000000-0000-0000-0000-00000000b002','FIDELITY','Fidelity Investments','https://fidelity.com',true, now(),now())
ON CONFLICT (id) DO NOTHING;
INSERT INTO public_markets.brokerage_connector (brokerage_id, connector_id, is_default, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-00000000b001','00000000-0000-0000-0000-00000000c001',true, now(),now()),
 ('00000000-0000-0000-0000-00000000b002','00000000-0000-0000-0000-00000000c001',true, now(),now())
ON CONFLICT DO NOTHING;
INSERT INTO public_markets.aggregator_connection (id, entity_id, brokerage_id, connector_id, status, snaptrade_user_id, last_sync, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-0000000ac001','00000000-0000-0000-0000-0000000000e3','00000000-0000-0000-0000-00000000b001','00000000-0000-0000-0000-00000000c001','CONNECTED','demo-user', now(), now(),now()),
 ('00000000-0000-0000-0000-0000000ac002','00000000-0000-0000-0000-0000000000e1','00000000-0000-0000-0000-00000000b002','00000000-0000-0000-0000-00000000c001','CONNECTED','demo-user', now(), now(),now())
ON CONFLICT (id) DO NOTHING;

INSERT INTO public_markets.account
 (id, entity_id, account_type, account_subtype, currency_id, status, account_mask, external_current_balance,
  snaptrade_account_id, aggregator_connection_id, last_sync, import_source, last_sync_status, account_name, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-000000acc001','00000000-0000-0000-0000-0000000000e3','BROKERAGE','CORPORATE','USD','ACTIVE','4471',9250000.00,'st-acct-schwab','00000000-0000-0000-0000-0000000ac001', now(),'AGGREGATOR_CONNECTION','UPDATED','Schwab Brokerage', now(),now()),
 ('00000000-0000-0000-0000-000000acc002','00000000-0000-0000-0000-0000000000e1','BROKERAGE','BUSINESS','USD','ACTIVE','8820',3100000.00,'st-acct-fid','00000000-0000-0000-0000-0000000ac002', now(),'AGGREGATOR_CONNECTION','UPDATED','Fidelity Investments', now(),now()),
 ('00000000-0000-0000-0000-000000acc003','00000000-0000-0000-0000-0000000000e2','CHECKING','BUSINESS','USD','ACTIVE','1002',750000.00, NULL, NULL, NULL,'MANUAL_REPORT', NULL,'Operating Cash', now(),now())
ON CONFLICT (id) DO NOTHING;

INSERT INTO public_markets.asset
 (id, asset_type_id, name, ticker_symbol, market_identifier_code, currency_id, isin, last_price, last_price_currency, sector, gic_sector, dividend_yield, beta, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-0000000a0001','00000000-0000-0000-0000-0000000a7101','Apple Inc.','AAPL','XNAS','USD','US0378331005',227.50,'USD','Technology','Information Technology',0.0044,1.24, now(),now()),
 ('00000000-0000-0000-0000-0000000a0002','00000000-0000-0000-0000-0000000a7101','Microsoft Corp.','MSFT','XNAS','USD','US5949181045',430.10,'USD','Technology','Information Technology',0.0072,0.92, now(),now()),
 ('00000000-0000-0000-0000-0000000a0003','00000000-0000-0000-0000-0000000a7101','NVIDIA Corp.','NVDA','XNAS','USD','US67066G1040',128.30,'USD','Technology','Information Technology',0.0003,1.68, now(),now()),
 ('00000000-0000-0000-0000-0000000a0004','00000000-0000-0000-0000-0000000a7101','Amazon.com Inc.','AMZN','XNAS','USD','US0231351067',186.40,'USD','Consumer Discretionary','Consumer Discretionary',0,1.15, now(),now()),
 ('00000000-0000-0000-0000-0000000a0005','00000000-0000-0000-0000-0000000a7101','Alphabet Inc. Class A','GOOGL','XNAS','USD','US02079K3059',175.20,'USD','Communication Services','Communication Services',0.0046,1.03, now(),now()),
 ('00000000-0000-0000-0000-0000000a0006','00000000-0000-0000-0000-0000000a7101','JPMorgan Chase & Co.','JPM','XNYS','USD','US46625H1005',205.80,'USD','Financials','Financials',0.0220,1.10, now(),now()),
 ('00000000-0000-0000-0000-0000000a0007','00000000-0000-0000-0000-0000000a7101','Johnson & Johnson','JNJ','XNYS','USD','US4781601046',152.10,'USD','Health Care','Health Care',0.0330,0.55, now(),now()),
 ('00000000-0000-0000-0000-0000000a0008','00000000-0000-0000-0000-0000000a7101','Vanguard S&P 500 ETF','VOO','XASE','USD','US9229083632',505.60,'USD','ETF','Diversified',0.0130,1.00, now(),now()),
 ('00000000-0000-0000-0000-0000000a0009','00000000-0000-0000-0000-0000000a7101','Invesco QQQ Trust','QQQ','XNAS','USD','US46090E1038',480.25,'USD','ETF','Diversified',0.0060,1.12, now(),now()),
 ('00000000-0000-0000-0000-0000000a0010','00000000-0000-0000-0000-0000000a7101','Berkshire Hathaway B','BRK.B','XNYS','USD','US0846707026',455.00,'USD','Financials','Financials',0,0.87, now(),now())
ON CONFLICT (id) DO NOTHING;

INSERT INTO public_markets.holding
 (id, account_id, asset_id, quantity, price, average_purchase_price, open_pnl, status, last_sync, last_sync_status, created_at, updated_at) VALUES
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc001','00000000-0000-0000-0000-0000000a0001',6000,227.50,150.00,465000.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc001','00000000-0000-0000-0000-0000000a0002',3000,430.10,300.00,390300.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc001','00000000-0000-0000-0000-0000000a0003',9000,128.30,45.00,749700.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc001','00000000-0000-0000-0000-0000000a0004',4000,186.40,120.00,265600.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc001','00000000-0000-0000-0000-0000000a0008',5000,505.60,360.00,728000.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc001','00000000-0000-0000-0000-0000000a0010',4500,455.00,300.00,697500.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc002','00000000-0000-0000-0000-0000000a0005',4000,175.20,110.00,260800.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc002','00000000-0000-0000-0000-0000000a0006',3500,205.80,140.00,230300.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc002','00000000-0000-0000-0000-0000000a0007',4000,152.10,130.00,88400.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc002','00000000-0000-0000-0000-0000000a0009',2200,480.25,330.00,330550.00,'ACTIVE', now(),'UPDATED', now(),now())
ON CONFLICT (account_id, asset_id) DO NOTHING;

-- 36 monthly snapshots per holding (chart history; price drifts up going forward)
INSERT INTO public_markets.holding_snapshot (id, holding_id, account_id, currency_id, asset_id, quantity, price, snapshot_timestamp, created_at)
SELECT gen_random_uuid(), h.id, h.account_id, 'USD', h.asset_id, h.quantity,
  ROUND((h.price * POWER(1.0095, -(35 - g.m)))::numeric, 8),
  (date_trunc('month', now()) - ((35 - g.m) || ' months')::interval + interval '1 month' - interval '1 day')::timestamptz,
  now()
FROM public_markets.holding h
CROSS JOIN generate_series(0,35) AS g(m)
WHERE h.account_id IN ('00000000-0000-0000-0000-000000acc001','00000000-0000-0000-0000-000000acc002');

INSERT INTO public_markets.org_dividend_income (id, organization_id, payment_date, ticker_symbol, amount_per_share, quantity_held, gross_income, currency, calculated_at) VALUES
 (gen_random_uuid(),'00000000-0000-0000-0000-0000000000b1', now()-interval '10 days','AAPL',0.25,6000,1500.00,'USD', now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-0000000000b1', now()-interval '10 days','MSFT',0.83,3000,2490.00,'USD', now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-0000000000b1', now()-interval '10 days','JNJ',1.24,4000,4960.00,'USD', now());

-- ════════════════ PRIVATE INVESTMENTS: VC / PE / RE funds ════════════════════
INSERT INTO private_investments.investment_type (id, name) VALUES
 ('VENTURE_CAPITAL','Venture Capital'),('PRIVATE_EQUITY','Private Equity'),('RE_FUND','Real Estate Fund')
ON CONFLICT (id) DO NOTHING;

INSERT INTO private_investments.fund (id, name, organization_id, fund_structure, dominical, size, vintige_year, currency, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-000000000f01','Lightspark Ventures Fund III','00000000-0000-0000-0000-0000000000b1','LP','Delaware',250000000.00,2022,'USD', now(),now()),
 ('00000000-0000-0000-0000-000000000f02','Granite Ridge Buyout Fund II','00000000-0000-0000-0000-0000000000b1','LP','Delaware',800000000.00,2021,'USD', now(),now()),
 ('00000000-0000-0000-0000-000000000f03','Beacon Hill Value-Add Realty Fund','00000000-0000-0000-0000-0000000000b1','LLC','Delaware',500000000.00,2023,'USD', now(),now())
ON CONFLICT (id) DO NOTHING;

INSERT INTO private_investments.investment (id, organization_id, investment_type, name, investment_format, sponsor_name, is_deleted, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-000000000f11','00000000-0000-0000-0000-0000000000b1','VENTURE_CAPITAL','Lightspark Fund III — LP Commitment','FUND','Lightspark Capital',false, now(),now()),
 ('00000000-0000-0000-0000-000000000f12','00000000-0000-0000-0000-0000000000b1','PRIVATE_EQUITY','Granite Ridge II — LP Commitment','FUND','Granite Ridge Partners',false, now(),now()),
 ('00000000-0000-0000-0000-000000000f13','00000000-0000-0000-0000-0000000000b1','RE_FUND','Beacon Hill Realty — LP Commitment','FUND','Beacon Hill RE',false, now(),now())
ON CONFLICT (id) DO NOTHING;

INSERT INTO private_investments.investment_fund (id, fund_id, general_partner_id, fund_stratagy, investment_id, created_at, updated_at) VALUES
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f01',NULL,'SERIES_A','00000000-0000-0000-0000-000000000f11', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f02',NULL,'BUYOUT','00000000-0000-0000-0000-000000000f12', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f03',NULL,'VALUE_ADD','00000000-0000-0000-0000-000000000f13', now(),now());

INSERT INTO private_investments.asset (id, asset_type, investment_id, currency, name, ownership, amount, config_version, is_deleted, date, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-000000000f21','FUND','00000000-0000-0000-0000-000000000f11','USD','Lightspark Fund III Interest',1.0,2000000.00,'VENTURE_V1',false,'2022-03-15', now(),now()),
 ('00000000-0000-0000-0000-000000000f22','FUND','00000000-0000-0000-0000-000000000f12','USD','Granite Ridge II Interest',1.0,5000000.00,'PRIVATE_EQUITY_V1',false,'2021-06-01', now(),now()),
 ('00000000-0000-0000-0000-000000000f23','FUND','00000000-0000-0000-0000-000000000f13','USD','Beacon Hill Realty Interest',1.0,3000000.00,'REAL_STATE_V1',false,'2023-01-20', now(),now())
ON CONFLICT (id) DO NOTHING;

INSERT INTO private_investments.transaction (id, asset_id, currency, amount, type, description, is_deleted, original_datetime, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-000000000f31','00000000-0000-0000-0000-000000000f21','USD',600000.00,'CAPITAL_CALL','Capital call #1',false,'2022-04-01', now(),now()),
 ('00000000-0000-0000-0000-000000000f32','00000000-0000-0000-0000-000000000f21','USD',500000.00,'CAPITAL_CALL','Capital call #2',false,'2022-11-15', now(),now()),
 ('00000000-0000-0000-0000-000000000f33','00000000-0000-0000-0000-000000000f21','USD',300000.00,'CAPITAL_CALL','Capital call #3',false,'2023-09-10', now(),now()),
 ('00000000-0000-0000-0000-000000000f34','00000000-0000-0000-0000-000000000f21','USD',450000.00,'DISTRIBUTION','Distribution #1',false,'2024-12-05', now(),now()),
 ('00000000-0000-0000-0000-000000000f35','00000000-0000-0000-0000-000000000f22','USD',2000000.00,'CAPITAL_CALL','Initial drawdown',false,'2021-07-01', now(),now()),
 ('00000000-0000-0000-0000-000000000f36','00000000-0000-0000-0000-000000000f22','USD',1500000.00,'CAPITAL_CALL','Follow-on drawdown',false,'2022-05-20', now(),now()),
 ('00000000-0000-0000-0000-000000000f37','00000000-0000-0000-0000-000000000f22','USD',800000.00,'DISTRIBUTION','Recap dividend',false,'2023-08-15', now(),now()),
 ('00000000-0000-0000-0000-000000000f38','00000000-0000-0000-0000-000000000f22','USD',1200000.00,'DISTRIBUTION','Partial exit proceeds',false,'2025-02-28', now(),now()),
 ('00000000-0000-0000-0000-000000000f39','00000000-0000-0000-0000-000000000f23','USD',1200000.00,'CAPITAL_CALL','Acquisition call',false,'2023-02-10', now(),now()),
 ('00000000-0000-0000-0000-000000000f3a','00000000-0000-0000-0000-000000000f23','USD',900000.00,'CAPITAL_CALL','CapEx call',false,'2024-03-25', now(),now()),
 ('00000000-0000-0000-0000-000000000f3b','00000000-0000-0000-0000-000000000f23','USD',350000.00,'DISTRIBUTION','Quarterly rental income',false,'2025-01-15', now(),now())
ON CONFLICT (id) DO NOTHING;

INSERT INTO private_investments.capital_call (id, transaction_id, due_date, created_at, updated_at) VALUES
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f31','2022-04-15', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f32','2022-11-30', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f33','2023-09-25', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f35','2021-07-15', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f36','2022-06-05', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f39','2023-02-25', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f3a','2024-04-10', now(),now());

INSERT INTO private_investments.distribution (id, type, transaction_id, is_recallable, recallable_amount, recallable_last_date, created_at, updated_at) VALUES
 (gen_random_uuid(),'PROFIT_DISTRIBUTION','00000000-0000-0000-0000-000000000f34',false,NULL,NULL, now(),now()),
 (gen_random_uuid(),'DIVIDEND','00000000-0000-0000-0000-000000000f37',true,200000.00,'2024-08-15', now(),now()),
 (gen_random_uuid(),'PROFIT_DISTRIBUTION','00000000-0000-0000-0000-000000000f38',false,NULL,NULL, now(),now()),
 (gen_random_uuid(),'RETURN_OF_CAPITAL','00000000-0000-0000-0000-000000000f3b',false,NULL,NULL, now(),now());

INSERT INTO private_investments.valuation (id, asset_id, currency, amount, unrealized_gain, realized_gain, is_nav, is_entry, valustion_source, valuation_timestamp, created_at, is_deleted) VALUES
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f21','USD',2100000.00,700000.00,450000.00,true,false,'LATEST_FUNDING_ROUND','2025-03-31', now(),false),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f22','USD',4200000.00,700000.00,2000000.00,true,false,'COMPARABLE_TRANSACTIONS','2025-03-31', now(),false),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f23','USD',2300000.00,200000.00,350000.00,true,false,'THIRD_PARTY_APPRAISAL','2025-03-31', now(),false);

-- ════════════════ LIFESTYLE: cars + artworks ════════════════════════════════
INSERT INTO lifestyle_assets.asset_type (id, code, name, description, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-0000000a7201','automobile','Automobile','Cars and motor vehicles', now(),now()),
 ('00000000-0000-0000-0000-0000000a7202','artwork','Artwork','Paintings and fine art', now(),now())
ON CONFLICT (code) DO NOTHING;

INSERT INTO lifestyle_assets.condition (id, overall_condition, condition_details, last_inspection_date, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-00000000c011','Excellent',ARRAY['Concours-ready'],'2025-11-01', now(),now()),
 ('00000000-0000-0000-0000-00000000c012','Very Good',ARRAY['Minor stone chips'],'2025-09-15', now(),now()),
 ('00000000-0000-0000-0000-00000000c013','Good',ARRAY['Daily driver wear'],'2026-01-10', now(),now()),
 ('00000000-0000-0000-0000-00000000c014','Excellent',ARRAY['Stable, no restoration'],'2025-12-01', now(),now()),
 ('00000000-0000-0000-0000-00000000c015','Very Good',ARRAY['Light surface patina'],'2025-10-20', now(),now())
ON CONFLICT (id) DO NOTHING;
INSERT INTO lifestyle_assets.storage (id, storage_location, specific_location, storage_conditions, display_method, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-00000000c021','Climate-controlled garage','Bay 1',ARRAY['Climate controlled'],'Covered', now(),now()),
 ('00000000-0000-0000-0000-00000000c022','Climate-controlled garage','Bay 2',ARRAY['Climate controlled'],'Covered', now(),now()),
 ('00000000-0000-0000-0000-00000000c023','Private gallery','Main hall',ARRAY['UV-filtered'],'Wall-mounted', now(),now()),
 ('00000000-0000-0000-0000-00000000c024','Private gallery','Atrium plinth',ARRAY['Climate controlled'],'Free-standing', now(),now())
ON CONFLICT (id) DO NOTHING;
INSERT INTO lifestyle_assets.dimensions (id, height, width, depth, unit, weight, weight_unit, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-00000000c031',92.00,73.00,NULL,'cm',NULL,NULL, now(),now()),
 ('00000000-0000-0000-0000-00000000c032',180.00,60.00,60.00,'cm',145.00,'kg', now(),now())
ON CONFLICT (id) DO NOTHING;
INSERT INTO lifestyle_assets.authenticity (id, authentication_status, coa_on_file, provenance_docs_on_file, authentication_method, authenticated_by, authentication_date, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-00000000c041','Authenticated',true,true,'Expert examination','Wildenstein Plattner Institute','2024-06-01', now(),now()),
 ('00000000-0000-0000-0000-00000000c042','Authenticated',true,false,'Foundry records','Fondation Giacometti','2023-03-12', now(),now())
ON CONFLICT (id) DO NOTHING;
INSERT INTO lifestyle_assets.certification (id, certification_type, issuing_body, certificate_number, issue_date, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-00000000c051','Certificate of Authenticity','Artist Foundation','COA-2018-0421','2018-05-20', now(),now())
ON CONFLICT (id) DO NOTHING;

INSERT INTO lifestyle_assets.asset (id, organization_id, asset_type_id, name, description, status, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-00000000be01','00000000-0000-0000-0000-0000000000b1','00000000-0000-0000-0000-0000000a7201','Ferrari 488 GTB','Rosso Corsa Berlinetta','active', now(),now()),
 ('00000000-0000-0000-0000-00000000be02','00000000-0000-0000-0000-0000000000b1','00000000-0000-0000-0000-0000000a7201','Porsche 911 Turbo S','992 coupe','active', now(),now()),
 ('00000000-0000-0000-0000-00000000be03','00000000-0000-0000-0000-0000000000b1','00000000-0000-0000-0000-0000000a7201','Range Rover Autobiography','L460 LWB SUV','active', now(),now()),
 ('00000000-0000-0000-0000-00000000be04','00000000-0000-0000-0000-0000000000b1','00000000-0000-0000-0000-0000000a7202','Untitled (Blue Composition)','Mid-century abstract oil','active', now(),now()),
 ('00000000-0000-0000-0000-00000000be05','00000000-0000-0000-0000-0000000000b1','00000000-0000-0000-0000-0000000a7202','Walking Figure','Patinated bronze edition','active', now(),now())
ON CONFLICT (id) DO NOTHING;

INSERT INTO lifestyle_assets.automobile (id, asset_id, category, make, model, year, body_style, vin_number, distance_unit, current_mileage, usage_pattern, condition_id, storage_id, exterior_color, interior_color, created_at, updated_at) VALUES
 (gen_random_uuid(),'00000000-0000-0000-0000-00000000be01','Sports Car','Ferrari','488 GTB',2019,'Coupe','ZFF79ALA4K0234501','mi',8200,'Collector','00000000-0000-0000-0000-00000000c011','00000000-0000-0000-0000-00000000c021','Rosso Corsa','Nero', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-00000000be02','Sports Car','Porsche','911 Turbo S',2022,'Coupe','WP0AD2A99NS123456','mi',14500,'Frequent','00000000-0000-0000-0000-00000000c012','00000000-0000-0000-0000-00000000c022','GT Silver','Black', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-00000000be03','SUV','Land Rover','Range Rover Autobiography',2023,'SUV','SALGA2BU1PA987654','mi',21000,'Daily','00000000-0000-0000-0000-00000000c013','00000000-0000-0000-0000-00000000c021','Santorini Black','Ivory', now(),now());

INSERT INTO lifestyle_assets.artwork (id, asset_id, type, artist, title, year, medium, purpose, edition_size, edition_type, condition_id, certification_id, authenticity_id, dimensions_id, storage_id, created_at, updated_at) VALUES
 (gen_random_uuid(),'00000000-0000-0000-0000-00000000be04','Painting','Jean Dubuffet','Untitled (Blue Composition)',1961,'Oil on canvas','Investment',NULL,NULL,'00000000-0000-0000-0000-00000000c014','00000000-0000-0000-0000-00000000c051','00000000-0000-0000-0000-00000000c041','00000000-0000-0000-0000-00000000c031','00000000-0000-0000-0000-00000000c023', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-00000000be05','Sculpture','Alberto Giacometti','Walking Figure',1960,'Bronze','Collection','6','Numbered edition','00000000-0000-0000-0000-00000000c015',NULL,'00000000-0000-0000-0000-00000000c042','00000000-0000-0000-0000-00000000c032','00000000-0000-0000-0000-00000000c024', now(),now());

INSERT INTO main.valuation (id, asset_type, asset_id, amount, valuation_date, valuation_type, currency_id, source, methodology, created_at, updated_at) VALUES
 (gen_random_uuid(),'LIFESTYLE','00000000-0000-0000-0000-00000000be01',245000.00,'2024-06-30','market','USD','Hagerty','Comparable sales', now(),now()),
 (gen_random_uuid(),'LIFESTYLE','00000000-0000-0000-0000-00000000be01',262000.00,'2025-06-30','market','USD','Hagerty','Comparable sales', now(),now()),
 (gen_random_uuid(),'LIFESTYLE','00000000-0000-0000-0000-00000000be01',278500.00,'2026-06-01','market','USD','Hagerty','Comparable sales', now(),now()),
 (gen_random_uuid(),'LIFESTYLE','00000000-0000-0000-0000-00000000be02',218000.00,'2024-06-30','market','USD','Dealer','Comparable sales', now(),now()),
 (gen_random_uuid(),'LIFESTYLE','00000000-0000-0000-0000-00000000be02',231000.00,'2026-06-01','market','USD','Dealer','Comparable sales', now(),now()),
 (gen_random_uuid(),'LIFESTYLE','00000000-0000-0000-0000-00000000be03',178000.00,'2024-06-30','market','USD','KBB','Comparable sales', now(),now()),
 (gen_random_uuid(),'LIFESTYLE','00000000-0000-0000-0000-00000000be03',149000.00,'2026-06-01','market','USD','KBB','Comparable sales', now(),now()),
 (gen_random_uuid(),'LIFESTYLE','00000000-0000-0000-0000-00000000be04',1250000.00,'2024-05-15','appraisal','USD','Sothebys','Auction appraisal', now(),now()),
 (gen_random_uuid(),'LIFESTYLE','00000000-0000-0000-0000-00000000be04',1495000.00,'2026-05-15','appraisal','USD','Sothebys','Auction appraisal', now(),now()),
 (gen_random_uuid(),'LIFESTYLE','00000000-0000-0000-0000-00000000be05',860000.00,'2024-04-10','appraisal','USD','Christies','Auction appraisal', now(),now()),
 (gen_random_uuid(),'LIFESTYLE','00000000-0000-0000-0000-00000000be05',965000.00,'2026-04-10','appraisal','USD','Christies','Auction appraisal', now(),now());

-- ════════════════ OWNERSHIP: assign every asset to a family member/entity ════
INSERT INTO main.ownership (id, ownership_type, asset_id, asset_type, owner_id, share_percent, created_at, updated_at) VALUES
 -- Accounts
 (gen_random_uuid(),'joint','00000000-0000-0000-0000-000000acc001','account','00000000-0000-0000-0000-0000000000e3',60.00, now(),now()),
 (gen_random_uuid(),'joint','00000000-0000-0000-0000-000000acc001','account','00000000-0000-0000-0000-0000000000e4',40.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000acc002','account','00000000-0000-0000-0000-0000000000e1',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000acc003','account','00000000-0000-0000-0000-0000000000e2',100.00, now(),now()),
 -- Private investments (owner = holding LLC / trust)
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000000f11','private_investments','00000000-0000-0000-0000-0000000000e2',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000000f12','private_investments','00000000-0000-0000-0000-0000000000e1',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000000f13','private_investments','00000000-0000-0000-0000-0000000000e2',100.00, now(),now()),
 -- Lifestyle (cars to individuals, art to trust)
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-00000000be01','lifestyle','00000000-0000-0000-0000-0000000000e3',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-00000000be02','lifestyle','00000000-0000-0000-0000-0000000000e5',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-00000000be03','lifestyle','00000000-0000-0000-0000-0000000000e4',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-00000000be04','lifestyle','00000000-0000-0000-0000-0000000000e1',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-00000000be05','lifestyle','00000000-0000-0000-0000-0000000000e1',100.00, now(),now()),
 -- Structural: trust owns the LLC
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-0000000000e2','entity','00000000-0000-0000-0000-0000000000e1',100.00, now(),now());

COMMIT;
