#!/bin/bash
releaseFS=`docker images gw-front-sit-feata --format {{.Tag}} | head -1`

docker image tag gw-front-sit-feata:$releaseFS gw-front-sit-feata:latest
docker image tag gw-front-sit-feata:$releaseFS charat/gw-front-sit-feata:$releaseFS 
docker image tag gw-front-sit-feata:latest charat/gw-front-sit-feata:latest
docker image push --all-tags charat/gw-front-sit-feata

docker images
docker rmi $(docker images gw-front-sit-feata --format "{{.ID}}") -f

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

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=SIT-FeatA push DockerHub  ${releaseFS} OK" https://notify-api.line.me/api/notify
