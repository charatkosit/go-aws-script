#!/bin/bash

#สตาร์ท mysql
cd /home/ec2-user/docker-mysql-pma
docker-compose up -d
cd /home/ec2-user/

#สตาร์ท go-auth-prod
docker pull charat/go-auth-prod:latest
docker run -p 3100:3100 -d charat/go-auth-prod:latest

#wait 5 sec
sleep 5 &
wait

#get version form api to notify
latestVer=`curl --location http://172.51.67.165:3100/apiauth/v1/auth/backRev |cut -d '"' -f 4`
curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=UAT deploy latest Version: ${latestVer} OK" https://notify-api.line.me/api/notify


