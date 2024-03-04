#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "This script requires root privileges. Please run with sudo."
    exit 1
fi

        apt remove --purge mysql-server mysql-client mysql-common -y
        apt autoremove -y
        apt clean
        rm -rf /etc/mysql /var/lib/mysql
        echo "MySQL uninstalled successfully!"

