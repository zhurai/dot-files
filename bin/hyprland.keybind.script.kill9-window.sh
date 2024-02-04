#!/bin/bash
curr_pid=$(hyprctl activewindow -j | jq ".pid")
kill -9 ${curr_pid}

