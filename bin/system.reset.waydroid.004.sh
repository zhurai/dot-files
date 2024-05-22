#!/bin/bash

if [ "$EUID" -eq 0 ]
  then echo "This script must not be ran as root"
  exit
fi

# how to automate login
waydroid show-full-ui &
sleep 5
waydroid app launch com.android.vending
