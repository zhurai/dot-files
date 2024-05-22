#!/bin/bash
vivaldi --user-data-dir=$HOME/.config/chromium-gbf --window-name="Granblue Fantasy" --enable-gpu --disable-backgrounding-occluded-windows --autoplay-policy=no-user-gesture-required --disable-background-timer-throttling --disable-renderer-backgrounding --ozone-platform=wayland --ozone-platform-hint=auto --enable-features=UseOzonePlatform --hide-crash-restore-bubble --enable-logging=stderr --v=1 > /home/zhurai/gbf-log.txt 2>&1

