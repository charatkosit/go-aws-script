#!/bin/bash
release=`docker images go-front-sit --format {{.Tag}} | head -1`

docker image tag go-front-sit:$release go-front-sit:latest
docker image tag go-front-sit:$release charat/go-front-sit:$release 
docker image tag go-front-sit:latest charat/go-front-sit:latest
docker image push --all-tags charat/go-front-sit

docker images
docker rmi $(docker images go-front-sit --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images