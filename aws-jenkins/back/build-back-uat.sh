#!/bin/bash
echo "hello"
tagnameBU=`cat /var/lib/jenkins/workspace/go-back-uat/package.json |grep "version" |cut -d'"' -f 4`
releaseBU=`echo $tagnameBU |cut -d ' ' -f 1`
echo $releaseBU

sed -i -e "s/go-back-xxx/go-back-uat/g" /var/lib/jenkins/workspace/go-back-uat/docker-compose.yml
sed -i -e "s/latest/${releaseBU}/g" /var/lib/jenkins/workspace/go-back-uat/docker-compose.yml
cat /var/lib/jenkins/workspace/go-back-uat/docker-compose.yml

cd  /var/lib/jenkins/workspace/go-back-uat/
docker-compose build prod
cd /home/ec2-user/