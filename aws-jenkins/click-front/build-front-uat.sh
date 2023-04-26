#!/bin/bash
echo "get version from package.json and to build docker"
tagname=`cat /var/lib/jenkins/workspace/go-front-uat/package.json |grep "version" |cut -d'"' -f 4`
releaseFU=`echo $tagname |cut -d ' ' -f 1`
echo $releaseFU

cd /var/lib/jenkins/workspace/go-front-uat/
docker build -t go-front-uat:$releaseFU -f ./Dockerfile .
cd /home/ec2-user/


curl -X POST -H "Authorization: Bearer ${tokenLineJenkinClick}" -F "message=Click-Front-UAT Build Code ${releaseFU} OK" https://notify-api.line.me/api/notify