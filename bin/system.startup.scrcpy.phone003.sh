#!/bin/bash

SERVER="Phone003"
SERIAL="44241JEKB06543"
BITRATE="25M"
_SCRCPYARG_BITRATE="--video-bit-rate=$BITRATE"
_SCRCPYARG_AWAKE="--stay-awake"
_SCRCPYARG_SCREENOFF="--turn-screen-off"
_SCRCPYARG_LEGACYPASTE="--legacy-paste"
#_SCRCPYARG_POWEROFFONCLOSE="--power-off-on-close"

. ~/.bin/system.startup.scrcpy.sh

main

