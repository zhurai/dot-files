#!/bin/bash

waydroid session stop 
sleep 3 
weston --width=1280 --height=720 &
sleep 3 
WAYLAND_DISPLAY=wayland-1 waydroid session start &
sleep 1
WAYLAND_DISPLAY=wayland-1 waydroid show-full-ui &
