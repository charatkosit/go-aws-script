#!/bin/bash
echo "hello"
tagnameBS=`cat /var/lib/jenkins/workspace/Click-Back-Prod/package.json |grep "version" |cut -d'"' -f 4`
releaseBS=`echo $tagnameBS |cut -d ' ' -f 1`
echo $releaseBS

sed -i -e "s/click-back-xxx/Click-Back-Prod/g" /var/lib/jenkins/workspace/Click-Back-Prod/docker-compose.yml
sed -i -e "s/latest/${releaseBS}/g" /var/lib/jenkins/workspace/Click-Back-Prod/docker-compose.yml
cat /var/lib/jenkins/workspace/Click-Back-Prod/docker-compose.yml

cd  /var/lib/jenkins/workspace/Click-Back-Prod/
docker-compose build prod
cd /home/ec2-user/

curl -X POST -H "Authorization: Bearer ${tokenLineJenkinClick}" -F "message=Click-Back-PROD Build Code ${releaseBS} OK" https://notify-api.line.me/api/notify