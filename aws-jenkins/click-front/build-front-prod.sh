#!/bin/bash
echo "get version from package.json and to build docker"
tagname=`cat /var/lib/jenkins/workspace/Click-Front-Prod/package.json |grep "version" |cut -d'"' -f 4`
releaseFP=`echo $tagname |cut -d ' ' -f 1`
echo $releaseFP

cd /var/lib/jenkins/workspace/Click-Front-Prod/
docker build -t click-front-prod:$releaseFP -f ./Dockerfile .
cd /home/ec2-user/

curl -X POST -H "Authorization: Bearer ${tokenLineJenkinClick}" -F "message=Click-Front-PROD Build Code ${releaseFP} OK" https://notify-api.line.me/api/notify