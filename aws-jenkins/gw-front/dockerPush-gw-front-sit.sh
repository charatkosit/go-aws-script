#!/bin/bash
releaseFS=`docker images gw-front-sit --format {{.Tag}} | head -1`

docker image tag gw-front-sit:$releaseFS gw-front-sit:latest
docker image tag gw-front-sit:$releaseFS charat/gw-front-sit:$releaseFS 
docker image tag gw-front-sit:latest charat/gw-front-sit:latest
docker image push --all-tags charat/gw-front-sit

docker images
docker rmi $(docker images gw-front-sit --format "{{.ID}}") -f

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

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=SIT push DockerHub  ${releaseFS} OK" https://notify-api.line.me/api/notify