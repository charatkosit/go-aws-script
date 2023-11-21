#!/bin/bash
releasePBP=`docker images go-epc-prod --format {{.Tag}} | head -1`

docker image tag go-epc-prod:$releasePBP go-epc-prod:latest
docker image tag go-epc-prod:$releasePBP charat/go-epc-prod:$releasePBP 
docker image tag go-epc-prod:latest charat/go-epc-prod:latest
docker image push --all-tags charat/go-epc-prod

docker images
docker rmi $(docker images go-epc-prod --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images


curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=PROD push DockerHub ${releasePBP} OK" https://notify-api.line.me/api/notify