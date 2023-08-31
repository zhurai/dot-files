#!/bin/bash

# this command not compatible with Epic Seven script $HOME even though it works otherwise in KDE
#desktop-file-install --dir=$HOME/.local/share/applications `pwd`../*.desktop

desktop="*.desktop"
workingdir=$(dirname "$0")
find $workingdir/$desktop -exec chmod +x {} \; -exec cp {} ~/.local/share/applications/ \; -exec echo {} \;
update-desktop-database ~/.local/share/applications

