#!/usr/bin/python

# initial variables
import subprocess
import re
from time import sleep
from random import randrange
game="Pokemon Go"
gamepkg0="com.cjin.pokegenie.standard"
gamepkg1="com.nianticlabs.pokemongo"
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

# open vysor
subprocess.Popen(["vysorapp","-s",device],close_fds=True)
sleep(10)

# open pokegenie
subprocess.Popen(["adb","-s",device,"shell","monkey","-p",gamepkg0,"1"])
subprocess.Popen(["xdotool","search","-name", titlefilter,"set_window","--name",starttitle]) 
sleep(10)

# pokegenie: click to start overlays
x1=231
x2=845
y1=2080
y2=2200
subprocess.Popen(["adb","-s",device,"shell","input","tap",str(randrange(x1,x2)),str(randrange(y1,y2))])
sleep(5)

# pokegenie: confirm overlay (which autostarts pokemon go)
x1=600
x2=1000
y1=1475
y2=1630
subprocess.Popen(["adb","-s",device,"shell","input","tap",str(randrange(x1,x2)),str(randrange(y1,y2))])

# other code if open game directly
#sleep(10)
#subprocess.Popen(["adb","-s",device,"shell","monkey","-p",gamepkg1,"1"])
