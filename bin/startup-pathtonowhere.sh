#!/bin/bash

GAME="PathToNowhere"
WIDTH=1920
HEIGHT=1011
TEMPFILE=/tmp/z.waydroid.${GAME,,}
APKPKG="com.zy.wqmt.global"

# make sure any previous waydroid sessions are stopped
killall weston
waydroid session stop 
sleep 3 

# open weston wayland compositor
weston --width=${WIDTH} --height=${HEIGHT} &
sleep 2

# once the weston window in X11 has appeared, move weston to 0,0, and start a new waydroid session
xdotool search --class "weston" windowmove -- 0 0 &
xdotool search --class "weston" set_window --name "Waydroid - ${GAME}" &
WAYLAND_DISPLAY=wayland-1 waydroid session start &
sleep 2

# once the session should have been started, show the ui
WAYLAND_DISPLAY=wayland-1 waydroid show-full-ui &
sleep 2

# Start custom service to turn off/restart waydroid
systemctl --user daemon-reload
systemctl --user start waydroid-check.service

# System seems to have started fully by now
sleep 10 # if you don't have a delay there would be a race condition where it would try to launch the app while the OS is booting, which would just cause a crash
timeout 1 waydroid log > ${TEMPFILE}
DEVICE=$(cat ${TEMPFILE} | grep ADB | tail -n 1 | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | sed 's/$/:5555/g')
adb connect ${DEVICE} 
WINDOW=$(xdotool search --class "weston" getwindowname)
xdotool search --class "weston" set_window --name "${WINDOW} - ${DEVICE} - Initial" &
waydroid app launch ${APKPKG}