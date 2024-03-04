#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo "Please run this script (without sudo)."
    exit 1
fi

if [ -n "$NVM_DIR" ] && [ -s "$NVM_DIR/nvm.sh" ]; then
    echo "NVM is already installed."

    read -p "Do you want to uninstall NVM? (y/n): " uninstall_choice

    if [ "$uninstall_choice" == "y" ]; then
        echo "Uninstalling NVM..."
        (
            export NVM_DIR="$HOME/.nvm"
            [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
            [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  
            nvm deactivate || true
            command rm -rf "$NVM_DIR"
        )
        unset NVM_DIR
        echo "NVM has been uninstalled."

        read -p "Do you want to reinstall NVM? (y/n): " reinstall_choice
        if [ "$reinstall_choice" != "y" ]; then
            echo "Exiting script without changes."
            exit 0
        fi
    else
        echo "Exiting script without changes."
        exit 0
    fi
fi

available_versions=$(curl -s https://api.github.com/repos/nvm-sh/nvm/tags | grep -oP '"name": "v\K[^"]+')

echo "Please choose a NVM version:"
echo "$available_versions"

read -p "Enter the chosen version: " nvm_version

if [[ ! "$available_versions" =~ "$nvm_version" ]]; then
    echo "Invalid NVM version. Please choose from the listed versions."
    exit 1
fi

NVM_INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/nvm-sh/nvm/v$nvm_version/install.sh"

curl -o- "$NVM_INSTALL_SCRIPT_URL" | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

nvm --version

echo "NVM has been installed."

echo "Thank you for using this script - Yatharth Chauhan"
