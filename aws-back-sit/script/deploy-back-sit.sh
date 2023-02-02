#!/bin/bash
#stop container before
docker stop $(docker ps --filter 'ancestor=charat/go-back-sit:latest' --format "{{.ID}}")

#remove image <none> and  go-back
docker images
docker rmi $(docker images go-back-sit --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

#pull and run
docker pull charat/go-back-sit:latest
docker run -p 3200:3200 -d charat/go-back-sit:latest

#wait 5 sec
sleep 5 &
wait

#get version form api to notify
latestVer=`curl http://44.212.248.132:3200/api/v1/env |cut -d '"' -f 52`
curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=SIT deploy latest Version: ${latestVer} OK" https://notify-api.line.me/api/notify