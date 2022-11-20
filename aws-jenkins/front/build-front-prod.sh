#!/bin/bash
echo "get version from package.json and to build docker"
tagname=`cat /var/lib/jenkins/workspace/go-front-prod/package.json |grep "version" |cut -d'"' -f 4`
release=`echo $tagname |cut -d ' ' -f 1`
echo $release

cd /var/lib/jenkins/workspace/go-front-prod/
docker build -t go-front-prod:$release -f ./Dockerfile .
cd /home/ec2-user/