-- Create the database only if it doesn't already exist
CREATE DATABASE IF NOT EXISTS ${VTIGER_DB_NAME};

-- Create the user only if it doesn't already exist
CREATE USER IF NOT EXISTS '${VTIGER_DB_USER}'@'%' IDENTIFIED BY '${VTIGER_DB_PASSWORD}';

-- Grant privileges
GRANT ALL PRIVILEGES ON ${VTIGER_DB_NAME}.* TO '${VTIGER_DB_USER}'@'%';

-- Refresh the privilege tables
FLUSH PRIVILEGES;