#!/bin/bash
#stop container before
docker stop $(docker ps --filter 'ancestor=charat/go-back-uat:latest' --format "{{.ID}}")

#remove image <none> and  go-back
docker images
docker rmi $(docker images go-back-uat --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

#pull and run
docker pull charat/go-back-uat:latest
docker run -p 3200:3200 -d charat/go-back-uat:latest

#wait 5 sec
sleep 5 &
wait

#get version form api to notify
latestVer=`curl http://54.224.78.26:3200/api/v1/env |cut -d '"' -f 52`
curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=UAT deploy latest Version: ${latestVer} OK" https://notify-api.line.me/api/notify
