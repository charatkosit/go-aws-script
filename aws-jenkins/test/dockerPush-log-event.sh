#!/bin/bash
releasePBP=`docker images test-log-event --format {{.Tag}} | head -1`

docker image tag test-log-event:$releasePBP test-log-event:latest
docker image tag test-log-event:$releasePBP charat/test-log-event:$releasePBP 
docker image tag test-log-event:latest charat/test-log-event:latest
docker image push --all-tags charat/test-log-event

docker images
docker rmi $(docker images test-log-event --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images


curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=PROD push DockerHub ${releasePBP} OK" https://notify-api.line.me/api/notify