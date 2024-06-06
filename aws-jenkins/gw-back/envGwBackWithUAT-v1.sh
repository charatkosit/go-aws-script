#!/bin/bash
#------
# cd /var/lib/jenkins/workspace/gw-back-uat/src/environments/
# rm -rf environment.ts
# cp environment.uat.ts environment.ts
# cd /home/ec2-user
#------

tagnameBU=`cat /var/lib/jenkins/workspace/gw-back-uat/package.json |grep "version" |cut -d '"' -f 4`
releaseBU=`echo $tagnameBU |cut -d ' ' -f 1`

#172.41.62.164  is localhost  Go.Back.UAT (back+db)
sed -i -e "s|127.0.0.1|172.51.69.242|g" /var/lib/jenkins/workspace/gw-back-uat/src/environments/environment.ts
sed -i -e "s|Back-Dev|${releaseBU}|g" /var/lib/jenkins/workspace/gw-back-uat/src/environments/environment.ts
#debug
cat /var/lib/jenkins/workspace/gw-back-uat/src/environments/environment.ts

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=UAT Build Code ${releaseBU} OK" https://notify-api.line.me/api/notify