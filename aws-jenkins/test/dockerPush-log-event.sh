#!/bin/bash
releasePBP=`docker images logevent --format {{.Tag}} | head -1`

docker image tag logevent:$releasePBP logevent:latest
docker image tag logevent:$releasePBP charat/logevent:$releasePBP 
docker image tag logevent:latest charat/logevent:latest
docker image push --all-tags charat/logevent

docker images
docker rmi $(docker images logevent --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images


curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=PROD push DockerHub ${releasePBP} OK" https://notify-api.line.me/api/notify