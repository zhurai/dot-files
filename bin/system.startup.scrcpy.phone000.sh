#!/bin/bash

SERVER="Phone000"
SERIAL="47f3c1bf"
BITRATE="25M"
_SCRCPYARG-MODKEY="--shortcut-mod=lctrl+lalt"
_SCRCPYARG-BITRATE="--video-bit-rate=$BITRATE"
_SCRCPYARG-AWAKE="--stay-awake"
_SCRCPYARG-SCREENOFF="--turn-screen-off"
_SCRCPYARG-LEGACYPASTE="--legacy-paste"
_SCRCPYARG-POWEROFFONCLOSE="--power-off-on-close"

. ~/.bin/system.startup.scrcpy.sh

main

