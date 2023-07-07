#!/bin/bash
releaseFS=`docker images go-front-prod --format {{.Tag}} | head -1`

docker image tag go-front-prod:$releaseFS go-front-prod:latest
docker image tag go-front-prod:$releaseFS charat/go-front-prod:$releaseFS 
docker image tag go-front-prod:latest charat/go-front-prod:latest
docker image push --all-tags charat/go-front-prod

docker images
docker rmi $(docker images go-front-prod --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=PROD push DockerHub  ${releaseFS} OK" https://notify-api.line.me/api/notify