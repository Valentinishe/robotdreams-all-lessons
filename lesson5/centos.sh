# !/bin/bash

sudo yum update -y
sudo install dpkg -y

app_install() {
    if rpm -q "$1"; then
        echo "$1 already installed. Try to update:"
        sudo yum install $1 -y;
        return;
    fi
    echo "Installing $1...";
    sudo yum install $1 -y;
}

# firewall
# sudo systemctl status ufw
app_install "firewalld"
# sudo ufw allow ssh
# sudo ufw allow 22
# sudo ufw allow 2222
# sudo ufw enable -y

# apache
# sudo systemctl status apache2
# app_install "apache2"
# sudo ufw allow 'Apache'

# mariaDB
# sudo systemctl status mariadb.service
# app_install "MariaDB-server"
# sudo systemctl start mariadb.service

# docker
# sudo systemctl status docker
# app_install "docker-ce"
# sudo systemctl start docker
