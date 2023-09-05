#!/bin/bash
#prepare  data
tagname=`cat /var/lib/jenkins/workspace/Click-Front-Prod/package.json |grep "version" |cut -d'"' -f 4`
releaseFP=`echo $tagname |cut -d ' ' -f 1 `

backendUrl='http://clickapi.ddns.net:3200/'
authUrl='http://172.41.60.18:3000'
sapUrl=''
sapApiToken=''
stage='PROD' 
timestamp=$(date)

#replace data
# sed -i -e "s|%backendUrl%|${backendUrl}|g" /var/lib/jenkins/workspace/click-front-prod/src/environments/environment.prod.ts
# sed -i -e "s|%authUrl%|${authUrl}|g" /var/lib/jenkins/workspace/click-front-prod/src/environments/environment.prod.ts
# sed -i -e "s|%sapUrl%|${sapUrl}|g" /var/lib/jenkins/workspace/click-front-prod/src/environments/environment.prod.ts
# sed -i -e "s|%sapApiToken%|${sapApiToken}|g" /var/lib/jenkins/workspace/click-front-prod/src/environments/environment.prod.ts
# sed -i -e "s|%stage%|${stage}|g" /var/lib/jenkins/workspace/click-front-prod/src/environments/environment.prod.ts
# sed -i -e "s|%timestamp%|${timestamp}|g" /var/lib/jenkins/workspace/click-front-prod/src/environments/environment.prod.ts
# sed -i -e "s|%release%|${releaseFP}|g" /var/lib/jenkins/workspace/click-front-prod/src/environments/environment.prod.ts
#replace data proxy in nginx
# sed -i -e "s|172.41.62.59:3000|172.41.62.164:3000|g" /var/lib/jenkins/workspace/click-front-prod/nginx.conf
#debug
# cat /var/lib/jenkins/workspace/click-front-prod/src/environments/environment.prod.ts

curl -X POST -H "Authorization: Bearer ${tokenLineJenkinClick}" -F "message=Click-Front-PROD prepare Code ${releaseFP} OK" https://notify-api.line.me/api/notify

