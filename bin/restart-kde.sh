#!/bin/bash
killall plasmashell 
sleep 1
plasmashell > /dev/null 2>&1 &
