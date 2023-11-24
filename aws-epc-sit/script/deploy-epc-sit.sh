#!/bin/bash
#stop container before
docker stop $(docker ps --filter 'ancestor=charat/go-epc-sit:latest' --format "{{.ID}}")

#ลบ container ที่ไม่ทำงานแล้ว
docker rm $(docker ps -aqf "status=exited")

#remove image <none> and  go-epc
docker images
docker rmi $(docker images go-epc-sit --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

#pull and run
docker pull charat/go-epc-sit:latest
docker run -p 3300:3300 -d charat/go-epc-sit:latest

#wait 5 sec
sleep 5 &
wait

#get version form api to notify
latestVer=` curl --location http://13.214.25.107:3300/epc/v1/version |cut -d '"' -f 4`
curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=SIT deploy latest Version: ${latestVer} OK" https://notify-api.line.me/api/notify

#start containter when system restart
docker update --restart=always $(docker ps --format "{{.ID}}")