#!bin/bash
docker stop $(docker ps --format "{{.ID}}")
docker rmi $(docker images --format "{{.ID}}" --filter "dangling=true" | head -1)
docker stop $(docker ps --filter "ancestor=charat/gw-front-prod:latest" -q)
docker rm $(docker ps --filter "ancestor=charat/gw-front-prod:latest" -aq)
docker pull charat/gw-front-prod:latest
docker run -p 80:80 -p 443:443 \
-v /home/ec2-user/certbot-certs/live/gw-goplus.ddns.net/fullchain.pem:/etc/ssl/certs/fullchain.pem \
-v /home/ec2-user/certbot-certs/live/gw-goplus.ddns.net/privkey.pem:/etc/ssl/private/privkey.pem \
-d charat/gw-front-prod:latest
# docker run -p 8000:80 -d charat/gw-front-prod:latest
curl -X POST -H "Authorization: Bearer ${tokenLineAF}" -F "message=PROD deploy new version https://gw-goplus.ddns.net" https://notify-api.line.me/api/notify

#stat containter when system restart
docker update --restart=always $(docker ps --format "{{.ID}}")