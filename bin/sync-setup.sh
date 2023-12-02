#!/bin/bash

workingdir=$(dirname $(realpath "$0"))
rm -rv ~/.bin

mkdir ~/.bin
find $workingdir -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.bin/ \; -exec echo {} \;

desktop="*.desktop"
workingdir_=$workingdir/../application-files
find $workingdir_/$desktop -exec chmod +x {} \; -exec cp {} ~/.local/share/applications/ \; -exec echo {} \;
update-desktop-database ~/.local/share/applications

workingdir_=$workingdir/arknights
mkdir ~/.bin/arknights
find $workingdir_ -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.bin/arknights \; -exec echo {} \;

workingdir_=$workingdir/games
mkdir ~/.bin/games
find $workingdir_ -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.bin/games \; -exec echo {} \;

workingdir_=$workingdir/girlsfrontline
mkdir ~/.bin/girlsfrontline
find $workingdir_ -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.bin/girlsfrontline \; -exec echo {} \;

workingdir_=$workingdir/waydroid
mkdir ~/.bin/waydroid
find $workingdir_ -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.bin/waydroid \; -exec echo {} \;

workingdir_=$workingdir/timer
mkdir ~/.bin/timer
find $workingdir_ -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.bin/timer \; -exec echo {} \;

# systemd files
rm -rv ~/.config/systemd/user/
mkdir ~/.config/systemd/user/

workingdir_=$(dirname $workingdir)/systemd-user
echo $workingdir_
find $workingdir_ -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.config/systemd/user \; -exec echo {} \;

# reload daemon
systemctl --user daemon-reload

# enable timers needed
systemctl --user enable --now end-blue-light-filter.timer
systemctl --user enable --now start-blue-light-filter.timer
