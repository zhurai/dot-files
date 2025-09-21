#!/bin/bash

# check if there's a deskflow process
CHECK=$(ps uxa | grep deskflow | grep -v grep | awk '{ print $2 }')

if [[ "$CHECK" == "" ]] then
  /usr/bin/deskflow-server -f --name home-pc1 --enable-crypto --address :24803 -c /home/zhurai/.config/Deskflow/deskflow-server.conf --tls-cert /home/zhurai/.config/Deskflow/tls/deskflow.pem & 
else
  kill -9 $CHECK
fi

