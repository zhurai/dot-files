#!/bin/bash

vivaldi \
  --user-data-dir=$HOME/.config/chromium-gbf
  --window-name="Granblue Fantasy"
  --enable-gpu

  --disable-backgrounding-occluded-windows
  --autoplay-policy=no-user-gesture-required
  --disable-background-timer-throttling
  --disable-renderer-backgrounding
  --hide-crash-restore-bubble

  --ozone-platform=wayland
  --ozone-platform-hint=auto
  --enable-features=UseOzonePlatform
