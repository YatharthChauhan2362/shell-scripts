#!/bin/bash

DEFAULT_VERSION="latest"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    yes | sudo apt remove --purge mongodb-org
    yes | sudo rm -r /var/log/mongodb
    yes | sudo rm -r /var/lib/mongodb
    yes | sudo apt autoremove
else
    echo "Uninstallation for this OS is not supported by this script."
    exit 1
fi

echo "MongoDB uninstalled successfully!"
echo "Thank you for using this script - Yatharth Chauhan"
