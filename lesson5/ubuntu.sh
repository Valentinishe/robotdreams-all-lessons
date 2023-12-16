# !/bin/bash

sudo apt update -y


app_install() {
    if [ -n "$(dpkg -l | awk "/^ii  $1/")" ]; then
        echo "$1 already installed. Try to update:"
        apt-get install --only-upgrade $1 -y;
        return;
    fi
    echo "Installing $1...";
    apt-get install $1 -y;
}

# firewall
app_install "ufw"
sudo ufw allow ssh
sudo ufw allow 22
sudo ufw allow 2222
sudo ufw enable -y

# apache
app_install "apache2"
sudo ufw allow 'Apache'

# mariaDB
app_install "mariadb-server"
sudo systemctl start mariadb.service

# docker
app_install "docker.io"