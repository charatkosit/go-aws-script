#!/bin/bash
release=`docker images go-front-prod --format {{.Tag}} | head -1`

docker image tag go-front-prod:$release go-front-prod:latest
docker image tag go-front-prod:$release charat/go-front-prod:$release 
docker image tag go-front-prod:latest charat/go-front-prod:latest
docker image push --all-tags charat/go-front-prod

docker images
docker rmi $(docker images go-front-prod --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images
