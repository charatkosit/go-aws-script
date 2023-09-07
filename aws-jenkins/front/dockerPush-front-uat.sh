#!/bin/bash
releaseFS=`docker images go-front-uat --format {{.Tag}} | head -1`

docker image tag go-front-uat:$releaseFS go-front-uat:latest
docker image tag go-front-uat:$releaseFS charat/go-front-uat:$releaseFS 
docker image tag go-front-uat:latest charat/go-front-uat:latest
docker image push --all-tags charat/go-front-uat

docker images
docker rmi $(docker images go-front-uat --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=UAT push DockerHub  ${releaseFS} OK" https://notify-api.line.me/api/notify