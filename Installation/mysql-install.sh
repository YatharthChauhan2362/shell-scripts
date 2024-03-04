#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script requires root privileges. Please run with sudo."
   exit 1
fi

if command -v mysql &> /dev/null; then
    read -p "MySQL is already installed. Do you want to uninstall it? (y/n): " UNINSTALL_CHOICE
    if [[ $UNINSTALL_CHOICE == "y" ]]; then
        apt remove --purge mysql-server mysql-client mysql-common -y
        apt autoremove -y
        apt clean
        echo "MySQL uninstalled successfully!"

        read -p "Do you want to reinstall MySQL? (y/n): " REINSTALL_CHOICE
        if [[ $REINSTALL_CHOICE == "n" ]]; then
            echo "Exiting without reinstalling MySQL."
            exit 0
        fi
    else
        echo "Exiting without uninstalling MySQL."
        exit 0
    fi
fi

wget https://dev.mysql.com/get/mysql-apt-config_0.8.12-1_all.deb
dpkg -i mysql-apt-config_0.8.12-1_all.deb

apt update

apt-cache madison mysql-server | grep -E "^\s+candidate:\s+mysql-server\s+\(([0-9]+\.[0-9]+)\)"

available_versions=($(apt-cache madison mysql-server | grep -E "^\s+candidate:\s+mysql-server\s+\(([0-9]+\.[0-9]+)\)" | awk '{print $3}'))

read -p "Enter the MySQL version you want to install (from available versions or 'latest'): " mysql_version

if [[ "$mysql_version" == "latest" ]]; then
   apt install -y mysql-server
else

   if [[ ! " ${available_versions[@]} " =~ " ${mysql_version} " ]]; then
       echo "Invalid version. Please choose from available versions."
       exit 1
   fi
   apt install -y "mysql-server-$mysql_version"
fi

systemctl start mysql
systemctl enable mysql  

echo "MySQL installation and configuration completed."
echo "Thank you for using this script - Yatharth Chauhan"