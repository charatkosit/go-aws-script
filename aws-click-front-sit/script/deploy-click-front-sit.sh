#!bin/bash
docker stop $(docker ps --format "{{.ID}}")
docker rmi $(docker images --format "{{.ID}}" --filter "dangling=true" | head -1)
docker stop $(docker ps --filter "ancestor=charat/click-front-sit:latest" -q)
docker rm $(docker ps --filter "ancestor=charat/click-front-sit:latest" -aq)
docker pull charat/click-front-sit:latest
docker run -p 8000:80 -d charat/click-front-sit:latest
curl -X POST -H "Authorization: Bearer ${tokenLineDeployGroup}" -F "message=Click-Front-SIT deploy new version http://52.221.206.252/" https://notify-api.line.me/api/notify

#stat containter when system restart
docker update --restart=always $(docker ps --format "{{.ID}}")