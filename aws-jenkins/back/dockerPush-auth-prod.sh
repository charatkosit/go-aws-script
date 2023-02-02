#!/bin/bash
releasePBP=`docker images go-auth-prod --format {{.Tag}} | head -1`

docker image tag go-auth-prod:$releasePBP go-auth-prod:latest
docker image tag go-auth-prod:$releasePBP charat/go-auth-prod:$releasePBP 
docker image tag go-auth-prod:latest charat/go-auth-prod:latest
docker image push --all-tags charat/go-auth-prod

docker images
docker rmi $(docker images go-auth-prod --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images


curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=PROD push DockerHub ${releasePBP} OK" https://notify-api.line.me/api/notify