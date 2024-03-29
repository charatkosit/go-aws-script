#!bin/bash
docker stop $(docker ps --format "{{.ID}}")
docker rmi $(docker images --format "{{.ID}}" --filter "dangling=true" | head -1)
docker stop $(docker ps --filter "ancestor=charat/go-front-uat:latest" -q)
docker rm $(docker ps --filter "ancestor=charat/go-front-uat:latest" -aq)
docker pull charat/go-front-uat:latest
docker run -p 80:80 -p 443:443 \
-v /home/ec2-user/certbot-certs/live/uat-goplus.ddns.net/fullchain.pem:/etc/ssl/certs/fullchain.pem \
-v /home/ec2-user/certbot-certs/live/uat-goplus.ddns.net/privkey.pem:/etc/ssl/private/privkey.pem \
-d charat/go-front-uat:latest
# docker run -p 8000:80 -d charat/go-front-uat:latest
curl -X POST -H "Authorization: Bearer ${tokenLineAF}" -F "message=UAT deploy new version https://uat-goplus.ddns.net" https://notify-api.line.me/api/notify

#stat containter when system restart
docker update --restart=always $(docker ps --format "{{.ID}}")