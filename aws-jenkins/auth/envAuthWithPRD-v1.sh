#!/bin/bash

tagnameBP=`cat /var/lib/jenkins/workspace/Go-Auth-PROD/package.json |grep "version" |cut -d '"' -f 4`
releaseBP=`echo $tagnameBP |cut -d ' ' -f 1`

sed -i -e "s|127.0.0.1|172.51.67.165|g" /var/lib/jenkins/workspace/Go-Auth-PROD/src/environments/environment.ts
sed -i -e "s|Back-Auth-Dev|${releaseBP}|g" /var/lib/jenkins/workspace/Go-Auth-PROD/src/environments/environment.ts
#debug
cat /var/lib/jenkins/workspace/Go-Auth-PROD/src/environments/environment.ts

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=PROD prepare Code ${releaseBP} OK" https://notify-api.line.me/api/notify