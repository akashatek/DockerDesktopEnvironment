#!/bin/bash

export $(grep -v '^#' .env | xargs)

# Case statement to handle different arguments
case "$1" in
   postgres)
      case "$2" in
         start)
            docker compose -f ./Script/postgres.yaml up -d
            ;;
         stop)
            docker compose -f ./Script/postgres.yaml down
            ;;
         delete)
            docker compose -f ./Script/postgres.yaml down -v
            ;;
         test)
            echo "> \l"
            PGPASSWORD="${POSTGRES_PASSWORD}" psql -h localhost -p 5432 -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -c "\l"
            ;;
      esac
      ;;
   mariadb)
      case "$2" in
         start)
            docker compose -f ./Script/mariadb.yaml up -d
            ;;
         stop)
            docker compose -f ./Script/mariadb.yaml down
            ;;
         delete)
            docker compose -f ./Script/mariadb.yaml down -v
            ;;
         test)
            echo "> SHOW DATABASES;"
            mariadb -h localhost -P 3306 -u root -p${MARIADB_ROOT_PASSWORD} -e "SHOW DATABASES;"
            ;;
      esac
      ;;
   dolibarr)
      case "$2" in
         start)
            cat ./SQL/dolibarr_create.sql | envsubst |  mariadb -h localhost -P 3306 -u root -p${MARIADB_ROOT_PASSWORD}
            docker compose -f ./Script/dolibarr.yaml up -d
            ;;
         stop)
            docker compose -f ./Script/dolibarr.yaml down
            ;;
         delete)
            docker compose -f ./Script/dolibarr.yaml down -v
            cat ./SQL/dolibarr_delete.sql | envsubst |  mariadb -h localhost -P 3306 -u root -p${MARIADB_ROOT_PASSWORD}
            ;;
         test)
            echo "--- USER & HOST ---";
            mariadb -h 127.0.0.1 -u root -p"${MARIADB_ROOT_PASSWORD}" -e "SELECT User, Host FROM mysql.user WHERE User='${DOLI_DB_USER}';"
            echo "--- PERMISSIONS ---";
            mariadb -h 127.0.0.1 -u root -p"${MARIADB_ROOT_PASSWORD}" -e "SHOW GRANTS FOR '${DOLI_DB_USER}'@'%';"
            ;;
      esac
      ;;
   monica)
      case "$2" in
         start)
            cat ./SQL/monica_create.sql | envsubst |  mariadb -h localhost -P 3306 -u root -p${MARIADB_ROOT_PASSWORD}
            docker compose -f ./Script/monica.yaml up -d
            ;;
         stop)
            docker compose -f ./Script/monica.yaml down
            ;;
         delete)
            docker compose -f ./Script/monica.yaml down -v
            cat ./SQL/monica_delete.sql | envsubst |  mariadb -h localhost -P 3306 -u root -p${MARIADB_ROOT_PASSWORD}
            ;;
         test)
            echo "--- USER & HOST ---";
            mariadb -h 127.0.0.1 -u root -p"${MARIADB_ROOT_PASSWORD}" -e "SELECT User, Host FROM mysql.user WHERE User='${MONICA_DB_USER}';"
            echo "--- PERMISSIONS ---";
            mariadb -h 127.0.0.1 -u root -p"${MARIADB_ROOT_PASSWORD}" -e "SHOW GRANTS FOR '${MONICA_DB_USER}'@'%';"
            ;;
      esac
      ;;
   listmonk)
      case "$2" in
         start)
            cat ./SQL/listmonk_create.sql | envsubst | PGPASSWORD="${POSTGRES_PASSWORD}" psql -h localhost -p 5432 -U "${POSTGRES_USER}" -d "${POSTGRES_DB}"
            docker compose -f ./Script/listmonk.yaml up -d
            ;;
         stop)
            docker compose -f ./Script/listmonk.yaml down
            ;;
         delete)
            docker compose -f ./Script/listmonk.yaml down -v
            cat ./SQL/listmonk_delete.sql | envsubst | PGPASSWORD="${POSTGRES_PASSWORD}" psql -h localhost -p 5432 -U "${POSTGRES_USER}" -d "${POSTGRES_DB}"
            ;;
         test)
            curl -X GET -I http://localhost:9000
            ;;
      esac
      ;;
   vtigercrm)
      case "$2" in
         start)
            cat ./SQL/vtigercrm_create.sql | envsubst |  mariadb -h localhost -P 3306 -u root -p${MARIADB_ROOT_PASSWORD}
            docker compose -f ./Script/vtigercrm.yaml up -d
            ;;
         stop)
            docker compose -f ./Script/vtigercrm.yaml down
            ;;
         delete)
            docker compose -f ./Script/vtigercrm.yaml down -v
            cat ./SQL/vtigercrm_delete.sql | envsubst |  mariadb -h localhost -P 3306 -u root -p${MARIADB_ROOT_PASSWORD}
            ;;
         test)
            echo "--- USER & HOST ---";
            mariadb -h 127.0.0.1 -u root -p"${MARIADB_ROOT_PASSWORD}" -e "SELECT User, Host FROM mysql.user WHERE User='${VTIGER_DB_USER}';"
            echo "--- PERMISSIONS ---";
            mariadb -h 127.0.0.1 -u root -p"${MARIADB_ROOT_PASSWORD}" -e "SHOW GRANTS FOR '${VTIGER_DB_USER}'@'%';"
            ;;
      esac
      ;;
   ollama)
      case "$2" in
         start)
            docker compose -f ./Script/ollama.yaml up -d
            ;;
         stop)
            docker compose -f ./Script/ollama.yaml down
            ;;
         delete)
            docker compose -f ./Script/ollama.yaml down -v
            ;;
         test)
            curl http://localhost:11434/api/generate -d '{"model": "llama3.2:1b", "prompt": "Why is the sky blue?", "stream": false }'
            ;;
      esac
      ;;
   *)
      echo "Usage: $0 <service_name> <status>"
      echo "   - <service_name> is: postgres, mariadb, listmonk, dolibarr, vtigercrm, ollama"
      echo "   - <status> is one of: start, stop, delete, test"
      exit 1
      ;;
esac

exit 0