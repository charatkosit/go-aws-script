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
curl -X POST -H "Authorization: Bearer ${tokenLine}" -F "message=PROD new version http://goapi.ddns.net:3000/api/v1" https://notify-api.line.me/api/notify