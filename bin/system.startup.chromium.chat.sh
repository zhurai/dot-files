#!/bin/bash
chromium --user-data-dir=$HOME/.config/chromium-chat --ozone-platform-hint=auto --enable-features=UseOzonePlatform --enable-gpu --ozone-platform=wayland --enable-webrtc-pipewire-capturer
