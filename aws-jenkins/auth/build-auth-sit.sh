#!/bin/bash
echo "hello"
tagnameBS=`cat /var/lib/jenkins/workspace/Go-Auth-SIT/package.json |grep "version" |cut -d'"' -f 4`
releaseBS=`echo $tagnameBS |cut -d ' ' -f 1`
echo $releaseBS

sed -i -e "s/go-auth-xxx/go-auth-sit/g" /var/lib/jenkins/workspace/Go-Auth-SIT/docker-compose.yml
sed -i -e "s/latest/${releaseBS}/g" /var/lib/jenkins/workspace/Go-Auth-SIT/docker-compose.yml
cat /var/lib/jenkins/workspace/Go-Auth-SIT/docker-compose.yml

cd  /var/lib/jenkins/workspace/Go-Auth-SIT/
docker-compose build prod
cd /home/ec2-user/

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=SIT Build Code ${releaseBS} OK" https://notify-api.line.me/api/notify