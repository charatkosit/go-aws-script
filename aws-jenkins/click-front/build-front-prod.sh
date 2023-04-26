#!/bin/bash
echo "get version from package.json and to build docker"
tagname=`cat /var/lib/jenkins/workspace/go-front-prod/package.json |grep "version" |cut -d'"' -f 4`
releaseFP=`echo $tagname |cut -d ' ' -f 1`
echo $releaseFP

cd /var/lib/jenkins/workspace/go-front-prod/
docker build -t go-front-prod:$releaseFP -f ./Dockerfile .
cd /home/ec2-user/

curl -X POST -H "Authorization: Bearer ${tokenLineJenkinClick}" -F "message=Click-Front-PROD Build Code ${releaseFP} OK" https://notify-api.line.me/api/notify