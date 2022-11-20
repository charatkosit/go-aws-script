#!/bin/bash
#prepare  data
dbUrlBU='http://localhost'
portBU=3308
dbUsernameBU='rootUAT'
dbPasswordBU='1234'
dbNameBU='testhaha'
synchronizeBU=false

tagnameBU=`cat /var/lib/jenkins/workspace/go-back-uat/package.json |grep "version" |cut -d '"' -f 4`
releaseBU=`echo $tagnameBU |cut -d ' ' -f 1`


sapUrlBU='http://192.168.20.17:8880/apigoplus/EnqPartlist/'
sapApiTokenBU='z@hz3sNY#0ohB9SspeE9@fLDQ%r65x$k8LxL28VH72FfvRWgCn'
stageBU='UAT' 
timestampBU=$(date)

#replace data

sed -i -e "s|%dbUrl%|${dbUrlBU}|g" /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.prod.ts
sed -i -e "s|3308|${portBU}|g" /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.prod.ts
sed -i -e "s|%dbUsername%|${dbUsernameBU}|g" /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.prod.ts
sed -i -e "s|%dbPassword%|${dbPasswordBU}|g" /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.prod.ts
sed -i -e "s|%dbName%|${dbNameBU}|g" /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.prod.ts
#sed -i -e "s|false|${synchronizeBU}|g" /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.prod.ts
#temporary set
sed -i -e "s|false|true|g" /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.prod.ts

sed -i -e "s|%sapUrl%|${sapUrlBU}|g" /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.prod.ts
sed -i -e "s|%sapApiToken%|${sapApiTokenBU}|g" /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.prod.ts
sed -i -e "s|%stage%|${stageBU}|g" /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.prod.ts
sed -i -e "s|%timestamp%|${timestampBU}|g" /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.prod.ts
sed -i -e "s|%release%|${releaseBU}|g" /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.prod.ts
#debug
cat /var/lib/jenkins/workspace/go-back-uat/src/environments/environment.prod.ts