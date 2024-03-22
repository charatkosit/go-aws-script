#!/bin/bash
echo "get version from package.json and to build docker"
tagname=`cat /var/lib/jenkins/workspace/go-front-sit-FeatA/package.json |grep "version" |cut -d'"' -f 4`
releaseFS=`echo $tagname |cut -d ' ' -f 1`
echo $releaseFS

cd /var/lib/jenkins/workspace/go-front-sit-FeatA/
docker build -t go-front-sit-feata:$releaseFS -f ./Dockerfile .
cd /home/ec2-user/


curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=SIT-FeatA Build Code ${releaseFS} OK" https://notify-api.line.me/api/notify
