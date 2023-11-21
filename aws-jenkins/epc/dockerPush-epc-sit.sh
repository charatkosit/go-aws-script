#!/bin/bash
releasePBS=`docker images go-epc-sit --format {{.Tag}} | head -1`

docker image tag go-epc-sit:$releasePBS go-epc-sit:latest
docker image tag go-epc-sit:$releasePBS charat/go-epc-sit:$releasePBS 
docker image tag go-epc-sit:latest charat/go-epc-sit:latest
docker image push --all-tags charat/go-epc-sit

docker images
docker rmi $(docker images go-epc-sit --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=SIT push DockerHub ${releasePBS} OK" https://notify-api.line.me/api/notify