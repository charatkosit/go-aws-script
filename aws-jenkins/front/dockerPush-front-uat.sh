#!/bin/bash
releaseFS=`docker images go-front-uat --format {{.Tag}} | head -1`

docker image tag go-front-uat:$releaseFS go-front-uat:latest
docker image tag go-front-uat:$releaseFS charat/go-front-uat:$releaseFS 
docker image tag go-front-uat:latest charat/go-front-uat:latest
docker image push --all-tags charat/go-front-uat

docker images
docker rmi $(docker images go-front-uat --format "{{.ID}}") -f

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

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=UAT push DockerHub  ${releaseFS} OK" https://notify-api.line.me/api/notify