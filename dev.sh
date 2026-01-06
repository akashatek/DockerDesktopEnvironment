#!/bin/bash

source .env

# Case statement to handle different arguments
case "$1" in
   postgres)
      case "$2" in
         start)
            docker compose -f postgres.yaml up -d
            ;;
         stop)
            docker compose -f postgres.yaml down
            ;;
         delete)
            docker compose -f postgres.yaml down -v
            ;;
         test)
            echo "> \l"
            psql ${POSTGRES_URI} -c '\l'
            ;;
      esac
      ;;
   mariadb)
      case "$2" in
         start)
            docker compose -f mariadb.yaml up -d
            ;;
         stop)
            docker compose -f mariadb.yaml down
            ;;
         delete)
            docker compose -f mariadb.yaml down -v
            ;;
         test)
            echo "> SHOW DATABASES;"
            docker exec mariadb mariadb -u root -proot -e "SHOW DATABASES;"
            ;;
      esac
      ;;
   listmonk)
      case "$2" in
         start)
            cat ./Listmonk/listmonk.sql | envsubst | psql ${POSTGRES_URI}
            docker compose -f listmonk.yaml up -d
            ;;
         stop)
            docker compose -f listmonk.yaml down
            ;;
         delete)
            docker compose -f listmonk.yaml down -v
            ;;
         test)
            curl -X GET -I http://localhost:9000
            ;;
      esac
      ;;
   *)
      echo "Usage: $0 <service_name> <status>"
      echo "   - <service_name> is: postgres, mariadb, listmonk"
      echo "   - <status> is one of: start, stop, delete, test"
      exit 1
      ;;
esac

exit 0