-- Create the database only if it doesn't already exist
CREATE DATABASE IF NOT EXISTS ${MONICA_DB_NAME};

-- Create the user only if it doesn't already exist
CREATE USER IF NOT EXISTS '${MONICA_DB_USER}'@'%' IDENTIFIED BY '${MONICA_DB_PASSWORD}';

-- Grant privileges
GRANT ALL PRIVILEGES ON ${MONICA_DB_NAME}.* TO '${MONICA_DB_USER}'@'%';

-- Refresh the privilege tables
FLUSH PRIVILEGES;