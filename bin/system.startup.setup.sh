#!/bin/bash

workingdir=$(dirname $(realpath "$0"))
workingdirparent=$(dirname $workingdir)

rm -rv ~/.bin
mkdir ~/.bin
find $workingdir -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.bin/ \; -exec echo {} \;

desktop="*.desktop"
workingdir_=$workingdirparent/application-files
rm -rf ~/.local/share/applications/personal/
mkdir ~/.local/share/applications/personal -p
find $workingdir_/$desktop -exec chmod +x {} \; -exec cp {} ~/.local/share/applications/personal/ \; -exec echo {} \;
update-desktop-database ~/.local/share/applications
rm ~/.cache/rofi* -v

# systemd files
rm -rv ~/.config/systemd/user/
mkdir ~/.config/systemd/user/

workingdir_=$workingdirparent/systemd-user
echo $workingdir_
find $workingdir_ -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.config/systemd/user \; -exec echo {} \;
systemctl --user daemon-reload
systemctl --user enable --now end-blue-light-filter.timer
systemctl --user enable --now start-blue-light-filter.timer

pactl unload-module module-loopback
pactl unload-module module-native-protocol-tcp
pactl unload-module module-zeroconf-publish
AUDIODEVICENAME=$(pactl list | grep "Starship/Matisse" -B3 -A50 | grep Name | cut -f 2 -d ' ' | grep input | grep pci)
pactl load-module module-loopback latency_msec=100 source=$AUDIODEVICENAME
pactl load-module module-native-protocol-tcp listen=192.168.7.7
pactl load-module module-zeroconf-publish
