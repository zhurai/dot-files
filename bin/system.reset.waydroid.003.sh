#!/bin/bash

if [ "$EUID" -eq 0 ]
  then echo "This script must not be ran as root"
  exit
fi

sudo systemctl start waydroid-container.service
sleep 5
waydroid session start &
sleep 5
echo 'ANDROID_RUNTIME_ROOT=/apex/com.android.runtime ANDROID_DATA=/data ANDROID_TZDATA_ROOT=/apex/com.android.tzdata ANDROID_I18N_ROOT=/apex/com.android.i18n sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "select * from main where name = \"android_id\";"' | sudo waydroid shell
firefox "https://www.google.com/android/uncertified"
