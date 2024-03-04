#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo "Please run this script (without sudo)."
    exit 1
fi

if [ -n "$NVM_DIR" ] && [ -s "$NVM_DIR/nvm.sh" ]; then
    echo "NVM is already installed."
    exit 00.39.4
fi


read -p "Choose NVM version installation: 
1. Latest version
2. Manual version selection
Enter your choice (press Enter for the latest version): " version_choice

if [ -z "$version_choice" ]; then
    version_choice="1"
fi

if [ "$version_choice" == "1" ]; then
    nvm_version="latest"
    if ! curl -o /dev/null -sfL "https://raw.githubusercontent.com/nvm-sh/nvm/v$nvm_version/install.sh"; then
        nvm_version="master"
    fi
else
    available_versions=$(curl -s https://api.github.com/repos/nvm-sh/nvm/tags | grep -oP '"name": "v\K[^"]+')
    echo "Available NVM versions:"
    echo "$available_versions"
    read -p "Enter the chosen version: " nvm_version
    if [[ ! "$available_versions" =~ "$nvm_version" ]]; then
        echo "Invalid NVM version. Please choose from the listed versions."
        exit 1
    fi
fi

NVM_INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/nvm-sh/nvm/$nvm_version/install.sh"

echo "Installing NVM version: $nvm_version"

curl -o- "$NVM_INSTALL_SCRIPT_URL" | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm --version

echo "NVM has been installed."

echo "Thank you for using this script - Yatharth Chauhan"
