#!/bin/bash
set -e

# Create the n8n database if it doesn't exist
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Database is already created by POSTGRES_DB environment variable
    -- Just ensure proper permissions
    GRANT ALL PRIVILEGES ON DATABASE n8n TO n8n;
EOSQL