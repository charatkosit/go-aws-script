#!/bin/bash
releasePBS=`docker images gw-back-pg-sit --format {{.Tag}} | head -1`

docker image tag gw-back-pg-sit:$releasePBS gw-back-pg-sit:latest
docker image tag gw-back-pg-sit:$releasePBS charat/gw-back-pg-sit:$releasePBS 
docker image tag gw-back-pg-sit:latest charat/gw-back-pg-sit:latest
docker image push --all-tags charat/gw-back-pg-sit

docker images
docker rmi $(docker images gw-back-pg-sit --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=SIT push DockerHub ${releasePBS} OK" https://notify-api.line.me/api/notify