#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script using sudo."
    exit 1
fi

        systemctl stop nginx
        systemctl disable nginx
        apt remove --purge -y nginx  
        apt autoremove -y
        echo "Nginx has been uninstalled."
   
       

echo "Script execution complete."

echo "Thank you for using this script - Yatharth Chauhan"