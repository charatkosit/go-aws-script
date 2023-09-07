#!/bin/bash
#prepare  data
#
# Env for Go-Back-UAT
# ver 0.0.3 15/7/66 22:19

tagname=`cat /var/lib/jenkins/workspace/go-front-uat/package.json |grep "version" |cut -d '"' -f 4`
releaseFS=`echo $tagname |cut -d ' ' -f 1`

backendUrl='http://172.51.66.4:3000/'
authUrl='http://172.51.64.139:3100/'
logUrl='http://172.51.50.182:3200/'

stage='UAT' 
timestamp=$(date)

#replace data
sed -i -e "s|%backendUrl%|${backendUrl}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts
sed -i -e "s|%authUrl%|${authUrl}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts
sed -i -e "s|%logUrl%|${logUrl}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts
# sed -i -e "s|%sapUrl%|${sapUrl}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts
# sed -i -e "s|%sapApiToken%|${sapApiToken}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts
sed -i -e "s|%stage%|${stage}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts
sed -i -e "s|%timestamp%|${timestamp}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts
sed -i -e "s|%release%|${releaseFS}|g" /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts

#change filename nginx.conf
old_filename="nginx.conf.uat"
new_filename="nginx.conf"
mv "$old_filename" "$new_filename" 

#show nginx.conf
cat nginx.conf


#debug
cat /var/lib/jenkins/workspace/go-front-uat/src/environments/environment.prod.ts

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=UAT prepare Code ${releaseFS} OK" https://notify-api.line.me/api/notify
