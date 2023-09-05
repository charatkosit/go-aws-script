#!/bin/bash
releaseFP=`docker images click-front-prod --format {{.Tag}} | head -1`

docker image tag click-front-prod:$releaseFP click-front-prod:latest
docker image tag click-front-prod:$releaseFP charat/click-front-prod:$releaseFP
docker image tag click-front-prod:latest charat/click-front-prod:latest
docker image push --all-tags charat/click-front-prod

docker images
docker rmi $(docker images click-front-prod --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineJenkinClick}" -F "message=Click-Front-PROD push DockerHub  ${releaseFP} OK" https://notify-api.line.me/api/notify