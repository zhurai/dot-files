#!/usr/bin/python

# initial variables
import subprocess
import re
import time
game="Neural Cloud"
gamepkg="com.sunborn.neuralcloud.en"

# open the emulator instance
subprocess.Popen(["/usr/bin/gmtool","admin","start","--coldboot",game])

# wait for it to boot fully
time.sleep(25)

# get the title and get the device id from it
title=title=subprocess.run(["/usr/bin/xdotool","search", "--name",'Neural Cloud.*Genymotion',"getwindowname"],capture_output=True).stdout.decode('utf-8').strip()
device_pattern=re.compile(r'(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\:\d{1,6})')
device=re.search(device_pattern,title).group()

# open the game
subprocess.Popen(["adb","-s",device,"shell","monkey","-p",gamepkg,"1"])
