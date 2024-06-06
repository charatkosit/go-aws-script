#!/bin/bash
#stop container before
docker stop $(docker ps --filter 'ancestor=charat/gw-back-prod:latest' --format "{{.ID}}")

#ลบ container ที่ไม่ทำงานแล้ว
docker rm $(docker ps -aqf "status=exited")

#remove image <none> and  gw-back
docker images
docker rmi $(docker images gw-back-prod --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

#pull and run
docker pull charat/gw-back-prod:latest
docker run -p 3000:3000 -d charat/gw-back-prod:latest

#wait 5 sec
sleep 5 &
wait

#get version form api to notify
latestVer=`curl http://172.51.46.64:3000/api/v1/auth/backRev |cut -d '"' -f 52`
curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=PROD deploy latest Version: ${latestVer} OK" https://notify-api.line.me/api/notify

#start containter when system restart
docker update --restart=always $(docker ps --format "{{.ID}}")
