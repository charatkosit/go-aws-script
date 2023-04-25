#!/bin/bash
releasePBS=`docker images click-back-sit --format {{.Tag}} | head -1`

docker image tag click-back-sit:$releasePBS click-back-sit:latest
docker image tag click-back-sit:$releasePBS charat/click-back-sit:$releasePBS 
docker image tag click-back-sit:latest charat/click-back-sit:latest
docker image push --all-tags charat/click-back-sit

docker images
docker rmi $(docker images click-back-sit --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=Click-Back-SIT push DockerHub ${releasePBS} OK" https://notify-api.line.me/api/notify