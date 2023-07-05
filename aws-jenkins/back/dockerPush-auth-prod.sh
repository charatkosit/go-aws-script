#!/bin/bash
releasePBP=`docker images go-back-auth-prod --format {{.Tag}} | head -1`

docker image tag go-back-auth-prod:$releasePBP go-back-auth-prod:latest
docker image tag go-back-auth-prod:$releasePBP charat/go-back-auth-prod:$releasePBP 
docker image tag go-back-auth-prod:latest charat/go-back-auth-prod:latest
docker image push --all-tags charat/go-back-auth-prod

docker images
docker rmi $(docker images go-back-auth-prod --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images


curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=PROD push DockerHub ${releasePBP} OK" https://notify-api.line.me/api/notify