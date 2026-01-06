# DockerDesktopEnvironment

Table Of Content
 * [Configuration](#configuration)
 * [Usage](#usage)
 * [Services](#services)
 
<a id="configuration"></a>
## Configuration

Copy **example.env** to **.env** file.   
Update the corresponding environment variables accordingly.
```
# POSTGRES
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=default
POSTGRES_HOST=postgres
POSTGRES_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@localhost:5432/${POSTGRES_DB}
...

```

<a id="usage"></a>
## Usage

```
Usage: dev.sh <service_name> <status>
   - <service_name> is: postgres, mariadb, listmonk
   - <status> is one of: start, stop, delete, test
```


<a id="services"></a>
## Services

MariaDB:
```
mariadb -h localhost -P 3306 -u root -p${MARIADB_ROOT_PASSWORD}
```

Postgres:
```
PGPASSWORD="${POSTGRES_PASSWORD}" psql -h localhost -p 5432 -U "${POSTGRES_USER}" -d "${POSTGRES_DB}"
```

Listmonk: 
[http://localhost:9000/](http://localhost:9000/)]

Dolibarr: 
[http://localhost:9001/](http://localhost:9001/)
