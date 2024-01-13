#!/bin/bash

killall -s 9 gammastep
sleep 1
WAYLAND_DISPLAY=wayland-1 gammastep -PO 6500
