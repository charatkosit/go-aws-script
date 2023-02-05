#!/bin/bash
#prepare  data
tagname=`cat /var/lib/jenkins/workspace/go-front-sit/package.json |grep "version" |cut -d '"' -f 4`
releaseFS=`echo $tagname |cut -d ' ' -f 1`

backendUrl='http://13.229.143.20:3000/'
authUrl='http://172.41.60.18:3000'
sapUrl='http://192.168.20.17:8880/apigoplus/EnqPartlist/'
sapApiToken='z@hz3sNY#0ohB9SspeE9@fLDQ%r65x$k8LxL28VH72FfvRWgCn'
stage='SIT' 
timestamp=$(date)

#replace data
sed -i -e "s|%backendUrl%|${backendUrl}|g" /var/lib/jenkins/workspace/go-front-sit/src/environments/environment.prod.ts
sed -i -e "s|%authUrl%|${authUrl}|g" /var/lib/jenkins/workspace/go-front-sit/src/environments/environment.prod.ts
sed -i -e "s|%sapUrl%|${sapUrl}|g" /var/lib/jenkins/workspace/go-front-sit/src/environments/environment.prod.ts
sed -i -e "s|%sapApiToken%|${sapApiToken}|g" /var/lib/jenkins/workspace/go-front-sit/src/environments/environment.prod.ts
sed -i -e "s|%stage%|${stage}|g" /var/lib/jenkins/workspace/go-front-sit/src/environments/environment.prod.ts
sed -i -e "s|%timestamp%|${timestamp}|g" /var/lib/jenkins/workspace/go-front-sit/src/environments/environment.prod.ts
sed -i -e "s|%release%|${releaseFS}|g" /var/lib/jenkins/workspace/go-front-sit/src/environments/environment.prod.ts

#debug
cat /var/lib/jenkins/workspace/go-front-sit/src/environments/environment.prod.ts

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=SIT prepare Code ${releaseFS} OK" https://notify-api.line.me/api/notify
