#!/bin/bash
#--------
# cd /var/lib/jenkins/workspace/go-epc-prod/src/environments/
# rm -rf environment.ts
# cp environment.prod.ts environment.ts
# cd /home/ec2-user
#--------

tagnameBP=`cat /var/lib/jenkins/workspace/go-epc-prod/package.json |grep "version" |cut -d '"' -f 4`
releaseBP=`echo $tagnameBP |cut -d ' ' -f 1`

sed -i -e "s|127.0.0.1|172.51.64.46|g" /var/lib/jenkins/workspace/go-epc-prod/src/environments/environment.ts
sed -i -e "s|Go-Epc-Dev|${releaseBP}|g" /var/lib/jenkins/workspace/go-epc-prod/src/environments/environment.ts
#debug
cat /var/lib/jenkins/workspace/go-epc-prod/src/environments/environment.ts

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=PROD prepare Code ${releaseBP} OK" https://notify-api.line.me/api/notify