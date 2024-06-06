#!/bin/bash
echo "hello"
tagnameBS=`cat /var/lib/jenkins/workspace/gw-back-sit/package.json |grep "version" |cut -d'"' -f 4`
releaseBS=`echo $tagnameBS |cut -d ' ' -f 1`
echo $releaseBS

sed -i -e "s/gw-back-yyy/gw-back-sit/g" /var/lib/jenkins/workspace/gw-back-sit/docker-compose.yml
sed -i -e "s/gw-back-xxx/gw-back-sit/g" /var/lib/jenkins/workspace/gw-back-sit/docker-compose.yml
sed -i -e "s/latest/${releaseBS}/g" /var/lib/jenkins/workspace/gw-back-sit/docker-compose.yml
cat /var/lib/jenkins/workspace/gw-back-sit/docker-compose.yml

cd  /var/lib/jenkins/workspace/gw-back-sit/
docker-compose build prod
cd /home/ec2-user/

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=SIT Build Code ${releaseBS} OK" https://notify-api.line.me/api/notify