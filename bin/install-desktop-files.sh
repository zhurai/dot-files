#!/bin/bash

# this command not compatible with Epic Seven script $HOME even though it works otherwise in KDE
#desktop-file-install --dir=$HOME/.local/share/applications `pwd`../application-files/*.desktop

desktop="*.desktop"
workingdir=$(dirname "$0")/../application-files
find $workingdir/$desktop -exec chmod +x {} \; -exec cp {} ~/.local/share/applications/ \; -exec echo {} \;
update-desktop-database ~/.local/share/applications