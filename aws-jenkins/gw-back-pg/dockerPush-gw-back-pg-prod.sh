#!/bin/bash
releasePBP=`docker images gw-back-pg-prod --format {{.Tag}} | head -1`

docker image tag gw-back-pg-prod:$releasePBP gw-back-pg-prod:latest
docker image tag gw-back-pg-prod:$releasePBP charat/gw-back-pg-prod:$releasePBP 
docker image tag gw-back-pg-prod:latest charat/gw-back-pg-prod:latest
docker image push --all-tags charat/gw-back-pg-prod

docker images
docker rmi $(docker images gw-back-pg-prod --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images


curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=PROD push DockerHub ${releasePBP} OK" https://notify-api.line.me/api/notify