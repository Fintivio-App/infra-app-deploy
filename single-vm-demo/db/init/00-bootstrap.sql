-- Runs ONCE, automatically, the first time the Postgres data volume is empty.
-- Creates the schemas the services expect and a separate database for Keycloak.
-- The application TABLES + seed data are loaded afterwards by scripts/04-init-db.sh
-- (Liquibase changelogs from fintivio-database-migrations).

CREATE SCHEMA IF NOT EXISTS main;
CREATE SCHEMA IF NOT EXISTS sandbox;
CREATE SCHEMA IF NOT EXISTS real_estate;

-- Create the keycloak database if it does not already exist.
SELECT 'CREATE DATABASE keycloak'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'keycloak')\gexec
