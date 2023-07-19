#!bin/bash
docker stop $(docker ps --format "{{.ID}}")
docker rmi $(docker images --format "{{.ID}}" --filter "dangling=true" | head -1)
docker stop $(docker ps --filter "ancestor=charat/go-front-sit:latest" -q)
docker rm $(docker ps --filter "ancestor=charat/go-front-sit:latest" -aq)
docker pull charat/go-front-sit:latest
docker run -p 8000:80 -d charat/go-front-sit:latest
curl -X POST -H "Authorization: Bearer ${tokenLineAF}" -F "message=SIT deploy new version http://gosit.ddns.net:8000" https://notify-api.line.me/api/notify

#stat containter when system restart
docker update --restart=always $(docker ps --format "{{.ID}}")