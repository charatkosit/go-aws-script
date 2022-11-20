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
docker run -p 3000:3000 -d charat/go-back-uat:latest
curl -X POST -H "Authorization: Bearer ${tokenLine}" -F "message=PROD new version http://goapiuat.ddns.net:3000/api/v1" https://notify-api.line.me/api/notify