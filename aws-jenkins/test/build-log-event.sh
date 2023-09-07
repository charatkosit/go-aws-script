#!/bin/bash
echo "hello"
tagnameBP=`cat /var/lib/jenkins/workspace/test.LogEvent/package.json |grep "version" |cut -d'"' -f 4`
releaseBP=`echo $tagnameBP |cut -d ' ' -f 1`
echo $releaseBP

sed -i -e "s/go-back-yyy/test.LogEvent/g" /var/lib/jenkins/workspace/test.LogEvent/docker-compose.yml
sed -i -e "s/go-back-xxx/test.LogEvent/g" /var/lib/jenkins/workspace/test.LogEvent/docker-compose.yml
sed -i -e "s/latest/${releaseBP}/g" /var/lib/jenkins/workspace/test.LogEvent/docker-compose.yml

cat /var/lib/jenkins/workspace/test.LogEvent/docker-compose.yml

cd  /var/lib/jenkins/workspace/test.LogEvent/
docker-compose build prod
cd /home/ec2-user/

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=PROD Build Code ${releaseBP} OK" https://notify-api.line.me/api/notify