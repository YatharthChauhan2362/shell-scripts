#!/bin/bash

install_php() {
    echo "Installing PHP..."
    sudo add-apt-repository -y ppa:ondrej/php
    sudo apt-get update
    sudo apt-get install -y php"$1" php"$1"-fpm php"$1"-cli php"$1"-mysql php"$1"-gd \
               php-i.sh       php"$1"-curl php"$1"-mbstring php"$1"-xml
    sudo systemctl start php"$1"-fpm
    sudo systemctl enable php"$1"-fpm
}


read -p "Install latest version (1) or enter a specific version (2): " choice

if [[ $choice = "1" ]] || [[ -z $choice ]]; then
    
    install_php
elif [[ $choice = "2" ]]; then
   
    read -p "Enter the PHP version you want to install (e.g., 7.4, 8.1): " php_version

    
    if [[ $php_version =~ ^[0-9]+\.[0-9]+$ ]]; then
        install_php "$php_version"
    else
        echo "Invalid version format. Please enter a version like 7.4 or 8.1."
        exit 1
    fi
else
    echo "Invalid choice. Please enter 1 or 2."
    exit 1
fi

echo "PHP installation complete!"
