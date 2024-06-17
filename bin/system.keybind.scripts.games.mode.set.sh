#!/bin/bash

. ~/.bin/system.keybind.common.games.mode.sh

GAME_MODE_ADJUST
notify-send "$GAME" "$PROFILE"
