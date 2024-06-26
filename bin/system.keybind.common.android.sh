#!/bin/bash

ANDROID_TEMPLATE="shell input "
ANDROID_VOLUMEUP="keyevent 24"
ANDROID_VOLUMEDOWN="keyevent 25"
ANDROID_BACK="keyevent 4"

if [[ "$KEY" == "Page_Up" ]] then
  adb -s $ADB $ANDROID_TEMPLATE $ANDROID_VOLUMEUP
fi

if [[ "$KEY" == "Page_Down" ]] then
  adb -s $ADB $ANDROID_TEMPLATE $ANDROID_VOLUMEDOWN
fi

if [[ "$KEY" == "2" ]] then
  adb -s $ADB $ANDROID_TEMPLATE $ANDROID_VOLUMEDOWN
fi