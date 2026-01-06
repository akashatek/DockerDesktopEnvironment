-- 1. Force disconnect all users from the database
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = '${LISTMONK_DB_NAME}'
  AND pid <> pg_backend_pid();

-- 2. Drop the database
DROP DATABASE IF EXISTS ${LISTMONK_DB_NAME};

-- 3. Drop the user
DROP USER IF EXISTS ${LISTMONK_DB_USER};