#!/bin/bash
#stop container before
docker stop $(docker ps --filter 'ancestor=charat/click-back-sit:latest' --format "{{.ID}}")

#remove image <none> and  click-back
docker images
docker rmi $(docker images click-back-sit --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

#pull and run
docker pull charat/click-back-sit:latest
docker run -p 3000:3000 -d charat/click-back-sit:latest

#wait 5 sec
sleep 5 &
wait

#get version form api to notify
latestVer=`curl http://172.31.24.223:3000/api/v1/env |cut -d '"' -f 52`
curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=SIT deploy latest Version: ${latestVer} OK" https://notify-api.line.me/api/notify