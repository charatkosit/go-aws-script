#!/bin/bash
#prepare  data
#
# Env for go-front-sit-FeatA
# ver 0.0.3 15/7/66 22:19

tagname=`cat /var/lib/jenkins/workspace/go-front-sit-FeatA/package.json |grep "version" |cut -d '"' -f 4`
releaseFS=`echo $tagname |cut -d ' ' -f 1`

hotjar_id='3737456'   # https://sit-goplus.ddns.net

stage='SIT' 
timestamp=$(date)

#replace data
sed -i -e "s|%hotjar_id%|${hotjar_id}|g" /var/lib/jenkins/workspace/go-front-sit-FeatA/src/environments/environment.prod.ts
sed -i -e "s|3738131|${hotjar_id}|g" /var/lib/jenkins/workspace/go-front-sit-FeatA/src/index.html
# sed -i -e "s|%sapApiToken%|${sapApiToken}|g" /var/lib/jenkins/workspace/go-front-sit-FeatA/src/environments/environment.prod.ts
sed -i -e "s|%stage%|${stage}|g" /var/lib/jenkins/workspace/go-front-sit-FeatA/src/environments/environment.prod.ts
sed -i -e "s|%timestamp%|${timestamp}|g" /var/lib/jenkins/workspace/go-front-sit-FeatA/src/environments/environment.prod.ts
sed -i -e "s|%release%|${releaseFS}|g" /var/lib/jenkins/workspace/go-front-sit-FeatA/src/environments/environment.prod.ts

#change filename nginx.conf
old_filename="nginx.conf.sit"
new_filename="nginx.conf"
mv "$old_filename" "$new_filename" 

#show nginx.conf
cat nginx.conf


#debug
cat /var/lib/jenkins/workspace/go-front-sit-FeatA/src/environments/environment.prod.ts

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message=SIT-FeatA prepare Code ${releaseFS} OK" https://notify-api.line.me/api/notify
