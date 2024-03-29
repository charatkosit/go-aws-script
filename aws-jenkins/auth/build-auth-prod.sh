#!/bin/bash
echo "hello"
tagnameBP=`cat /var/lib/jenkins/workspace/Go-Auth-PROD/package.json |grep "version" |cut -d'"' -f 4`
releaseBP=`echo $tagnameBP |cut -d ' ' -f 1`
echo $releaseBP

sed -i -e "s/go-auth-xxx/go-auth-prod/g" /var/lib/jenkins/workspace/Go-Auth-PROD/docker-compose.yml
sed -i -e "s/latest/${releaseBP}/g" /var/lib/jenkins/workspace/Go-Auth-PROD/docker-compose.yml

cat /var/lib/jenkins/workspace/Go-Auth-PROD/docker-compose.yml

cd  /var/lib/jenkins/workspace/Go-Auth-PROD/
docker-compose build prod
cd /home/ec2-user/

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=PROD Build Code ${releaseBP} OK" https://notify-api.line.me/api/notify