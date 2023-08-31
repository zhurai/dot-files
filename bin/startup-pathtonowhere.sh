#!/bin/bash

/usr/bin/vysorapp -s `adb devices -l | grep usb | awk '{ print $1 }'`
