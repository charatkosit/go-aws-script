#!/bin/bash
echo "hello"
tagnameBU=`cat /var/lib/jenkins/workspace/go-back-pg-uat/package.json |grep "version" |cut -d'"' -f 4`
releaseBU=`echo $tagnameBU |cut -d ' ' -f 1`
echo $releaseBU

sed -i -e "s/go-back-pg-yyy/go-back-pg-uat/g" /var/lib/jenkins/workspace/go-back-pg-uat/docker-compose.yml
sed -i -e "s/go-back-pg-xxx/go-back-pg-uat/g" /var/lib/jenkins/workspace/go-back-pg-uat/docker-compose.yml
sed -i -e "s/latest/${releaseBU}/g" /var/lib/jenkins/workspace/go-back-pg-uat/docker-compose.yml
cat /var/lib/jenkins/workspace/go-back-pg-uat/docker-compose.yml

cd  /var/lib/jenkins/workspace/go-back-pg-uat/
docker-compose build prod
cd /home/ec2-user/

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=UAT Build Code ${releaseBU} OK" https://notify-api.line.me/api/notify