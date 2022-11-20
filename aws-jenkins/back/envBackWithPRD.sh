#!/bin/bash
#prepare  data
dbUrlBP='http://localhost'
portBP=3308
dbUsernameBP='rootPROD'
dbPasswordBP='1234'
dbNameBP='testhaha'
synchronizeBP=false

tagnameBP=`cat /var/lib/jenkins/workspace/go-back-prod/package.json |grep "version" |cut -d '"' -f 4`
releaseBP=`echo $tagnameBP |cut -d ' ' -f 1`

sapUrlBP='http://192.168.20.17:8880/apigoplus/EnqPartlist/'
sapApiTokenBP='z@hz3sNY#0ohB9SspeE9@fLDQ%r65x$k8LxL28VH72FfvRWgCn'
stageBP='PROD' 
timestampBP=$(date)

#replace data

sed -i -e "s|%dbUrl%|${dbUrlBP}|g" /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.prod.ts
sed -i -e "s|3308|${portBP}|g" /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.prod.ts
sed -i -e "s|%dbUsername%|${dbUsernameBP}|g" /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.prod.ts
sed -i -e "s|%dbPassword%|${dbPasswordBP}|g" /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.prod.ts
sed -i -e "s|%dbName%|${dbNameBP}|g" /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.prod.ts
#sed -i -e "s|false|${synchronizeBP}|g" /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.prod.ts
#temporary set
sed -i -e "s|false|true|g" /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.prod.ts


sed -i -e "s|%sapUrl%|${sapUrlBP}|g" /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.prod.ts
sed -i -e "s|%sapApiToken%|${sapApiTokenBP}|g" /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.prod.ts
sed -i -e "s|%stage%|${stageBP}|g" /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.prod.ts
sed -i -e "s|%timestamp%|${timestampBP}|g" /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.prod.ts
sed -i -e "s|%release%|${releaseBP}|g" /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.prod.ts
#debug
cat /var/lib/jenkins/workspace/go-back-prod/src/environments/environment.prod.ts