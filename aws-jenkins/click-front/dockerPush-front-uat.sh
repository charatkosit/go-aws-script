#!/bin/bash
releaseFU=`docker images go-front-uat --format {{.Tag}} | head -1`

docker image tag go-front-uat:$releaseFU go-front-uat:latest
docker image tag go-front-uat:$releaseFU charat/go-front-uat:$releaseFU 
docker image tag go-front-uat:latest charat/go-front-uat:latest
docker image push --all-tags charat/go-front-uat

docker images
docker rmi $(docker images go-front-uat --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineJenkinClick}" -F "message=Click-Front-UAT push DockerHub  ${releaseFU} OK" https://notify-api.line.me/api/notify