#!/bin/bash
releaseFS=`docker images click-front-sit --format {{.Tag}} | head -1`

docker image tag click-front-sit:$releaseFS click-front-sit:latest
docker image tag click-front-sit:$releaseFS charat/click-front-sit:$releaseFS 
docker image tag click-front-sit:latest charat/click-front-sit:latest
docker image push --all-tags charat/click-front-sit

docker images
docker rmi $(docker images click-front-sit --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineJenkinClick}" -F "message=Click-Front-SIT push DockerHub  ${releaseFS} OK" https://notify-api.line.me/api/notify