#!/bin/bash
#-------
#cd /var/lib/jenkins/workspace/go-epc-sit/src/environments/
#rm -rf environment.ts
#cp environment.sit.ts environment.ts
#cd /home/ec2-user
#-------

tagnameBS=`cat /var/lib/jenkins/workspace/go-epc-sit/package.json |grep "version" |cut -d '"' -f 4`
releaseBS=`echo $tagnameBS |cut -d ' ' -f 1`

# 172.51.67.211 is Go.Epc.SIT
sed -i -e "s|13.214.25.107|13.214.25.107|g" /var/lib/jenkins/workspace/go-epc-sit/src/environments/environment.ts
sed -i -e "s|Go-Epc-Dev|${releaseBS}|g" /var/lib/jenkins/workspace/go-epc-sit/src/environments/environment.ts
#debug
cat /var/lib/jenkins/workspace/go-epc-sit/src/environments/environment.ts

curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message=SIT prepare Code ${releaseBS} OK" https://notify-api.line.me/api/notify