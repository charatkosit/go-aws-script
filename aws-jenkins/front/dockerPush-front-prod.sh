#!/bin/bash
releaseFS=`docker images go-front-prod --format {{.Tag}} | head -1`

docker image tag go-front-prod:$releaseFS go-front-prod:latest
docker image tag go-front-prod:$releaseFS charat/go-front-prod:$releaseFS 
docker image tag go-front-prod:latest charat/go-front-prod:latest
docker image push --all-tags charat/go-front-prod

docker images
docker rmi $(docker images go-front-prod --format "{{.ID}}") -f

#Looking for Dangling images
dangling_images=$(docker images --format "{{.ID}}" --filter "dangling=true")

# There are dangling images ?
if [ -n "$dangling_images" ]; then
    # Delete If those are dangling images
    docker rmi -f $dangling_images
else
    # message no action
    echo "No dangling images"
fi

docker images

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=PROD push DockerHub  ${releaseFS} OK" https://notify-api.line.me/api/notify