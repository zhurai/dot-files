#!/bin/bash

# check if there's an input-leaps process

#CHECK=$(ps uxa | grep input-leaps | grep -v grep | awk '{ print $2 }')
CHECK=$(ps uxa | grep deskflow | grep -v grep | awk '{ print $2 }')

#-l /tmp/deskflow.log -d DEBUG

if [[ "$CHECK" == "" ]] then
  /usr/bin/deskflow-server -f --name home-pc1 --enable-crypto --address :24803 -c /home/zhurai/.config/Deskflow/deskflow-server.conf --tls-cert /home/zhurai/.config/Deskflow/tls/deskflow.pem & 
  #/usr/bin/input-leaps -f --no-tray --debug INFO --name home-pc01 --disable-client-cert-checking -c /home/zhurai/.config/InputLeap/Input-Leap.conf --address :24802  

#  CHECK2=$(kdotool search "Input Capture Requested")
#  while [[ $CHECK2 == "" ]]
#  do
#    sleep 0.1
#    CHECK2=$(kdotool search "Input Capture Requested")
#  done

#  YDOTOOL_SOCKET="$HOME/.ydotool_socket" ydotool mousemove -x -9999999 -y -9999999
#  YDOTOOL_SOCKET="$HOME/.ydotool_socket" ydotool mousemove -x -9999999 -y -9999999
#  YDOTOOL_SOCKET="$HOME/.ydotool_socket" ydotool mousemove -x -9999999 -y -9999999
#  YDOTOOL_SOCKET="$HOME/.ydotool_socket" ydotool mousemove -x -9999999 -y -9999999
#  YDOTOOL_SOCKET="$HOME/.ydotool_socket" ydotool mousemove -x -9999999 -y -9999999
#  sleep 0.001
#  YDOTOOL_SOCKET="$HOME/.ydotool_socket" ydotool mousemove -x 250 -y 120
#  sleep 0.001
#  YDOTOOL_SOCKET="$HOME/.ydotool_socket" ydotool click 0x40 0x80

else
  kill -9 $CHECK
fi


