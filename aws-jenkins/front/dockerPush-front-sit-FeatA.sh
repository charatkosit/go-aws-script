#!/bin/bash
releaseFS=`docker images go-front-sit-feata --format {{.Tag}} | head -1`

docker image tag go-front-sit-FeatA:$releaseFS go-front-sit-feata:latest
docker image tag go-front-sit-FeatA:$releaseFS charat/go-front-sit-feata:$releaseFS 
docker image tag go-front-sit-FeatA:latest charat/go-front-sit-feata:latest
docker image push --all-tags charat/go-front-sit-feata

docker images
docker rmi $(docker images go-front-sit-feata --format "{{.ID}}") -f

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
