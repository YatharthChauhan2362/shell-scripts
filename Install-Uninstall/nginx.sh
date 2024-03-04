#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script using sudo."
    exit 1
fi

nginx_version=""
nginx_installed=false

if command -v nginx &>/dev/null; then
    nginx_installed=true
    echo "Nginx is already installed."
    read -p "Do you want to uninstall it? (y/n): " uninstall_choice

    if [ "$uninstall_choice" == "y" ]; then
        systemctl stop nginx
        systemctl disable nginx
        apt remove --purge -y nginx  # Use -y to automatically answer "yes"
        apt autoremove -y
        echo "Nginx has been uninstalled."
    else
        echo "Skipping uninstallation."
        exit 0
    fi
fi

if [ "$nginx_installed" == true ]; then
    read -p "Do you want to reinstall Nginx? (y/n): " reinstall_choice

    if [ "$reinstall_choice" == "n" ]; then
        echo "Skipping reinstallation."
        exit 0
    fi
fi

echo "Do you want to install the latest version or specify a manual version?"
echo "1. Latest version"
echo "2. Specify manual version"
read -p "Enter your choice (1/2): " version_choice

if [ "$version_choice" == "1" ]; then
    echo "Installing the latest version of Nginx."
else
    echo "Available Nginx versions:"
    apt-cache madison nginx | awk '{print $3}'
    read -p "Enter the desired version: " nginx_version
fi

wget https://nginx.org/keys/nginx_signing.key
apt-key add nginx_signing.key
sh -c 'echo "deb http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx" >> /etc/apt/sources.list.d/nginx.list'
sh -c 'echo "deb http://nginx.org/packages/mainline/ubuntu $(lsb_release -cs) nginx" >> /etc/apt/sources.list.d/nginx.list'

apt update

if [ "$version_choice" == "1" ]; then
    apt install -y nginx  # Use -y to automatically answer "yes"
else
    apt install -y nginx=$nginx_version  # Use -y to automatically answer "yes"
fi

systemctl start nginx
systemctl enable nginx

echo "Installed Nginx version:"
nginx -v

echo "Nginx status:"
systemctl status nginx

echo "Thank you for using this script - Yatharth Chauhan"
