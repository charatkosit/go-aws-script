#!/bin/bash
cd /var/lib/jenkins/workspace/go-back-uat/src/environments/
rm -rf environment.ts
cp environment.uat.ts environment.ts
cd /home/ec2-user

tagnameBU=`cat /var/lib/jenkins/workspace/go-back-uat/package.json |grep "version" |cut -d '"' -f 4`
releaseBU=`echo $tagnameBU |cut -d ' ' -f 1`

sed -i -e "s|%release%|${releaseBU}|g" /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.ts
#debug
cat /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.ts