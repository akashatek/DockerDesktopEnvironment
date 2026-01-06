# DockerDesktopEnvironment

## Table Of Content

Components:
 * [Configuration](#configuration)
 * [Usage](#usage)
 
<a id="configuration"></a>
## Configuration

Copy **example.env** to **.env** file.   
Update the corresponding environment variables accordingly.
```
# LOCALHOST
LOCALHOST=localhost

# POSTGRES
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=default
POSTGRES_HOST=postgres
POSTGRES_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${LOCALHOST}:5432/${POSTGRES_DB}

# MARIADB
MARIADB_ROOT_PASSWORD=root
MARIADB_USER=mariadb
MARIADB_PASSWORD=mariadb
MARIADB_DB=default
MARIADB_HOST=mariadb
MARIADB_URI=mariadb://${MARIADB_USER}:${MARIADB_PASSWORD}@${LOCALHOST}:3306/${MARIADB_DB}

# Listmonk
LISTMONK_DB_USER=listmonk
LISTMONK_DB_PASSWORD=listmonk
LISTMONK_DB_NAME=listmonk
LISTMONK_HOST=listmonk
LISTMONK_ADMIN_USER=admin
LISTMONK_ADMIN_PASSWORD=admin123
```

<a id="usage"></a>
## Usage

````
Usage: dev.sh <service_name> <status>
   - <service_name> is: postgres, mariadb, listmonk
   - <status> is one of: start, stop, delete, test
```
