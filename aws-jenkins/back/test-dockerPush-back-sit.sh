#!/bin/bash
releasePBS=`docker images test-back-sit --format {{.Tag}} | head -1`

docker image tag test-back-sit:$releasePBS test-back-sit:latest
docker image tag test-back-sit:$releasePBS charat/test-back-sit:$releasePBS 
docker image tag test-back-sit:latest charat/test-back-sit:latest
docker image push --all-tags charat/test-back-sit

docker images
docker rmi $(docker images test-back-sit --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=SIT push DockerHub ${releasePBS} OK" https://notify-api.line.me/api/notify