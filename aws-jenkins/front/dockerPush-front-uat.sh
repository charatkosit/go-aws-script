#!/bin/bash
release=`docker images go-front-uat --format {{.Tag}} | head -1`

docker image tag go-front-uat:$release go-front-uat:latest
docker image tag go-front-uat:$release charat/go-front-uat:$release 
docker image tag go-front-uat:latest charat/go-front-uat:latest
docker image push --all-tags charat/go-front-uat

docker images
docker rmi $(docker images go-front-uat --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images