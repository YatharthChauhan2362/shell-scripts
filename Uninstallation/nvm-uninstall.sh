#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo "Please run this script (without sudo)."
    exit 1
fi

echo "Uninstalling NVM..."
(
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

    

    command rm -rf "$NVM_DIR"
)
unset NVM_DIR
echo "NVM has been uninstalled."

echo "Thank you for using this script - Yatharth Chauhan"
