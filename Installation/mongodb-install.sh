#!/bin/bash

DEFAULT_VERSION="latest"

AVAILABLE_VERSIONS=$(apt-cache madison mongodb-org | grep '^mongodb-org |' | cut -d '|' -f 2)

echo "Available MongoDB versions:"
echo "$AVAILABLE_VERSIONS"
echo "(Enter 'latest' for the newest version)"

read -p "Enter the desired MongoDB version (leave blank for $DEFAULT_VERSION): " MONGO_VERSION

if [[ -z "$MONGO_VERSION" ]]; then
    MONGO_VERSION=$DEFAULT_VERSION
fi

if [[ "$MONGO_VERSION" != "latest" && ! $AVAILABLE_VERSIONS =~ $MONGO_VERSION ]]; then
    echo "Invalid version. Please choose from the listed versions or enter 'latest'."
    exit 1
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | gpg --dearmor -o /usr/share/keyrings/mongodb-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/mongodb-archive-keyring.gpg] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/$MONGO_VERSION multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-$MONGO_VERSION.list > /dev/null

    sudo apt-get update

    sudo apt-get install -y libcurl4 libssl1.1 mongodb-org

    sudo systemctl start mongod
    sudo systemctl enable mongod

    echo "MongoDB installation and configuration completed."
else
    echo "Installation for this OS is not currently supported by this script."
    exit 1
fi

if pgrep -x "mongod" > /dev/null; then
    echo "MongoDB $MONGO_VERSION installed and running successfully!"
else
    echo "MongoDB installation failed. Check the MongoDB service status."
fi

echo "Thank you for using this script - Yatharth Chauhan"
