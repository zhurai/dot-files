#!/bin/bash

GAME="Arknights"
WIDTH=1920
HEIGHT=1011
APKPKG="com.YoStarEN.Arknights"

# make sure any previous waydroid sessions are stopped
killall weston
waydroid session stop 
sleep 3 

# open weston wayland compositor
weston --width=${WIDTH} --height=${HEIGHT} &
sleep 2

# once the weston window in X11 has appeared, move weston to 0,0, and start a new waydroid session
WAYLAND_DISPLAY=wayland-1 waydroid session start &
xdotool search --class "weston" windowmove -- 0 0 &
xdotool search --class "weston" set_window --name "Waydroid - ${GAME}" &
sleep 10 # handle race condition

# once the session should have been started, show the ui
WAYLAND_DISPLAY=wayland-1 waydroid show-full-ui &
sleep 5

# Start custom service to turn off/restart waydroid
systemctl --user daemon-reload
systemctl --user start waydroid-check.service

# System seems to have started fully by now
sleep 10 # handle race condition

# Check ADB information, set title
DEVICE=$(waydroid status | grep IP | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | sed 's/$/:5555/g')
WINDOWNAME=$(xdotool search --class "weston" getwindowname)
xdotool search --class "weston" set_window --name "${WINDOWNAME} - ${DEVICE} - Initial" &

# Launch/Connect
adb connect ${DEVICE} 
adb -s ${DEVICE} shell settings put global http_proxy :0 
#waydroid app launch ${APKPKG} &
