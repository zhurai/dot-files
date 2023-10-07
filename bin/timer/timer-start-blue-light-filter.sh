#!/bin/bash
session_type=$(loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}')

if [[ "$session_type" == "wayland" ]]; then
  WAYLAND_DISPLAY=wayland-1 gammastep -oO 1000 &
fi

# X11
#Environment=DISPLAY=:0.0
#ExecStart=redshift -PO 1000
