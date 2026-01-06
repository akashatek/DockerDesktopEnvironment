-- Create the database only if it doesn't already exist
CREATE DATABASE IF NOT EXISTS ${DOLI_DB_NAME};

-- Create the user only if it doesn't already exist
CREATE USER IF NOT EXISTS '${DOLI_DB_USER}'@'%' IDENTIFIED BY '${DOLI_DB_PASSWORD}';

-- Grant privileges
GRANT ALL PRIVILEGES ON ${DOLI_DB_NAME}.* TO '${DOLI_DB_USER}'@'%';

-- Refresh the privilege tables
FLUSH PRIVILEGES;