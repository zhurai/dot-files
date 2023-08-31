#!/bin/bash

# it says waydroid but it's really if weston is running or not, since weston might not be running but waydroid is still running
# if so, it's ideal to turn off waydroid

if pgrep "weston" > /dev/null 2>&1
    then
        # weston is running
        echo "weston is still running"
	output=$(tail /var/lib/waydroid/waydroid.log -n1)
	if [ "$output" == "FROZEN" ] 
		then
			echo "waydroid seems to have crashed, restarting"
			WAYLAND_DISPLAY=wayland-1 waydroid show-full-ui &
	fi	
	
    else
        # weston is not running
        echo "weston is not running"
        echo "turning off waydroid session"
        waydroid session stop
        systemctl --user stop waydroid-check.service
        #systemctl --user stop waydroid-check.timer
fi

