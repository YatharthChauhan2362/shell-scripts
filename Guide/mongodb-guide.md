# MongoDB Installation Script

## Overview
This Bash script automates the installation and configuration of MongoDB on a Debian-based system. It provides options to uninstall and reinstall MongoDB, and allows you to choose the desired version.

## Usage

1. **Make the script executable:**
    ```bash
    chmod +x mongodb.sh
    ```

2. **Run the script:**
    ```bash
    sudo ./mongodb.sh
    ```

3. **Follow the on-screen prompts:**
   - If MongoDB is already installed, the script will ask if you want to uninstall it.
   - If you choose to uninstall, it will remove MongoDB and prompt you to reinstall.
   - You can choose a specific version of MongoDB to install or opt for the latest version.

4. **Notes:**
   - The script checks if MongoDB is already installed and offers options to uninstall and reinstall.
   - It lists available MongoDB versions and prompts you to enter the desired version (enter 'latest' for the newest version).
   - The script is designed for Debian-based systems and may not support other operating systems.

## Disclaimer
This script is provided as-is and without any warranty. Use it at your own risk.

## Author
[Yatharth Chauhan](https://github.com/YatharthChauhan2362)

