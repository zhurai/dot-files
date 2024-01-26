#!/bin/bash

workingdir=$(dirname $(realpath "$0"))
workingdirparent=$(dirname $workingdir)

rm -rv ~/.bin
mkdir ~/.bin
find $workingdir -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.bin/ \; -exec echo {} \;

desktop="*.desktop"
workingdir_=$workingdirparent/application-files
find $workingdir_/$desktop -exec chmod +x {} \; -exec cp {} ~/.local/share/applications/ \; -exec echo {} \;
update-desktop-database ~/.local/share/applications

# systemd files
rm -rv ~/.config/systemd/user/
mkdir ~/.config/systemd/user/

workingdir_=$workingdirparent/systemd-user
echo $workingdir_
find $workingdir_ -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.config/systemd/user \; -exec echo {} \;
systemctl --user daemon-reload
systemctl --user enable --now end-blue-light-filter.timer
systemctl --user enable --now start-blue-light-filter.timer

