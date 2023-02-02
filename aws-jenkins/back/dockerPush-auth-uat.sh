#!/bin/bash
releasePBU=`docker images go-auth-uat --format {{.Tag}} | head -1`

docker image tag go-auth-uat:$releasePBU go-auth-uat:latest
docker image tag go-auth-uat:$releasePBU charat/go-auth-uat:$releasePBU 
docker image tag go-auth-uat:latest charat/go-auth-uat:latest
docker image push --all-tags charat/go-auth-uat

docker images
docker rmi $(docker images go-auth-uat --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=UAT push DockerHub ${releasePBU} OK" https://notify-api.line.me/api/notify