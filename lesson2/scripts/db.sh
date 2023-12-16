#!/bin/bash

sudo apt update -y

curl -fsSL https://www.mongodb.4/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

sudo apt update

sudo apt install mongodb-org -y


sudo systemctl start mongod.service
sudo systemctl enable mongod

# setup mongod.conf for remote access
sed -i "s,\\(^[[:blank:]]*bindIp:\\) .*,\\1 0.0.0.0," /etc/mongod.conf

mongo --eval 'db.runCommand({ connectionStatus: 1 })'
mongo --eval 'db.createUser({user: "root", pwd: "root", roles: [ "dbAdmin" ]});'
mongo --eval 'db.auth("root", "root")'
mongo --eval 'use dev; db.createCollection("leaderboard");'
mongo --eval 'db.leaderboard.insert({ name: "John", points: 55 });'
mongo --eval 'db.leaderboard.insert({ name: "Bob", points: 92 });'
mongo --eval 'db.leaderboard.insert({ name: "Alise", points: 76 });'

exit