#!/bin/bash
#------
# cd /var/lib/jenkins/workspace/go-auth-uat/src/environments/
# rm -rf environment.ts
# cp environment.uat.ts environment.ts
# cd /home/ec2-user
#------

tagnameBU=`cat /var/lib/jenkins/workspace/go-auth-uat/package.json |grep "version" |cut -d '"' -f 4`
releaseBU=`echo $tagnameBU |cut -d ' ' -f 1`

sed -i -e "s|127.0.0.1|172.51.64.139|g" /var/lib/jenkins/workspace/go-auth-uat/src/environments/environment.ts
sed -i -e "s|%release%|${releaseBU}|g" /var/lib/jenkins/workspace/go-auth-uat/src/environments/environment.ts
#debug
cat /var/lib/jenkins/workspace/go-auth-uat/src/environments/environment.ts

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=UAT Build Code ${releaseBU} OK" https://notify-api.line.me/api/notify