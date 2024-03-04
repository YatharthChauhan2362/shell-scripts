# PHP Installation Script

## Overview
This Bash script automates the installation and configuration of PHP on a Debian-based system. It is designed to be run with root privileges (sudo) and provides options to uninstall and reinstall PHP.

## Usage 

1. **Make the script executable:**
    ```bash
    chmod +x php.sh
    ```

2. **Run the script:**
    ```bash
    sudo ./php.sh
    ```

3. **Follow the on-screen prompts:**
   - If PHP is already installed, the script will ask if you want to uninstall it.
   - If you choose to uninstall, it will remove PHP and prompt you to reinstall.
   - You can choose a specific version of PHP to install or opt for the latest version.

4. **Notes:**
   - The script checks for root privileges and prompts you to run it with sudo if needed.
   - It verifies if PHP is already installed and offers options to uninstall and reinstall.
   - The script fetches the PHP APT configuration, updates the package list, and allows you to choose the PHP version.

## Disclaimer
This script is provided as-is and without any warranty. Use it at your own risk.

## Author
[Yatharth Chauhan](https://github.com/YatharthChauhan2362)