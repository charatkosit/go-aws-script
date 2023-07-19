#!/bin/bash
#stop container before
docker stop $(docker ps --filter 'ancestor=charat/go-auth-uat:latest' --format "{{.ID}}")

#remove image <none> and  go-auth
docker images
docker rmi $(docker images go-auth-uat --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

#pull and run
docker pull charat/go-auth-uat:latest
docker run -p 3100:3000 -d charat/go-auth-uat:latest

#wait 5 sec
sleep 5 &
wait

#get version form api to notify
latestVer=`curl http://172.51.64.139:3100/api/v1/env |cut -d '"' -f 52`
curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=UAT deploy latest Version: ${latestVer} OK" https://notify-api.line.me/api/notify
