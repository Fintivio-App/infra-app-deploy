-- =============================================================================
-- FRESH-path DEMO DATA (expansion). Applied after 30-demo-data.sql.
-- Adds: 5 accounts; ~24 assets + holdings across equities/fixed-income/commodities/
-- currencies/crypto (with 36mo history); 6 more PI funds (2 VC, 2 PE, 2 RE) with
-- cash flows; and a quarterly NAV valuation series for ALL 9 funds. RUN ONCE.
-- =============================================================================
BEGIN;

-- A few foreign currencies (org/home currency stays USD)
INSERT INTO main.currency (iso_code, name, symbol, created_at, updated_at) VALUES
 ('EUR','Euro','€', now(),now()),('GBP','British Pound','£', now(),now()),
 ('JPY','Japanese Yen','¥', now(),now()),('CHF','Swiss Franc','CHF', now(),now()),
 ('CAD','Canadian Dollar','C$', now(),now())
ON CONFLICT (iso_code) DO NOTHING;

-- Asset-type codes for the new classes
INSERT INTO public_markets.asset_type (id, code, name, description, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-0000000a7103','COMMODITIES','Commodities','Metals, energy', now(),now()),
 ('00000000-0000-0000-0000-0000000a7104','CURRENCIES','Currencies','FX holdings', now(),now()),
 ('00000000-0000-0000-0000-0000000a7105','CRYPTO','Crypto','Digital assets', now(),now())
ON CONFLICT (code) DO NOTHING;

-- New connector (Plaid) + brokerages + aggregator connections
INSERT INTO public_markets.connector (id, code, name, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-00000000c002','PLAID','Plaid', now(),now()) ON CONFLICT (id) DO NOTHING;
INSERT INTO public_markets.brokerage (id, code, name, website_url, is_recommended, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-00000000b003','MORGANSTANLEY','Morgan Stanley','https://morganstanley.com',true, now(),now()),
 ('00000000-0000-0000-0000-00000000b004','IBKR','Interactive Brokers','https://ibkr.com',true, now(),now()),
 ('00000000-0000-0000-0000-00000000b005','COINBASE','Coinbase','https://coinbase.com',false, now(),now())
ON CONFLICT (id) DO NOTHING;
INSERT INTO public_markets.brokerage_connector (brokerage_id, connector_id, is_default, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-00000000b003','00000000-0000-0000-0000-00000000c002',true, now(),now()),
 ('00000000-0000-0000-0000-00000000b004','00000000-0000-0000-0000-00000000c001',true, now(),now()),
 ('00000000-0000-0000-0000-00000000b005','00000000-0000-0000-0000-00000000c001',true, now(),now())
ON CONFLICT DO NOTHING;
INSERT INTO public_markets.aggregator_connection (id, entity_id, brokerage_id, connector_id, status, snaptrade_user_id, last_sync, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-0000000ac003','00000000-0000-0000-0000-0000000000e1','00000000-0000-0000-0000-00000000b003','00000000-0000-0000-0000-00000000c002','CONNECTED','demo-user', now(), now(),now()),
 ('00000000-0000-0000-0000-0000000ac004','00000000-0000-0000-0000-0000000000e3','00000000-0000-0000-0000-00000000b004','00000000-0000-0000-0000-00000000c001','CONNECTED','demo-user', now(), now(),now()),
 ('00000000-0000-0000-0000-0000000ac005','00000000-0000-0000-0000-0000000000e3','00000000-0000-0000-0000-00000000b005','00000000-0000-0000-0000-00000000c001','CONNECTED','demo-user', now(), now(),now())
ON CONFLICT (id) DO NOTHING;

-- 5 new accounts
INSERT INTO public_markets.account
 (id, entity_id, account_type, account_subtype, currency_id, status, account_mask, external_current_balance,
  snaptrade_account_id, aggregator_connection_id, last_sync, import_source, last_sync_status, account_name, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-000000acc004','00000000-0000-0000-0000-0000000000e1','BROKERAGE','CORPORATE','USD','ACTIVE','5510',6400000.00,'st-ms','00000000-0000-0000-0000-0000000ac003', now(),'AGGREGATOR_CONNECTION','UPDATED','Morgan Stanley', now(),now()),
 ('00000000-0000-0000-0000-000000acc005','00000000-0000-0000-0000-0000000000e3','BROKERAGE','INDIVIDUAL','USD','ACTIVE','7733',4100000.00,'st-ibkr','00000000-0000-0000-0000-0000000ac004', now(),'AGGREGATOR_CONNECTION','UPDATED','Interactive Brokers', now(),now()),
 ('00000000-0000-0000-0000-000000acc006','00000000-0000-0000-0000-0000000000e2','BROKERAGE','BUSINESS','USD','ACTIVE','2299',5200000.00, NULL, NULL, NULL,'MANUAL_REPORT', NULL,'JPMorgan Private Bank', now(),now()),
 ('00000000-0000-0000-0000-000000acc007','00000000-0000-0000-0000-0000000000e3','BROKERAGE','INDIVIDUAL','USD','ACTIVE','9001',1850000.00,'st-cb','00000000-0000-0000-0000-0000000ac005', now(),'AGGREGATOR_CONNECTION','UPDATED','Coinbase', now(),now()),
 ('00000000-0000-0000-0000-000000acc008','00000000-0000-0000-0000-0000000000e4','SAVINGS','PERSONAL','USD','ACTIVE','3318',1250000.00, NULL, NULL, NULL,'MANUAL_REPORT', NULL,'HSBC Savings', now(),now())
ON CONFLICT (id) DO NOTHING;

-- New assets (equities, fixed income, commodities, currencies, crypto)
INSERT INTO public_markets.asset (id, asset_type_id, name, ticker_symbol, market_identifier_code, currency_id, last_price, last_price_currency, sector, gic_sector, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-0000000a0011','00000000-0000-0000-0000-0000000a7101','Tesla Inc.','TSLA','XNAS','USD',250.20,'USD','Consumer Discretionary','Consumer Discretionary', now(),now()),
 ('00000000-0000-0000-0000-0000000a0012','00000000-0000-0000-0000-0000000a7101','Meta Platforms','META','XNAS','USD',562.40,'USD','Communication Services','Communication Services', now(),now()),
 ('00000000-0000-0000-0000-0000000a0013','00000000-0000-0000-0000-0000000a7101','Visa Inc.','V','XNYS','USD',281.10,'USD','Financials','Financials', now(),now()),
 ('00000000-0000-0000-0000-0000000a0014','00000000-0000-0000-0000-0000000a7101','UnitedHealth Group','UNH','XNYS','USD',482.00,'USD','Health Care','Health Care', now(),now()),
 ('00000000-0000-0000-0000-0000000a0015','00000000-0000-0000-0000-0000000a7102','US Treasury 4.25% 2034','UST10Y','XNYS','USD',98.50,'USD','Government','Government', now(),now()),
 ('00000000-0000-0000-0000-0000000a0016','00000000-0000-0000-0000-0000000a7102','US Treasury 4.0% 2027','UST2Y','XNYS','USD',99.20,'USD','Government','Government', now(),now()),
 ('00000000-0000-0000-0000-0000000a0017','00000000-0000-0000-0000-0000000a7102','Apple 3.85% 2031','AAPL31','XNYS','USD',96.80,'USD','Corporate','Corporate', now(),now()),
 ('00000000-0000-0000-0000-0000000a0018','00000000-0000-0000-0000-0000000a7102','Microsoft 3.3% 2032','MSFT32','XNYS','USD',94.10,'USD','Corporate','Corporate', now(),now()),
 ('00000000-0000-0000-0000-0000000a0019','00000000-0000-0000-0000-0000000a7102','California Muni 5% 2035','CAMUNI','XNYS','USD',101.30,'USD','Municipal','Municipal', now(),now()),
 ('00000000-0000-0000-0000-0000000a0020','00000000-0000-0000-0000-0000000a7102','US TIPS 2033','USTIPS','XNYS','USD',97.40,'USD','Government','Government', now(),now()),
 ('00000000-0000-0000-0000-0000000a0021','00000000-0000-0000-0000-0000000a7103','SPDR Gold Shares','GLD','XASE','USD',192.30,'USD','Commodities','Materials', now(),now()),
 ('00000000-0000-0000-0000-0000000a0022','00000000-0000-0000-0000-0000000a7103','iShares Silver Trust','SLV','XASE','USD',22.10,'USD','Commodities','Materials', now(),now()),
 ('00000000-0000-0000-0000-0000000a0023','00000000-0000-0000-0000-0000000a7103','United States Oil Fund','USO','XASE','USD',74.60,'USD','Commodities','Energy', now(),now()),
 ('00000000-0000-0000-0000-0000000a0024','00000000-0000-0000-0000-0000000a7103','Copper Futures ETF','CPER','XASE','USD',28.40,'USD','Commodities','Materials', now(),now()),
 ('00000000-0000-0000-0000-0000000a0025','00000000-0000-0000-0000-0000000a7103','abrdn Platinum ETF','PPLT','XASE','USD',92.70,'USD','Commodities','Materials', now(),now()),
 ('00000000-0000-0000-0000-0000000a0026','00000000-0000-0000-0000-0000000a7103','US Natural Gas Fund','UNG','XASE','USD',14.20,'USD','Commodities','Energy', now(),now()),
 ('00000000-0000-0000-0000-0000000a0027','00000000-0000-0000-0000-0000000a7104','Euro','EUR','XOFF','USD',1.0850,'USD','FX','FX', now(),now()),
 ('00000000-0000-0000-0000-0000000a0028','00000000-0000-0000-0000-0000000a7104','British Pound','GBP','XOFF','USD',1.2710,'USD','FX','FX', now(),now()),
 ('00000000-0000-0000-0000-0000000a0029','00000000-0000-0000-0000-0000000a7104','Japanese Yen','JPY','XOFF','USD',0.0067,'USD','FX','FX', now(),now()),
 ('00000000-0000-0000-0000-0000000a0030','00000000-0000-0000-0000-0000000a7104','Swiss Franc','CHF','XOFF','USD',1.1200,'USD','FX','FX', now(),now()),
 ('00000000-0000-0000-0000-0000000a0031','00000000-0000-0000-0000-0000000a7104','Canadian Dollar','CAD','XOFF','USD',0.7300,'USD','FX','FX', now(),now()),
 ('00000000-0000-0000-0000-0000000a0032','00000000-0000-0000-0000-0000000a7105','Bitcoin','BTC','XOFF','USD',62150.00,'USD','Crypto','Crypto', now(),now()),
 ('00000000-0000-0000-0000-0000000a0033','00000000-0000-0000-0000-0000000a7105','Ethereum','ETH','XOFF','USD',3410.00,'USD','Crypto','Crypto', now(),now()),
 ('00000000-0000-0000-0000-0000000a0034','00000000-0000-0000-0000-0000000a7105','Solana','SOL','XOFF','USD',146.50,'USD','Crypto','Crypto', now(),now())
ON CONFLICT (id) DO NOTHING;

-- Holdings across the new accounts (~26)
INSERT INTO public_markets.holding (id, account_id, asset_id, quantity, price, average_purchase_price, open_pnl, status, last_sync, last_sync_status, created_at, updated_at) VALUES
 -- Morgan Stanley (acc004): fixed income + equity
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc004','00000000-0000-0000-0000-0000000a0015',12000,98.50,97.00,18000.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc004','00000000-0000-0000-0000-0000000a0016',10000,99.20,99.00,2000.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc004','00000000-0000-0000-0000-0000000a0017',8000,96.80,95.50,10400.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc004','00000000-0000-0000-0000-0000000a0018',7000,94.10,96.00,-13300.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc004','00000000-0000-0000-0000-0000000a0011',3000,250.20,200.00,150600.00,'ACTIVE', now(),'UPDATED', now(),now()),
 -- Interactive Brokers (acc005): commodities + equity
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc005','00000000-0000-0000-0000-0000000a0021',5000,192.30,150.00,211500.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc005','00000000-0000-0000-0000-0000000a0022',40000,22.10,18.00,164000.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc005','00000000-0000-0000-0000-0000000a0023',6000,74.60,80.00,-32400.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc005','00000000-0000-0000-0000-0000000a0024',10000,28.40,25.00,34000.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc005','00000000-0000-0000-0000-0000000a0025',3000,92.70,88.00,14100.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc005','00000000-0000-0000-0000-0000000a0026',20000,14.20,16.00,-36000.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc005','00000000-0000-0000-0000-0000000a0012',1500,562.40,400.00,243600.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc005','00000000-0000-0000-0000-0000000a0014',1200,482.00,500.00,-21600.00,'ACTIVE', now(),'UPDATED', now(),now()),
 -- JPMorgan (acc006): fixed income + equity
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc006','00000000-0000-0000-0000-0000000a0019',15000,101.30,100.00,19500.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc006','00000000-0000-0000-0000-0000000a0020',12000,97.40,98.00,-7200.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc006','00000000-0000-0000-0000-0000000a0013',4000,281.10,210.00,284400.00,'ACTIVE', now(),'UPDATED', now(),now()),
 -- Coinbase (acc007): currencies + crypto
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc007','00000000-0000-0000-0000-0000000a0027',500000,1.0850,1.0700,7500.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc007','00000000-0000-0000-0000-0000000a0028',300000,1.2710,1.2500,6300.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc007','00000000-0000-0000-0000-0000000a0029',50000000,0.0067,0.0066,5000.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc007','00000000-0000-0000-0000-0000000a0030',200000,1.1200,1.1100,2000.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc007','00000000-0000-0000-0000-0000000a0031',250000,0.7300,0.7400,-2500.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc007','00000000-0000-0000-0000-0000000a0032',12,62150.00,40000.00,265800.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc007','00000000-0000-0000-0000-0000000a0033',150,3410.00,2500.00,136500.00,'ACTIVE', now(),'UPDATED', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000acc007','00000000-0000-0000-0000-0000000a0034',1500,146.50,90.00,84750.00,'ACTIVE', now(),'UPDATED', now(),now())
ON CONFLICT (account_id, asset_id) DO NOTHING;

-- 36-month history for the new brokerage accounts' holdings
INSERT INTO public_markets.holding_snapshot (id, holding_id, account_id, currency_id, asset_id, quantity, price, snapshot_timestamp, created_at)
SELECT gen_random_uuid(), h.id, h.account_id, 'USD', h.asset_id, h.quantity,
  ROUND((h.price * POWER(1.0085, -(35 - g.m)))::numeric, 8),
  (date_trunc('month', now()) - ((35 - g.m) || ' months')::interval + interval '1 month' - interval '1 day')::timestamptz,
  now()
FROM public_markets.holding h
CROSS JOIN generate_series(0,35) AS g(m)
WHERE h.account_id IN ('00000000-0000-0000-0000-000000acc004','00000000-0000-0000-0000-000000acc005',
                       '00000000-0000-0000-0000-000000acc006','00000000-0000-0000-0000-000000acc007');

-- ════════════════ 6 more PI funds (2 VC, 2 PE, 2 RE) ════════════════════════
INSERT INTO private_investments.fund (id, name, organization_id, fund_structure, dominical, size, vintige_year, currency, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-000000000f04','Redpoint Echo Fund I','00000000-0000-0000-0000-0000000000b1','LP','Delaware',180000000.00,2023,'USD', now(),now()),
 ('00000000-0000-0000-0000-000000000f05','Sequoia Seed Fund II','00000000-0000-0000-0000-0000000000b1','LP','Delaware',300000000.00,2021,'USD', now(),now()),
 ('00000000-0000-0000-0000-000000000f06','Vista Equity Partners VII','00000000-0000-0000-0000-0000000000b1','LP','Delaware',1200000000.00,2020,'USD', now(),now()),
 ('00000000-0000-0000-0000-000000000f07','Thoma Bravo Fund XV','00000000-0000-0000-0000-0000000000b1','LP','Delaware',950000000.00,2022,'USD', now(),now()),
 ('00000000-0000-0000-0000-000000000f08','Blackstone Property Fund II','00000000-0000-0000-0000-0000000000b1','LLC','Delaware',700000000.00,2021,'USD', now(),now()),
 ('00000000-0000-0000-0000-000000000f09','Starwood Opportunity XII','00000000-0000-0000-0000-0000000000b1','LLC','Delaware',650000000.00,2023,'USD', now(),now())
ON CONFLICT (id) DO NOTHING;

INSERT INTO private_investments.investment (id, organization_id, investment_type, name, investment_format, sponsor_name, is_deleted, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-000000000f14','00000000-0000-0000-0000-0000000000b1','VENTURE_CAPITAL','Redpoint Echo I — Commitment','FUND','Redpoint',false, now(),now()),
 ('00000000-0000-0000-0000-000000000f15','00000000-0000-0000-0000-0000000000b1','VENTURE_CAPITAL','Sequoia Seed II — Commitment','FUND','Sequoia',false, now(),now()),
 ('00000000-0000-0000-0000-000000000f16','00000000-0000-0000-0000-0000000000b1','PRIVATE_EQUITY','Vista VII — Commitment','FUND','Vista',false, now(),now()),
 ('00000000-0000-0000-0000-000000000f17','00000000-0000-0000-0000-0000000000b1','PRIVATE_EQUITY','Thoma Bravo XV — Commitment','FUND','Thoma Bravo',false, now(),now()),
 ('00000000-0000-0000-0000-000000000f18','00000000-0000-0000-0000-0000000000b1','RE_FUND','Blackstone Property II — Commitment','FUND','Blackstone',false, now(),now()),
 ('00000000-0000-0000-0000-000000000f19','00000000-0000-0000-0000-0000000000b1','RE_FUND','Starwood Opportunity XII — Commitment','FUND','Starwood',false, now(),now())
ON CONFLICT (id) DO NOTHING;

INSERT INTO private_investments.investment_fund (id, fund_id, general_partner_id, fund_stratagy, investment_id, created_at, updated_at) VALUES
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f04',NULL,'SEED','00000000-0000-0000-0000-000000000f14', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f05',NULL,'SEED','00000000-0000-0000-0000-000000000f15', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f06',NULL,'BUYOUT','00000000-0000-0000-0000-000000000f16', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f07',NULL,'BUYOUT','00000000-0000-0000-0000-000000000f17', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f08',NULL,'CORE_PLUS','00000000-0000-0000-0000-000000000f18', now(),now()),
 (gen_random_uuid(),'00000000-0000-0000-0000-000000000f09',NULL,'OPPORTUNISTIC','00000000-0000-0000-0000-000000000f19', now(),now());

INSERT INTO private_investments.asset (id, asset_type, investment_id, currency, name, ownership, amount, config_version, is_deleted, date, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-000000000f24','FUND','00000000-0000-0000-0000-000000000f14','USD','Redpoint Echo I Interest',1.0,1500000.00,'VENTURE_V1',false,'2023-05-01', now(),now()),
 ('00000000-0000-0000-0000-000000000f25','FUND','00000000-0000-0000-0000-000000000f15','USD','Sequoia Seed II Interest',1.0,2500000.00,'VENTURE_V1',false,'2021-09-01', now(),now()),
 ('00000000-0000-0000-0000-000000000f26','FUND','00000000-0000-0000-0000-000000000f16','USD','Vista VII Interest',1.0,6000000.00,'PRIVATE_EQUITY_V1',false,'2020-04-01', now(),now()),
 ('00000000-0000-0000-0000-000000000f27','FUND','00000000-0000-0000-0000-000000000f17','USD','Thoma Bravo XV Interest',1.0,4500000.00,'PRIVATE_EQUITY_V1',false,'2022-02-01', now(),now()),
 ('00000000-0000-0000-0000-000000000f28','FUND','00000000-0000-0000-0000-000000000f18','USD','Blackstone Property II Interest',1.0,3500000.00,'REAL_STATE_V1',false,'2021-03-01', now(),now()),
 ('00000000-0000-0000-0000-000000000f29','FUND','00000000-0000-0000-0000-000000000f19','USD','Starwood Opportunity XII Interest',1.0,2800000.00,'REAL_STATE_V1',false,'2023-07-01', now(),now())
ON CONFLICT (id) DO NOTHING;

-- 3 cash flows per new fund (2 calls + 1 distribution)
INSERT INTO private_investments.transaction (id, asset_id, currency, amount, type, description, is_deleted, original_datetime, created_at, updated_at) VALUES
 ('00000000-0000-0000-0000-000000000401','00000000-0000-0000-0000-000000000f24','USD',500000.00,'CAPITAL_CALL','Call #1',false,'2023-06-01', now(),now()),
 ('00000000-0000-0000-0000-000000000402','00000000-0000-0000-0000-000000000f24','USD',400000.00,'CAPITAL_CALL','Call #2',false,'2024-04-01', now(),now()),
 ('00000000-0000-0000-0000-000000000403','00000000-0000-0000-0000-000000000f25','USD',900000.00,'CAPITAL_CALL','Call #1',false,'2021-10-01', now(),now()),
 ('00000000-0000-0000-0000-000000000404','00000000-0000-0000-0000-000000000f25','USD',600000.00,'DISTRIBUTION','Secondary sale',false,'2024-06-01', now(),now()),
 ('00000000-0000-0000-0000-000000000405','00000000-0000-0000-0000-000000000f26','USD',3000000.00,'CAPITAL_CALL','Call #1',false,'2020-05-01', now(),now()),
 ('00000000-0000-0000-0000-000000000406','00000000-0000-0000-0000-000000000f26','USD',1500000.00,'DISTRIBUTION','Dividend recap',false,'2023-11-01', now(),now()),
 ('00000000-0000-0000-0000-000000000407','00000000-0000-0000-0000-000000000f27','USD',2200000.00,'CAPITAL_CALL','Call #1',false,'2022-03-01', now(),now()),
 ('00000000-0000-0000-0000-000000000408','00000000-0000-0000-0000-000000000f27','USD',900000.00,'DISTRIBUTION','Exit proceeds',false,'2025-01-15', now(),now()),
 ('00000000-0000-0000-0000-000000000409','00000000-0000-0000-0000-000000000f28','USD',1800000.00,'CAPITAL_CALL','Acquisition',false,'2021-04-01', now(),now()),
 ('00000000-0000-0000-0000-00000000040a','00000000-0000-0000-0000-000000000f28','USD',420000.00,'DISTRIBUTION','Rental income',false,'2024-09-01', now(),now()),
 ('00000000-0000-0000-0000-00000000040b','00000000-0000-0000-0000-000000000f29','USD',1400000.00,'CAPITAL_CALL','Acquisition',false,'2023-08-01', now(),now()),
 ('00000000-0000-0000-0000-00000000040c','00000000-0000-0000-0000-000000000f29','USD',300000.00,'DISTRIBUTION','Rental income',false,'2025-02-01', now(),now())
ON CONFLICT (id) DO NOTHING;

INSERT INTO private_investments.capital_call (id, transaction_id, due_date, created_at, updated_at)
SELECT gen_random_uuid(), t.id, (t.original_datetime + interval '14 days')::date, now(), now()
FROM private_investments.transaction t
WHERE t.id IN ('00000000-0000-0000-0000-000000000401','00000000-0000-0000-0000-000000000402','00000000-0000-0000-0000-000000000403',
               '00000000-0000-0000-0000-000000000405','00000000-0000-0000-0000-000000000407','00000000-0000-0000-0000-000000000409',
               '00000000-0000-0000-0000-00000000040b');

INSERT INTO private_investments.distribution (id, type, transaction_id, is_recallable, created_at, updated_at)
SELECT gen_random_uuid(), 'PROFIT_DISTRIBUTION', t.id, false, now(), now()
FROM private_investments.transaction t
WHERE t.id IN ('00000000-0000-0000-0000-000000000404','00000000-0000-0000-0000-000000000406','00000000-0000-0000-0000-000000000408',
               '00000000-0000-0000-0000-00000000040a','00000000-0000-0000-0000-00000000040c');

-- ════════════ Quarterly NAV valuation series for ALL 9 PI funds ════════════
-- One NAV mark per quarter from each position's start date to today; NAV compounds up.
INSERT INTO private_investments.valuation (id, asset_id, currency, amount, unrealized_gain, realized_gain, is_nav, is_entry, valustion_source, valuation_timestamp, created_at, is_deleted)
SELECT gen_random_uuid(), a.id, 'USD',
       ROUND((a.amount * (0.70 + 0.030 * g.q))::numeric, 2),
       ROUND((a.amount * 0.030 * g.q)::numeric, 2), 0,
       true, (g.q = 0), 'INTERNAL_ESTIMATE',
       (date_trunc('quarter', a.date::timestamptz) + ((g.q*3) || ' months')::interval),
       now(), false
FROM private_investments.asset a
CROSS JOIN generate_series(0, 18) AS g(q)
WHERE a.date IS NOT NULL
  AND (date_trunc('quarter', a.date::timestamptz) + ((g.q*3) || ' months')::interval) <= now();

-- ════════════ Ownership for new accounts + new funds ════════════════════════
INSERT INTO main.ownership (id, ownership_type, asset_id, asset_type, owner_id, share_percent, created_at, updated_at) VALUES
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000acc004','account','00000000-0000-0000-0000-0000000000e1',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000acc005','account','00000000-0000-0000-0000-0000000000e3',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000acc006','account','00000000-0000-0000-0000-0000000000e2',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000acc007','account','00000000-0000-0000-0000-0000000000e3',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000acc008','account','00000000-0000-0000-0000-0000000000e4',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000000f14','private_investments','00000000-0000-0000-0000-0000000000e2',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000000f15','private_investments','00000000-0000-0000-0000-0000000000e1',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000000f16','private_investments','00000000-0000-0000-0000-0000000000e2',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000000f17','private_investments','00000000-0000-0000-0000-0000000000e1',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000000f18','private_investments','00000000-0000-0000-0000-0000000000e2',100.00, now(),now()),
 (gen_random_uuid(),'whole','00000000-0000-0000-0000-000000000f19','private_investments','00000000-0000-0000-0000-0000000000e1',100.00, now(),now());

COMMIT;
