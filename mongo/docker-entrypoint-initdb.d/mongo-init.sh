#!/usr/bin/env bash
echo "Creating mongo users..."
mongo --authenticationDatabase admin --host localhost -u root -p 'mySecret' --eval "db.createUser({user: 'restydock', pwd: 'secret', roles: [{role: 'readWrite', db: 'test'}]}); db.createUser({user: 'admin', pwd: 'mySecret', roles: [{role: 'userAdminAnyDatabase', db: 'admin'}]});"
echo "Mongo users created."