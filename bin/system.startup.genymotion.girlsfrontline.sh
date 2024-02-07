#!/bin/bash

GAME="Girls Frontline"
TEMPFILE=/tmp/z.genymotion.girlsfrontline
rm ${TEMPFILE}
APKPKG="com.sunborn.girlsfrontline.en"
UUID="84027d75-32d8-4315-b233-7a4b37b446be"

# make sure any previous sessions are stopped
pkill -f -9 ${UUID}
sleep 5

# start a new session
gmtool admin start "${UUID}"
sleep 30

# System seems to have started fully by now
TITLE=$(hyprctl clients -j | jq .[].title | grep "${GAME}")
SERIAL=$(echo ${TITLE} | cut -f 2 -d '-' | awk '{$1=$1};1')
echo "${SERIAL}" > ${TEMPFILE}
echo "${GAME}" >> ${TEMPFILE}
sleep 1
adb -s ${SERIAL} shell monkey -p ${APKPKG} -c android.intent.category.LAUNCHER 1

# todo: if error in starting up: kill the emulator and reboot
