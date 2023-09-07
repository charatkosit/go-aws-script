#!/bin/bash
#prepare  data
#
# Env for Go-Back-PROD
# ver 0.0.3 16/7/66 12:00
tagname=`cat /var/lib/jenkins/workspace/go-front-prod/package.json |grep "version" |cut -d '"' -f 4`
releaseFS=`echo $tagname |cut -d ' ' -f 1`

backendUrl='http://172.51.64.46:3000/'
authUrl='http://172.51.67.165:3100/'
logUrl='http://172.51.50.182:3200/'
stage='PROD' 
timestamp=$(date)

#replace data
sed -i -e "s|%backendUrl%|${backendUrl}|g" /var/lib/jenkins/workspace/go-front-prod/src/environments/environment.prod.ts
sed -i -e "s|%authUrl%|${authUrl}|g" /var/lib/jenkins/workspace/go-front-prod/src/environments/environment.prod.ts
sed -i -e "s|%logUrl%|${logUrl}|g" /var/lib/jenkins/workspace/go-front-prod/src/environments/environment.prod.ts
# sed -i -e "s|%sapUrl%|${sapUrl}|g" /var/lib/jenkins/workspace/go-front-prod/src/environments/environment.prod.ts
# sed -i -e "s|%sapApiToken%|${sapApiToken}|g" /var/lib/jenkins/workspace/go-front-prod/src/environments/environment.prod.ts
sed -i -e "s|%stage%|${stage}|g" /var/lib/jenkins/workspace/go-front-prod/src/environments/environment.prod.ts
sed -i -e "s|%timestamp%|${timestamp}|g" /var/lib/jenkins/workspace/go-front-prod/src/environments/environment.prod.ts
sed -i -e "s|%release%|${releaseFS}|g" /var/lib/jenkins/workspace/go-front-prod/src/environments/environment.prod.ts

# no need change filename nginx.conf
# old_filename="nginx.conf.prod"
# new_filename="nginx.conf"
# mv "$old_filename" "$new_filename" 

#show nginx.conf
cat nginx.conf

#debug
cat /var/lib/jenkins/workspace/go-front-prod/src/environments/environment.prod.ts

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=PROD prepare Code ${releaseFS} OK" https://notify-api.line.me/api/notify
