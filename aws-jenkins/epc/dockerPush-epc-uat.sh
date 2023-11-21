#!/bin/bash
releasePBU=`docker images go-epc-uat --format {{.Tag}} | head -1`

docker image tag go-epc-uat:$releasePBU go-epc-uat:latest
docker image tag go-epc-uat:$releasePBU charat/go-epc-uat:$releasePBU 
docker image tag go-epc-uat:latest charat/go-epc-uat:latest
docker image push --all-tags charat/go-epc-uat

docker images
docker rmi $(docker images go-epc-uat --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=UAT push DockerHub ${releasePBU} OK" https://notify-api.line.me/api/notify