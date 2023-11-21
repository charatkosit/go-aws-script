#!/bin/bash
#stop container before
docker stop $(docker ps --filter 'ancestor=charat/go-auth-uat:latest' --format "{{.ID}}")

#ลบ container ที่ไม่ทำงานแล้ว
docker rm $(docker ps -aqf "status=exited")

#remove image <none> and  go-auth
docker images
docker rmi $(docker images go-auth-uat --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

#pull and run
docker pull charat/go-auth-uat:latest
docker run -p 3100:3100 -d charat/go-auth-uat:latest

#wait 5 sec
sleep 5 &
wait

#get version form api to notify
latestVer=` curl --location http://172.51.64.139:3100/apiauth/v1/auth/backRev |cut -d '"' -f 4`
curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=UAT deploy latest Version: ${latestVer} OK" https://notify-api.line.me/api/notify

#start containter when system restart
docker update --restart=always $(docker ps --format "{{.ID}}")