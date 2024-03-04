#!/bin/bash

DEFAULT_VERSION="latest"

if command -v mongod &> /dev/null; then
    read -p "MongoDB is already installed. Do you want to uninstall it? (y/n): " UNINSTALL_CHOICE
    if [[ $UNINSTALL_CHOICE == "y" ]]; then
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo apt remove --purge mongodb-org
            sudo rm -r /var/log/mongodb
            sudo rm -r /var/lib/mongodb
            sudo apt autoremove
        
        else
            echo "Uninstallation for this OS is not supported by this script."
            exit 1
        fi
        echo "MongoDB uninstalled successfully!"

        read -p "Do you want to install MongoDB? (y/n): " REINSTALL_CHOICE
        if [[ $REINSTALL_CHOICE == "n" ]]; then
            echo "Exiting without reinstalling MongoDB."
            exit 0
        fi
    else
        echo "Exiting without uninstalling MongoDB."
        exit 0
    fi
fi

AVAILABLE_VERSIONS=$(apt-cache madison mongodb-org | grep '^mongodb-org |' | cut -d '|' -f 2)

echo "Available MongoDB versions:"
echo "$AVAILABLE_VERSIONS"
echo "(Enter 'latest' for the newest version)"

read -p "Enter the desired MongoDB version (leave blank for $DEFAULT_VERSION): " MONGO_VERSION

if [[ -z "$MONGO_VERSION" ]]; then
    MONGO_VERSION=$DEFAULT_VERSION
fi

if [[ "$MONGO_VERSION" != "latest" && ! "$AVAILABLE_VERSIONS" =~ "$MONGO_VERSION" ]]; then
    echo "Invalid version. Please choose from the listed versions or enter 'latest'."
    exit 1
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update

    if [[ "$MONGO_VERSION" == "latest" ]]; then
        sudo apt install -y mongodb-org
    else
        sudo apt install -y mongodb-org=$MONGO_VERSION
    fi 

    if [[ ! -f "/etc/apt/sources.list.d/mongodb-org.list" ]]; then
        sudo mv /etc/apt/sources.list.d/mongodb-org /etc/apt/sources.list.d/mongodb-org.list
        sudo apt update
    fi

    sudo apt -f install



else
    echo "Installation for this OS is not currently supported by this script."
    exit 1
fi

if grep -q "^MongoDB server version: $MONGO_VERSION" <<< "$(mongod --version)"; then
    echo "MongoDB $MONGO_VERSION installed successfully!"
    exit 1
fi

echo "Thank you for using this script - Yatharth Chauhan"