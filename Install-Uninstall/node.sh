#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo "Please run this script without sudo."
    exit 1
fi

if command -v nvm &> /dev/null; then
    echo "NVM is already installed."
else
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    source "$NVM_DIR/nvm.sh"

    # Check nvm version
    nvm --version

    echo "NVM has been installed."
fi

if command -v node &> /dev/null; then
    echo "Node.js is already installed."

    read -p "Do you want to uninstall Node.js? (y/n): " uninstall_choice

    if [ "$uninstall_choice" == "y" ]; then
        # Uninstall Node.js
        echo "Uninstalling Node.js..."
        nvm uninstall $(nvm current)
        sudo apt-get remove --purge nodejs npm
        sudo apt-get autoremove

        echo "Node.js has been uninstalled."
        exit 0
    else
        echo "Node.js was not uninstalled."
    fi
else
    echo "Do you want to install the latest version or specify a manual version?"
    echo "1. Latest version"
    echo "2. Specify manual version"
    read -p "Enter your choice (1/2): " version_choice

    if [ "$version_choice" == "1" ]; then
        nvm install node  # Latest version
    elif [ "$version_choice" == "2" ]; then
        nvm ls-remote  # Show all available versions
        read -p "Choose a Node.js version from the list above: " node_version
        nvm install "$node_version"
        nvm alias default "$node_version"
        echo "Installed Node.js version: $node_version"
    else
        echo "Invalid choice. Exiting."
        exit 1
    fi

    echo "Node.js version:"
    node -v

    echo "NPM version:"
    npm -v
fi

echo "Script execution complete."

echo "Thank you for using this script - Yatharth Chauhan"
