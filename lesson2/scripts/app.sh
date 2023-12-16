#!/bin/bash

sudo apt update -y

sudo apt install -y curl 

curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash - 

# bash nodesource_setup.sh
sudo apt install nodejs -y
sudo apt install npm -y

# rm /tmp/nodesource_setup.sh

# Install pm2
npm install -g pm2

pm2 start app/server.js