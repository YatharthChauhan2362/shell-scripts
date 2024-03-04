#!/bin/bash

  sudo apt purge php${version}*
  sudo apt autoremove -y

  sudo apt purge php* -y



  sudo apt purge php*-common -y

  sudo add-apt-repository --remove ppa:ondrej/php -y


echo "PHP uninstallation complete!"
