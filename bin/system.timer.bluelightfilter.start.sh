#!/bin/bash
#session_type=$(loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}')
#echo $session_type

#if [[ "$session_type" == "wayland" ]]; then
#  
killall -s 9 gammastep
#  
WAYLAND_DISPLAY=wayland-1 gammastep -PO 1000 
#fi

# X11
#Environment=DISPLAY=:0.0
#ExecStart=redshift -PO 1000
