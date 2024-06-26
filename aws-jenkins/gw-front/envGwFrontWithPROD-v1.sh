#!/bin/bash
#prepare  data
#
# Env for gw-Back-PROD
# ver 0.0.3 16/7/66 12:00
tagname=`cat /var/lib/jenkins/workspace/gw-front-prod/package.json |grep "version" |cut -d '"' -f 4`
releaseFS=`echo $tagname |cut -d ' ' -f 1`

hotjar_id='3738131'    #gosi id  https://go.gpautoplus.co.th
stage='PROD' 
timestamp=$(date)

#replace data
sed -i -e "s|%hotjar_id%|${hotjar_id}|g" /var/lib/jenkins/workspace/gw-front-prod/src/environments/environment.prod.ts
sed -i -e "s|3738131|${hotjar_id}|g" /var/lib/jenkins/workspace/gw-front-prod/src/index.html
# sed -i -e "s|%sapApiToken%|${sapApiToken}|g" /var/lib/jenkins/workspace/gw-front-prod/src/environments/environment.prod.ts
sed -i -e "s|%stage%|${stage}|g" /var/lib/jenkins/workspace/gw-front-prod/src/environments/environment.prod.ts
sed -i -e "s|%timestamp%|${timestamp}|g" /var/lib/jenkins/workspace/gw-front-prod/src/environments/environment.prod.ts
sed -i -e "s|%release%|${releaseFS}|g" /var/lib/jenkins/workspace/gw-front-prod/src/environments/environment.prod.ts

# no need change filename nginx.conf
# old_filename="nginx.conf.prod"
# new_filename="nginx.conf"
# mv "$old_filename" "$new_filename" 

#show nginx.conf
cat nginx.conf

#debug
cat /var/lib/jenkins/workspace/gw-front-prod/src/environments/environment.prod.ts

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=PROD prepare Code ${releaseFS} OK" https://notify-api.line.me/api/notify
