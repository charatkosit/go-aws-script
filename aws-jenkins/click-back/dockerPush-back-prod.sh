#!/bin/bash
releasePBS=`docker images click-back-prod --format {{.Tag}} | head -1`

docker image tag click-back-prod:$releasePBS click-back-prod:latest
docker image tag click-back-prod:$releasePBS charat/click-back-prod:$releasePBS 
docker image tag click-back-prod:latest charat/click-back-prod:latest
docker image push --all-tags charat/click-back-prod

docker images
docker rmi $(docker images click-back-prod --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineJenkinClick}" -F "message=Click-Back-PROD push DockerHub ${releasePBS} OK" https://notify-api.line.me/api/notify