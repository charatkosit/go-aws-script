#!/bin/bash
#prepare  data
tagname=`cat /var/lib/jenkins/workspace/go-front-uat/package.json |grep "version" |cut -d'"' -f 4`
releaseFU=`echo $tagname |cut -d ' ' -f 1`

backendUrl='http://54.224.78.26:3000/'
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
sed -i -e "s|%release%|${releaseFU}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts

#debug
cat /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=UAT prepare Code ${releaseFU} OK" https://notify-api.line.me/api/notify
