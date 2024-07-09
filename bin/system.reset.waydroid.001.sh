#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "This script must be ran as root"
  exit
fi

echo "Print the username: "
read $the_user
rm -rf /var/lib/waydroid /home/.waydroid
rm -rf /home/${the_user}/waydroid /home/${the_user}/.share/waydroid /home/${the_user}/.local/share/applications/*aydroid* /home/${the_user}/.local/share/waydroid
systemctl stop waydroid-container.service
waydroid init -fs GAPPS 
systemctl start waydroid-container.service
cd /opt/waydroid-script/
waydroid-extras -a 11 install libndk
waydroid-extras -a 11 install libndk
waydroid-extras install widevine
