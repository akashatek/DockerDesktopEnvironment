# DockerDesktopEnvironment

## Table Of Content

Components:
 * [configuration](#Configuration)
 * [Postgres](#Postgres)

<a id="Configuration"></a>
## Configuration

Copy **example.env** to **.env** file.   
Update the corresponding environment variables accordingly.
```
# LOCALHOST
LOCALHOST=localhost

# POSTGRES
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=postgres
POSTGRES_URL=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${LOCALHOST}:5432/${POSTGRES_DB}
```

<a id="Postgres"></a>
## Postgres 

Start or Restart the service
```
docker-compose -f postgres.yaml up -d
````

Stop the service.
```
docker-compose -f postgres.yaml down
```

Delete the service and killing volumes
```
docker-compose -f postgres.yaml down -v
```

Test the service
```
> psql ${POSTGRES_URI}
psql (17.6, server 17.5 (Debian 17.5-1.pgdg130+1))
Type "help" for help.

postgres=# 
psql (17.6, server 17.5 (Debian 17.5-1.pgdg130+1))
Type "help" for help.

postgres=# \du
                             List of roles
 Role name |                         Attributes                         
-----------+------------------------------------------------------------
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS

postgres=# \l
                                                    List of databases
   Name    |  Owner   | Encoding | Locale Provider |  Collate   |   Ctype    | Locale | ICU Rules |   Access privileges   
-----------+----------+----------+-----------------+------------+------------+--------+-----------+-----------------------
 postgres  | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           | 
 template0 | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           | =c/postgres          +
           |          |          |                 |            |            |        |           | postgres=CTc/postgres
 template1 | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           | =c/postgres          +
           |          |          |                 |            |            |        |           | postgres=CTc/postgres
(3 rows)

postgres=# \q
```
