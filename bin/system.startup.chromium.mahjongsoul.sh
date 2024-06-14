#!/bin/bash

chromium \
  --user-data-dir=$HOME/.config/chromium-majsoul \
  --window-name="MahjongSoul - Chromium" \
  --enable-gpu \

  --hide-crash-restore-bubble \

  --ozone-platform-hint=auto \
  --enable-features=UseOzonePlatform \
  --ozone-platform=wayland \

  "https://mahjongsoul.game.yo-star.com/"
