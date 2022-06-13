#!/usr/bin/env bash
echo "Creating mongo users..."
# 打开下面注释即可在生成容器时创建用户，使用前先修改成自己的账号和密码。如未生效请删掉宿主机上 ~/.resty/data 下面的 mongo 和 mongo_config 目录然后再生成容器即可正常执行
# mongo --authenticationDatabase admin --host localhost -u root -p 'mySecret' --eval "db.createUser({user: 'restydock', pwd: 'mySecret', roles: [{role: 'readWrite', db: 'test'}]}); db.createUser({user: 'admin', pwd: 'mySecret', roles: [{role: 'userAdminAnyDatabase', db: 'admin'}]});"
echo "Mongo users created."