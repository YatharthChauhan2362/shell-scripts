#!/bin/bash

uninstall_php() {
    read -p "PHP is already installed. Do you want to uninstall it before proceeding? (y/n): " uninstall_choice
    if [ "$uninstall_choice" == "y" ]; then
        sudo apt-get purge -y php*
        sudo apt-get autoremove -y
        sudo apt-get clean

        
        # Ask if the user wants to reinstall PHP
        read -p "Do you want to reinstall PHP? (y/n): " reinstall_choice
        if [ "$reinstall_choice" == "n" ]; then
            echo "Skipping reinstallation."
            exit 0
        fi
    else
        echo "Skipping uninstallation."
    fi
}

install_php_cli() {
    read -p "Command 'php' not found. Do you want to install PHP CLI? (y/n): " install_cli_choice
    if [ "$install_cli_choice" == "y" ]; then
    sudo apt install php8.1-cli  # version 8.1.2-1ubuntu2.14, or
    sudo apt install php-cli     # version 2:8.1+92ubuntu1
        sudo apt-get update && sudo apt-get install -y php8.1-cli || sudo apt-get install -y php-cli
    else
        echo "Exiting."
        exit 1
    fi
}

install_php() {
    read -p "Enter the PHP version you want to install (or 'latest' for the newest available): " version_choice

    # Check for valid version input
    if [[ $version_choice == "latest" ]]; then
        latest_version=$(cat ~/php_versions | grep -Eo 'php[0-9]+\.[0-9]+' | tail -n 1)
        if [ -z "$latest_version" ]; then
            echo "No valid PHP versions found. Please check the available versions."
            exit 1
        fi
        sudo apt-get update && sudo apt-get install -y "$latest_version"
    else
        grep -q "^$version_choice" ~/php_versions || { echo "Invalid version. Please choose from available versions."; exit 1; }
        sudo apt-get update && sudo apt-get install -y "$version_choice"
    fi

    echo "PHP installation completed."
}

sudo apt update
sudo apt list --installed | grep php | awk -F'/' '{print $1}' > ~/php_versions

clear

echo "Available PHP versions:"
cat ~/php_versions
echo ""

if command -v php &> /dev/null; then
    uninstall_php
fi

install_php

echo "Thank you for using this script - Yatharth Chauhan"
