#!/bin/bash
releasePBS=`docker images go-back-pg-sit --format {{.Tag}} | head -1`

docker image tag go-back-pg-sit:$releasePBS go-back-pg-sit:latest
docker image tag go-back-pg-sit:$releasePBS charat/go-back-pg-sit:$releasePBS 
docker image tag go-back-pg-sit:latest charat/go-back-pg-sit:latest
docker image push --all-tags charat/go-back-pg-sit

docker images
docker rmi $(docker images go-back-pg-sit --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=SIT push DockerHub ${releasePBS} OK" https://notify-api.line.me/api/notify