#!/bin/bash

# make sure any previous sessions are stopped
waydroid session stop 
# rm ~/.config/systemd/user/waydroid-check.service
sleep 3 

# open weston wayland compositor
weston --width=1280 --height=720 &
sleep 2

# once the weston window in X11 has appeared, move weston to 0,0, and start a new waydroid session
xdotool search --class "weston" windowmove -- 0 0 &
WAYLAND_DISPLAY=wayland-1 waydroid session start &
sleep 2

# once the session should have been started, show the ui
WAYLAND_DISPLAY=wayland-1 waydroid show-full-ui &
sleep 2

# Start custom service to turn off/restart waydroid
#ln -s /mnt/SSD1/Development/Personal/dot-files/systemd-user/waydroid-check.service /home/zhurai/.config/systemd/user/waydroid-check.service 
systemctl --user daemon-reload
systemctl --user start waydroid-check.service

# Start the game once one can be relatively sure Waydroid has been booted
sleep 10 # if you don't have a delay there would be a race condition where it would try to launch the app while the OS is booting, which would just cause a crash
waydroid app launch com.stove.epic7.google 


