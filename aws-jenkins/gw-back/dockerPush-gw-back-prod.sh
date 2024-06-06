#!/bin/bash
releasePBP=`docker images gw-back-prod --format {{.Tag}} | head -1`

docker image tag gw-back-prod:$releasePBP gw-back-prod:latest
docker image tag gw-back-prod:$releasePBP charat/gw-back-prod:$releasePBP 
docker image tag gw-back-prod:latest charat/gw-back-prod:latest
docker image push --all-tags charat/gw-back-prod

docker images
docker rmi $(docker images gw-back-prod --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images


curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=PROD push DockerHub ${releasePBP} OK" https://notify-api.line.me/api/notify