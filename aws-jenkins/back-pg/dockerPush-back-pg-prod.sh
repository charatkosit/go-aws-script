#!/bin/bash
releasePBP=`docker images go-back-pg-prod --format {{.Tag}} | head -1`

docker image tag go-back-pg-prod:$releasePBP go-back-pg-prod:latest
docker image tag go-back-pg-prod:$releasePBP charat/go-back-pg-prod:$releasePBP 
docker image tag go-back-pg-prod:latest charat/go-back-pg-prod:latest
docker image push --all-tags charat/go-back-pg-prod

docker images
docker rmi $(docker images go-back-pg-prod --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images


curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=PROD push DockerHub ${releasePBP} OK" https://notify-api.line.me/api/notify