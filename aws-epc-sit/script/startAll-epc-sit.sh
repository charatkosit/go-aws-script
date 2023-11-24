#!/bin/bash

#สตาร์ท mysql
cd /home/ec2-user/docker-mysql-pma
docker-compose up -d
cd /home/ec2-user/

#สตาร์ท go-epc-sit
docker pull charat/go-epc-sit:latest
docker run -p 3300:3300 -d charat/go-epc-sit:latest

#wait 5 sec
sleep 5 &
wait

#get version form api to notify
latestVer=`curl --location http://13.214.25.107:3300/apiepc/v1/version |cut -d '"' -f 4`
curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=SIT deploy latest Version: ${latestVer} OK" https://notify-api.line.me/api/notify


