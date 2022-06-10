# restydock
openresty docker development environment

### 运行环境 Requirements
Git version 2.17.1

Docker version 20.10.17

Docker Compose version v2.2.3

### 使用前方法 quik start

#### 第一步 first
```bash
cp .env.example .env
```
#### 第二步 second
把下面的"mySecret"改成自己的密码比如 RRpCc%nCEWSf6xJD

before you use restydock, change password the "mySecret" to your password such as RRpCc%nCEWSf6xJD

change this in the .env
```bash
MARIADB_PASSWORD=mySecret
MARIADB_ROOT_PASSWORD=mySecret
MYSQL_PASSWORD=mySecret
MYSQL_ROOT_PASSWORD=mySecret
POSTGRES_PASSWORD=mySecret
POSTGIS_PASSWORD=mySecret
MONGO_PASSWORD=mySecret
# Database admin tools
PMA_PASSWORD=mySecret
PMA_ROOT_PASSWORD=mySecret
PGADMIN_DEFAULT_PASSWORD=mySecret
REDIS_WEBUI_PASSWORD=mySecret
```
to
```bash
MARIADB_PASSWORD=RRpCc%nCEWSf6xJD
MARIADB_ROOT_PASSWORD=RRpCc%nCEWSf6xJD
MYSQL_PASSWORD=RRpCc%nCEWSf6xJD
MYSQL_ROOT_PASSWORD=RRpCc%nCEWSf6xJD
POSTGRES_PASSWORD=RRpCc%nCEWSf6xJD
POSTGIS_PASSWORD=RRpCc%nCEWSf6xJD
MONGO_PASSWORD=RRpCc%nCEWSf6xJD
# Database admin tools
PMA_PASSWORD=RRpCc%nCEWSf6xJD
PMA_ROOT_PASSWORD=RRpCc%nCEWSf6xJD
PGADMIN_DEFAULT_PASSWORD=RRpCc%nCEWSf6xJD
REDIS_WEBUI_PASSWORD=RRpCc%nCEWSf6xJD
```
#### 第三步 third

```bash
docker-compose up resty -d
```
