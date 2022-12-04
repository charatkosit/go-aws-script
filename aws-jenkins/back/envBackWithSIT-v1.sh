#!/bin/bash
#-------
#cd /var/lib/jenkins/workspace/go-back-sit/src/environments/
#rm -rf environment.ts
#cp environment.sit.ts environment.ts
#cd /home/ec2-user
#-------

tagnameBS=`cat /var/lib/jenkins/workspace/go-back-sit/package.json |grep "version" |cut -d '"' -f 4`
releaseBS=`echo $tagnameBS |cut -d ' ' -f 1`

sed -i -e "s|127.0.0.1|44.212.248.132|g" /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.ts
sed -i -e "s|%release%|${releaseBS}|g" /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.ts
#debug
cat /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.ts

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=SIT prepare Code ${releaseBS} OK" https://notify-api.line.me/api/notify