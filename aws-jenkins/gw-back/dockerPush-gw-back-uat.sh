#!/bin/bash
releasePBU=`docker images gw-back-uat --format {{.Tag}} | head -1`

docker image tag gw-back-uat:$releasePBU gw-back-uat:latest
docker image tag gw-back-uat:$releasePBU charat/gw-back-uat:$releasePBU 
docker image tag gw-back-uat:latest charat/gw-back-uat:latest
docker image push --all-tags charat/gw-back-uat

docker images
docker rmi $(docker images gw-back-uat --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=UAT push DockerHub ${releasePBU} OK" https://notify-api.line.me/api/notify