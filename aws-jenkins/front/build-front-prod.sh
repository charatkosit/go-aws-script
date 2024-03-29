#!/bin/bash
echo "get version from package.json and to build docker"
tagname=`cat /var/lib/jenkins/workspace/go-front-prod/package.json |grep "version" |cut -d'"' -f 4`
releaseFS=`echo $tagname |cut -d ' ' -f 1`
echo $releaseFS

cd /var/lib/jenkins/workspace/go-front-prod/
docker build -t go-front-prod:$releaseFS -f ./Dockerfile .
cd /home/ec2-user/


curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=PROD Build Code ${releaseFS} OK" https://notify-api.line.me/api/notify