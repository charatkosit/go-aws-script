#!/bin/bash

cd /home/ec2-user/
git clone https://github.com/charatkosit/go-aws-script.git temp
cp /home/ec2-user/temp/aws-auth-uat/docker-mysql-pma/*.yml /home/ec2-user/docker-mysql-pma/

#remove temp
cd /home/ec2-user/
rm -rf temp
cd /home/ec2-user/script/