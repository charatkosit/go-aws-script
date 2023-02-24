#!/bin/bash

while true
do
  ping -c 1 192.168.20.17 > /dev/null
  
  if [ $? -ne 0 ]
  then
    message="Ping to 192.168.20.17 failed at $(date +'%Y-%m-%d %H:%M:%S')"
    curl -X POST -H "Authorization: Bearer ${tokenLineAF}" -F "message=$message" https://notify-api.line.me/api/notify
  fi
  
  sleep 60
done