#!/bin/bash
echo "hello"
tagnameBS=`cat /var/lib/jenkins/workspace/go-back-sit/package.json |grep "version" |cut -d'"' -f 4`
releaseBS=`echo $tagnameBS |cut -d ' ' -f 1`
echo $releaseBS

sed -i -e "s/go-back-xxx/go-back-sit/g" /var/lib/jenkins/workspace/go-back-sit/docker-compose.yml
sed -i -e "s/latest/${releaseBS}/g" /var/lib/jenkins/workspace/go-back-sit/docker-compose.yml
cat /var/lib/jenkins/workspace/go-back-sit/docker-compose.yml

cd  /var/lib/jenkins/workspace/go-back-sit/
docker-compose build prod
cd /home/ec2-user/