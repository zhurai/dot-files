#!/usr/bin/python
import subprocess
import re
import time

game="Arknights"
gamepkg="com.YoStarEN.Arknights"

subprocess.Popen(["/usr/bin/gmtool","admin","start","--coldboot",game])
time.sleep(25)

title=title=subprocess.run(["/usr/bin/xdotool","search", "--name",'Arknights.*Genymotion',"getwindowname"],capture_output=True).stdout.decode('utf-8').strip()

device_pattern=re.compile(r'(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\:\d{1,6})')
device=re.search(device_pattern,title).group()
print(device)

subprocess.Popen(["adb","-s",device,"shell","monkey","-p",gamepkg,"1"])
