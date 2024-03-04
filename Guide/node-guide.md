# NVM (Node Version Manager) Installation Script

## Overview
This Bash script automates the installation and configuration of NVM and Node.js on a Debian-based system. It provides options to install or uninstall Node.js and allows you to choose a specific version.

## Usage

1. **Make the script executable:**
    ```bash
    chmod +x node.sh
    ```

2. **Run the script without sudo:**
    ```bash
    ./node.sh
    ```

3. **Follow the on-screen prompts:**
   - If NVM is not installed, the script installs it and allows you to choose a Node.js version.
   - If Node.js is already installed, it asks if you want to uninstall it.

4. **Notes:**
   - The script checks if NVM is installed. If not, it installs NVM and sets up Node.js.
   - If Node.js is already installed, the script provides the option to uninstall it.
   - It allows you to choose a specific Node.js version during installation.

## Disclaimer
This script is provided as-is and without any warranty. Use it at your own risk.

## Author
[Yatharth Chauhan](https://github.com/YatharthChauhan2362)

