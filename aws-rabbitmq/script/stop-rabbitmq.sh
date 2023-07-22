#!/bin/bash

#สตาร์ท mysql
cd /home/ec2-user/docker-rabbitmq
docker-compose down
cd /home/ec2-user/

# #สตาร์ท go-auth-uat
# docker pull charat/go-auth-uat:latest
# docker run -p 3100:3100 -d charat/go-auth-uat:latest

# #wait 5 sec
# sleep 5 &
# wait

# #get version form api to notify
# latestVer=`curl --location http://172.51.64.139:3100/apiauth/v1/auth/backRev |cut -d '"' -f 4`
# curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=UAT deploy latest Version: ${latestVer} OK" https://notify-api.line.me/api/notify


