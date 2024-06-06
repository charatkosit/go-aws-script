#!/bin/bash
releasePBS=`docker images gw-back-sit --format {{.Tag}} | head -1`

docker image tag gw-back-sit:$releasePBS gw-back-sit:latest
docker image tag gw-back-sit:$releasePBS charat/gw-back-sit:$releasePBS 
docker image tag gw-back-sit:latest charat/gw-back-sit:latest
docker image push --all-tags charat/gw-back-sit

docker images
docker rmi $(docker images gw-back-sit --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=SIT push DockerHub ${releasePBS} OK" https://notify-api.line.me/api/notify