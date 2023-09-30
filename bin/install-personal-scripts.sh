#!/bin/bash

rm -rv ~/.bin/*
workingdir=$(dirname $(realpath "$0"))
find $workingdir -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.bin/ \; -exec echo {} \;
