#!/bin/bash
#stop container before
docker stop $(docker ps --filter 'ancestor=charat/go-back-prod:latest' --format "{{.ID}}")
cd /home/ec2-user/docker-mysql-pma/
docker-compose down --rmi all
cd /home/ec2-user/

#update LineToken 
#AWS-Front:
tokenLineAF=K35RgggwSNxmv2UGVT5mGmO5wAwCAuFQuNodqLh5gCG
#AWS-Back:
tokenLineAB=ImU3zoEwmB44IwAtpeoqPZihzoLld0xUVeSiy1tD1tz

cat >> ~/.bashrc << EOF
export tokenLineAF=K35RgggwSNxmv2UGVT5mGmO5wAwCAuFQuNodqLh5gCG
export tokenLineAB=ImU3zoEwmB44IwAtpeoqPZihzoLld0xUVeSiy1tD1tz
EOF

#remove image <none> and  go-back
docker images
docker rmi $(docker images go-back-prod --format "{{.ID}}") -f
docker rmi -f $(docker images --format "{{.ID}}" --filter "dangling=true")
docker images

#pull and run
docker pull charat/go-back-prod:latest
docker run -p 3000:3000 -d charat/go-back-prod:latest
curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=PROD new version http://goapi.ddns.net:3000/api/v1" https://notify-api.line.me/api/notify