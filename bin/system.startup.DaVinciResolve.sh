#!/bin/bash

unset SDL_VIDEODRIVER
unset QT_QPA_PLATFORM 
export LD_PRELOAD="/usr/lib64/libglib-2.0.so"

/opt/resolve/bin/resolve
