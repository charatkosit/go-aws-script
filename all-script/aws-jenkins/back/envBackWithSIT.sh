#!/bin/bash
#prepare  data
dbUrlBS='http://localhost'
portBS=3308
dbUsernameBS='rootSIT'
dbPasswordBS='1234'
dbNameBS='testhaha'
synchronizeBS=false

tagnameBS=`cat /var/lib/jenkins/workspace/go-back-sit/package.json |grep "version" |cut -d '"' -f 4`
releaseBS=`echo $tagnameBS |cut -d ' ' -f 1`


sapUrlBS='http://192.168.20.17:8880/apigoplus/EnqPartlist/'
sapApiTokenBS='z@hz3sNY#0ohB9SspeE9@fLDQ%r65x$k8LxL28VH72FfvRWgCn'
stageBS='SIT' 
timestampBS=$(date)

#replace data

sed -i -e "s|%dbUrl%|${dbUrlBS}|g" /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.prod.ts
sed -i -e "s|3308|${portBS}|g" /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.prod.ts
sed -i -e "s|%dbUsername%|${dbUsernameBS}|g" /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.prod.ts
sed -i -e "s|%dbPassword%|${dbPasswordBS}|g" /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.prod.ts
sed -i -e "s|%dbName%|${dbNameBS}|g" /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.prod.ts
#sed -i -e "s|false|${synchronizeBS}|g" /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.prod.ts
#temporary set
sed -i -e "s|false|true|g" /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.prod.ts

sed -i -e "s|%sapUrl%|${sapUrlBS}|g" /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.prod.ts
sed -i -e "s|%sapApiToken%|${sapApiTokenBS}|g" /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.prod.ts
sed -i -e "s|%stage%|${stageBS}|g" /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.prod.ts
sed -i -e "s|%timestamp%|${timestampBS}|g" /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.prod.ts
sed -i -e "s|%release%|${releaseBS}|g" /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.prod.ts
#debug
cat /var/lib/jenkins/workspace/go-back-sit/src/environments/environment.prod.ts