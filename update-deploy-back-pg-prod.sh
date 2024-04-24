#!/bin/bash
git clone https://github.com/charatkosit/go-aws-script.git temp 

cp /home/ec2-user/temp/aws-back-pg-prod/script/deploy-back-pg-prod.sh  /home/ec2-user/script/

rm -rf /home/ec2-user/temp

