#!/bin/bash

cd ..
git clone https://github.com/charatkosit/go-aws-script.git temp


#remove
rm -rf /home/ec2-user/update-script-back-pg-prod.sh

#copy
cp /home/ec2-user/temp/update-script-back-pg-prod.sh  /home/ec2-user/

#
chmod +x /home/ec2-user/update-script-back-pg-prod.sh

#clear temp
rm -rf temp
