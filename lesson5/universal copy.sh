# !/bin/bash

OS="";

# функція, що визначає операційну систему.
detect_os() { 
  if [ -f /etc/lsb-release ]; then
    OS="ubuntu";
    sudo apt-get update
  elif [[ $(</etc/redhat-release) == *"Fedora"* ]]; then
    OS="fedora";
  elif [[ $(</etc/redhat-release) =~ .*"CentOS".* ]]; then
    OS="centos";
    sudo yum update -y
  else
    echo "Unsupported OS."
    exit 1
  fi
}

# універсальна функція що встановлює або оновлює пакет
install_or_update_package() {
  package_name="$1"

  echo "Name of package: $package_name";
  case "$OS" in
    "ubuntu")
      # оновлення пакету
      if [ -n "$(dpkg -l | awk "/^ii  $1/")" ]; then
        echo "$package_name is already installed. Updating..."
        sudo apt-get update
        sudo apt-get upgrade "$package_name" -y
      # встановлення пакету
      else
        echo "$package_name is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install "$package_name" -y 
      fi
    ;;
    "fedora")
      # оновлення пакету
      if rpm -q "$package_name"; then
        echo "$package_name is already installed. Updating..."
        sudo dnf update "$package_name" -y 
      # встановлення пакету
      else
        echo "$package_name is not installed. Installing..."
        sudo dnf install "$package_name" -y
      fi
    ;;
    "centos")
      # оновлення пакету
      if rpm -q "$package_name"; then
        echo "$package_name is already installed. Updating...";
        sudo yum update "$package_name" -y;
      # встановлення пакету
      else
        echo "$package_name is not installed. Installing...";
        sudo yum install "$package_name" -y;
      fi
    ;;
  esac
}


detect_os;
echo "$OS";

# перебір пакетів
for package_name in "$@"; do
  install_or_update_package "$package_name";
done
