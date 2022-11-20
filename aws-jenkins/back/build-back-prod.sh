#!/bin/bash
echo "hello"
tagnameBP=`cat /var/lib/jenkins/workspace/go-back-prod/package.json |grep "version" |cut -d'"' -f 4`
releaseBP=`echo $tagnameBP |cut -d ' ' -f 1`
echo $releaseBP

sed -i -e "s/go-back-xxx/go-back-prod/g" /var/lib/jenkins/workspace/go-back-prod/docker-compose.yml
sed -i -e "s/latest/${releaseBP}/g" /var/lib/jenkins/workspace/go-back-prod/docker-compose.yml

cat /var/lib/jenkins/workspace/go-back-prod/docker-compose.yml

cd  /var/lib/jenkins/workspace/go-back-prod/
docker-compose build prod
cd /home/ec2-user/