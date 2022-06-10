# Restydock
一个使用简单的基于Docker的Openresty开发环境。

A simple Openresty development environment based on Docker.

### 运行环境 Requirements
Git version 2.17.1

Docker version 20.10.17

Docker Compose version v2.2.3

### 使用前方法 quik start

#### 第一步 基于.env.example生产自己的.env文件。First copy .env.example file to .env file
```bash
cp .env.example .env
```
#### 第二步 修改密码。 Second first change password
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
#### 第三步 启动开发环境 Third start your development environment

```bash
docker-compose up resty -d
```
#### 第四步 管理MySQL或MariaDB数据库 Forth admin your MySQL or MariaDB

需要操作MySQL或MariaDB数据库时需要先在.env里改一下引擎

```bash
# Accepted values: mariadb - mysql
PMA_DB_ENGINE=mariadb
```
然就启动 phpomyadmin
```bash
docker-compose up phpomyadmin -d
```
在服务器上放开8081端口
即可通过你的公网ip用 http://yourip:8081 访问phpomyadmin了。
用完建议执行下面命令把 phpomyadmin 停掉来防止攻击。

```bash
docker stop r-phpomyadmin-1
```
再次需要使用时可以用如下命令启动
```bash
docker start r-phpomyadmin-1
```
