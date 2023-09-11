#!/bin/bash

rm ~/.bin/*
workingdir=$(dirname $(realpath "$0"))
find $workingdir -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.bin/ \; -exec echo {} \;