# Nginx Installation Script

## Overview
This Bash script automates the installation and configuration of Nginx on a Ubuntu system. It provides options to uninstall and reinstall Nginx and allows you to choose a specific version.

## Usage

1. **Make the script executable:**
    ```bash
    chmod +x nginx.sh
    ```

2. **Run the script with sudo:**
    ```bash
    sudo ./nginx.sh
    ```

3. **Follow the on-screen prompts:**
   - If Nginx is already installed, the script will ask if you want to uninstall it.
   - If you choose to uninstall, it will stop Nginx, remove it, and prompt you to reinstall.
   - You can choose a specific version of Nginx to install.

4. **Notes:**
   - The script checks if Nginx is already installed and offers options to uninstall and reinstall.
   - It provides a list of available Nginx versions and prompts you to enter the desired version during installation.
   - The script supports Ubuntu systems.

## Disclaimer
This script is provided as-is and without any warranty. Use it at your own risk.

## Author
[Yatharth Chauhan](https://github.com/YatharthChauhan2362)
