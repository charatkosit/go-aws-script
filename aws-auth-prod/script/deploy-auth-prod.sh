#!/bin/bash
#stop container before
docker stop $(docker ps --filter 'ancestor=charat/go-back-prod:latest' --format "{{.ID}}")

#remove image <none> and  go-back
docker images
docker rmi $(docker images go-back-prod --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

#pull and run
docker pull charat/go-back-prod:latest
docker run -p 3000:3000 -d charat/go-back-prod:latest

#wait 5 sec
sleep 5 &
wait

#get version form api to notify
latestVer=`curl http://52.54.69.220:3000/api/v1/env |cut -d '"' -f 52`
curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=PROD deploy latest Version: ${latestVer} OK" https://notify-api.line.me/api/notify