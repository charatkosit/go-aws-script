#!/bin/bash
releaseFS=`docker images go-front-sit --format {{.Tag}} | head -1`

docker image tag go-front-sit:$releaseFS go-front-sit:latest
docker image tag go-front-sit:$releaseFS charat/go-front-sit:$releaseFS 
docker image tag go-front-sit:latest charat/go-front-sit:latest
docker image push --all-tags charat/go-front-sit

docker images
docker rmi $(docker images go-front-sit --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=SIT push DockerHub  ${releaseFS} OK" https://notify-api.line.me/api/notify