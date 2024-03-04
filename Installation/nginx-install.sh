#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with administrative privileges."
    exit 1
fi

if command -v nginx &> /dev/null; then
    echo "Nginx is already installed. Exiting."
    exit 0
fi

echo "Do you want to install the latest version or specify a manual version?"
echo "1. Latest version"
echo "2. Specify manual version"
read -p "Enter your choice (1/2): " version_choice

if [ "$version_choice" == "1" ] || [ -z "$version_choice" ]; then
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

if [ "$version_choice" == "1" ] || [ -z "$version_choice" ]; then
    apt install -y nginx
else
    apt install -y nginx=$nginx_version
fi

systemctl start nginx
systemctl enable nginx

echo "Installed Nginx version:"
nginx -v

echo "Nginx status:"
systemctl status nginx

echo "Thank you for using this script - Yatharth Chauhan"
