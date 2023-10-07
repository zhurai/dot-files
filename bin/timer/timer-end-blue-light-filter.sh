#!/bin/bash
session_type=$(loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}')

if [[ "$session_type" == "wayland" ]]; then
  killall gammastep &
fi

# X11
#Environment=DISPLAY=:0.0
#ExecStart=redshift -PO 6500
