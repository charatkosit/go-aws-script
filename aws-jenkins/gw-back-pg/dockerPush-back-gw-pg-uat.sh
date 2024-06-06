#!/bin/bash
releasePBU=`docker images gw-back-pg-uat --format {{.Tag}} | head -1`

docker image tag gw-back-pg-uat:$releasePBU gw-back-pg-uat:latest
docker image tag gw-back-pg-uat:$releasePBU charat/gw-back-pg-uat:$releasePBU 
docker image tag gw-back-pg-uat:latest charat/gw-back-pg-uat:latest
docker image push --all-tags charat/gw-back-pg-uat

docker images
docker rmi $(docker images gw-back-pg-uat --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=UAT push DockerHub ${releasePBU} OK" https://notify-api.line.me/api/notify