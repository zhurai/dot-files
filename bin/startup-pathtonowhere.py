#!/usr/bin/python

# initial variables
import subprocess
import re
from time import sleep
game="Path to Nowhere"
gamepkg="com.zy.wqmt.global"
search="OnePlus9" # this would have to change if it is a different device/model for others!
titlefilter="^zhurai-phone$" # others may want to change this
starttitle="zhurai-phone - "+game # others may want to change this

# make sure the device is connected to adb and everything is enabled first
# also make sure you "Connect Network or Shared Device" to the device on Vysor first
# also make sure the device is unlocked/passed the lock screen otherwise the screen may blank out in some devices(?)
adbdevices=subprocess.run(["adb","devices","-l"],capture_output=True)
devicegrep=subprocess.run(["grep",search],input=adbdevices.stdout,capture_output=True)
deviceawk=subprocess.run(["awk","{ print $1 }"],input=devicegrep.stdout,capture_output=True)
device=deviceawk.stdout.decode('utf-8').strip()

# killall vysor, otherwise issues occur with the script if a vysor window is already active
subprocess.Popen(["killall","vysorapp"])
sleep(5)

# open vysor
subprocess.Popen(["vysorapp","-s",device],close_fds=True)
sleep(5)

# open the game
subprocess.Popen(["adb","-s",device,"shell","monkey","-p",gamepkg,"1"])
subprocess.Popen(["xdotool","search","-name", titlefilter,"set_window","--name",starttitle]) 
