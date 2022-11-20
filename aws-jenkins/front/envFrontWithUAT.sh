#!/bin/bash
#prepare  data
tagname=`cat /var/lib/jenkins/workspace/go-front-uat/package.json |grep "version" |cut -d'"' -f 4`
release=`echo $tagname |cut -d ' ' -f 1`

backendUrl='http://goapiuat.ddns.net:3000/'
sapUrl=''
sapApiToken=''
stage='UAT' 
timestamp=$(date)

#replace data
sed -i -e "s|%backendUrl%|${backendUrl}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts
sed -i -e "s|%sapUrl%|${sapUrl}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts
sed -i -e "s|%sapApiToken%|${sapApiToken}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts
sed -i -e "s|%stage%|${stage}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts
sed -i -e "s|%timestamp%|${timestamp}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts
sed -i -e "s|%release%|${release}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts

#debug
cat /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts