#!/bin/bash

extension="*.sh"
workingdir=$(dirname "$0")
find $workingdir/$extension -exec chmod +x {} \; -exec ln -s {} ~/.bin/ \; -exec echo {} \;
