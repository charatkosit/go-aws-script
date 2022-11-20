#!/bin/bash
releasePBS=`docker images go-back-sit --format {{.Tag}} | head -1`

docker image tag go-back-sit:$releasePBS go-back-sit:latest
docker image tag go-back-sit:$releasePBS charat/go-back-sit:$releasePBS 
docker image tag go-back-sit:latest charat/go-back-sit:latest
docker image push --all-tags charat/go-back-sit

docker images
docker rmi $(docker images go-back-sit --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images