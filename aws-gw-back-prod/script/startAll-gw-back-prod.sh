#!/bin/bash

#สตาร์ท mysql
cd /home/ec2-user/docker-mysql-pma
docker-compose up -d
cd /home/ec2-user/

#สตาร์ท gw-back-prod
docker pull charat/gw-back-prod:latest
docker run -p 3000:3000 -d charat/gw-back-prod:latest

#wait 5 sec
sleep 5 &
wait

#get version form api to notify
latestVer=`curl --location http://172.51.46.64:3000/api/v1/auth/backRev |cut -d '"' -f 4`
curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=PROD deploy latest Version: ${latestVer} OK" https://notify-api.line.me/api/notify


