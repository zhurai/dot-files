#!/bin/bash

GAME="Shin Megami Tensei DX2"
TEMPFILE=/tmp/z.genymotion.smtdx2
rm ${TEMPFILE}
APKPKG="com.sega.d2megaten.en"
UUID="bf876316-5360-4e27-8448-f3623a40027f"

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
