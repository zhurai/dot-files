#!/bin/bash

if [ "$EUID" -eq 0 ]
  then echo "This script must not be ran as root"
  exit
fi

# todo add initial startup of waydroid
sudo waydroid-extras certified > /home/${USER}/waydroid-info
sudo chown ${USER}:${USER} /home/${USER}/waydroid-info

