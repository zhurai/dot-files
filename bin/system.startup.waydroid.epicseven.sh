#!/bin/bash

GAME="EpicSeven"
TEMPFILE=/tmp/z.waydroid
rm /tmp/z.waydroid.*
APKPKG="com.stove.epic7.google"

# make sure any previous waydroid sessions are stopped
waydroid session stop 
sleep 3 

# start a new waydroid session
WAYLAND_DISPLAY=wayland-1 waydroid session start &
sleep 2

# once the session should have been started, show the ui
WAYLAND_DISPLAY=wayland-1 waydroid show-full-ui &
sleep 10

# System seems to have started fully by now
timeout 1 waydroid log > ${TEMPFILE}
DEVICE=$(cat ${TEMPFILE} | grep ADB | tail -n 1 | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | sed 's/$/:5555/g')
echo "${DEVICE}" > ${TEMPFILE}
echo "${GAME}" >> ${TEMPFILE}
adb connect ${DEVICE} 
sleep 45
waydroid app launch ${APKPKG}
