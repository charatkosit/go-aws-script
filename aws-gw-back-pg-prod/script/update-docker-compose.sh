#!/bin/bash

cd /home/ec2-user/
git clone https://github.com/charatkosit/go-aws-script.git temp
cp /home/ec2-user/temp/aws-gw-back-pg-prod/docker-postgresql/*.yml /home/ec2-user/docker-postgresql/

#remove temp
cd /home/ec2-user/
rm -rf temp
cd /home/ec2-user/script/