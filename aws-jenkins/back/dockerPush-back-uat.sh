#!/bin/bash
releasePBU=`docker images go-back-uat --format {{.Tag}} | head -1`

docker image tag go-back-uat:$releasePBU go-back-uat:latest
docker image tag go-back-uat:$releasePBU charat/go-back-uat:$releasePBU 
docker image tag go-back-uat:latest charat/go-back-uat:latest
docker image push --all-tags charat/go-back-uat

docker images
docker rmi $(docker images go-back-uat --format "{{.ID}}") -f
#docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images
