#!/bin/bash

waydroid session stop 
sleep 3 
weston --width=1280 --height=720 &
sleep 2
xdotool search --class "weston" windowmove -- 0 0 &
WAYLAND_DISPLAY=wayland-1 waydroid session start &
sleep 2
WAYLAND_DISPLAY=wayland-1 waydroid show-full-ui &
sleep 2
ln -s /mnt/SSD1/Development/Personal/dot-files/systemd-user/waydroid-check.service /home/zhurai/.config/systemd/user/waydroid-check.service 
systemctl --user daemon-reload
systemctl --user start waydroid-check.service
sleep 10
waydroid app launch com.stove.epic7.google 


