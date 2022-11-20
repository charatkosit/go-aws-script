#!/bin/bash
cd /var/lib/jenkins/workspace/go-back-prod/src/environments/
rm -rf environment.ts
cp environment.prod.ts environment.ts
cd /home/ec2-user

tagnameBP=`cat /var/lib/jenkins/workspace/go-back-prod/package.json |grep "version" |cut -d '"' -f 4`
releaseBP=`echo $tagnameBP |cut -d ' ' -f 1`

sed -i -e "s|%release%|${releaseBP}|g" /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.ts
#debug
cat /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.ts