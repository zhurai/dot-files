#!/bin/bash

GAME="Path to Nowhere"
TEMPFILE=/tmp/z.genymotion.pathtonowhere
rm ${TEMPFILE}
APKPKG="com.zy.wqmt.global"
UUID="8cac8413-908c-45ac-a1f6-00f26e57e382"

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
