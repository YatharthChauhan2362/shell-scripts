# MySQL Installation Script

## Overview
This Bash script automates the installation and configuration of MySQL on a Debian-based system. It is designed to be run with root privileges (sudo) and provides options to uninstall and reinstall MySQL.

## Usage 

1. **Make the script executable:**
    ```bash
    chmod +x mysql.sh
    ```

2. **Run the script:**
    ```bash
    sudo ./mysql.sh
    ```

3. **Follow the on-screen prompts:**
   - If MySQL is already installed, the script will ask if you want to uninstall it.
   - If you choose to uninstall, it will remove MySQL and prompt you to reinstall.
   - You can choose a specific version of MySQL to install or opt for the latest version.

4. **Notes:**
   - The script checks for root privileges and prompts you to run it with sudo if needed.
   - It verifies if MySQL is already installed and offers options to uninstall and reinstall.
   - The script fetches the MySQL APT configuration, updates the package list, and allows you to choose the MySQL version.

## Disclaimer
This script is provided as-is and without any warranty. Use it at your own risk.

## Author
[Yatharth Chauhan](https://github.com/YatharthChauhan2362)

