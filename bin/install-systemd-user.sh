#!/bin/bash

# timer scripts
mkdir ~/.bin/timer/
rm -rv ~/.bin/timer/*

workingdir=$(dirname $(realpath "$0"))/timer
find $workingdir -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.bin/timer \; -exec echo {} \;

# systemd files
mkdir ~/.config/systemd/user/
rm -rv ~/.config/systemd/user/*

workingdir2=$(dirname $(dirname $(realpath "$0")))/systemd-user
echo $workingdir2
find $workingdir2 -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.config/systemd/user \; -exec echo {} \;

# reload daemon
systemctl --user daemon-reload 

# enable timers needed
systemctl --user enable --now end-blue-light-filter.timer
systemctl --user enable --now start-blue-light-filter.timer
