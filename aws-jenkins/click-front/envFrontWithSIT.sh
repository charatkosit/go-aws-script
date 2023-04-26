#!/bin/bash
#prepare  data
tagname=`cat /var/lib/jenkins/workspace/click-front-sit/package.json |grep "version" |cut -d '"' -f 4`
releaseFS=`echo $tagname |cut -d ' ' -f 1`

backendUrl='http://172.31.21.167:3000/'
stage='SIT' 
timestamp=$(date)

#replace data
sed -i -e "s|%backendUrl%|${backendUrl}|g" /var/lib/jenkins/workspace/click-front-sit/src/environments/environment.prod.ts
sed -i -e "s|%stage%|${stage}|g" /var/lib/jenkins/workspace/click-front-sit/src/environments/environment.prod.ts
sed -i -e "s|%timestamp%|${timestamp}|g" /var/lib/jenkins/workspace/click-front-sit/src/environments/environment.prod.ts
sed -i -e "s|%release%|${releaseFS}|g" /var/lib/jenkins/workspace/click-front-sit/src/environments/environment.prod.ts

#debug
cat /var/lib/jenkins/workspace/click-front-sit/src/environments/environment.prod.ts

curl -X POST -H "Authorization: Bearer ${tokenLineJenkinClick}" -F "message=Click-Front-SIT prepare Code ${releaseFS} OK" https://notify-api.line.me/api/notify
