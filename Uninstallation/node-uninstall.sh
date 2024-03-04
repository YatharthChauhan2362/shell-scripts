#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo "Please run this script without sudo."
    exit 1
fi

# Source nvm.sh to ensure nvm is available
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if command -v nvm &> /dev/null; then
    echo "NVM is detected."
else
    echo "NVM is not detected. Please make sure NVM is installed and sourced correctly."
    exit 1
fi

if command -v node &> /dev/null; then
    echo "Node.js is already installed."

    read -p "Do you want to uninstall Node.js? (y/n): " uninstall_choice

    if [ "$uninstall_choice" == "y" ]; then
       
        echo "Uninstalling Node.js..."
        nvm deactivate
        nvm uninstall $(nvm current)
        rm -rf "$NVM_DIR"
        unset NVM_DIR
        echo "Node.js has been uninstalled, and NVM has been removed."
        exit 0
    else
        echo "Node.js was not uninstalled."
    fi
else
    echo "Node.js is not installed."
fi

echo "Script execution complete."

echo "Thank you for using this script - Yatharth Chauhan"
