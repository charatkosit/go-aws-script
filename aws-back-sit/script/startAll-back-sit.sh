#!/bin/bash

#สตาร์ท mysql
cd /home/ec2-user/docker-mysql-pma
docker-compose up -d
cd /home/ec2-user/

#สตาร์ท go-back-sit
docker pull charat/go-back-sit:latest
docker run -p 3100:3100 -d charat/go-back-sit:latest

#wait 5 sec
sleep 5 &
wait

#get version form api to notify
latestVer=`curl --location http://172.51.46.64:3000/api/v1/auth/backRev |cut -d '"' -f 4`
curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=UAT deploy latest Version: ${latestVer} OK" https://notify-api.line.me/api/notify


