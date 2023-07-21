#!/bin/bash
releasePBS=`docker images go-auth-sit --format {{.Tag}} | head -1`

docker image tag go-auth-sit:$releasePBS go-auth-sit:latest
docker image tag go-auth-sit:$releasePBS charat/go-auth-sit:$releasePBS 
docker image tag go-auth-sit:latest charat/go-auth-sit:latest
docker image push --all-tags charat/go-auth-sit

docker images
docker rmi $(docker images go-auth-sit --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=SIT push DockerHub ${releasePBS} OK" https://notify-api.line.me/api/notify