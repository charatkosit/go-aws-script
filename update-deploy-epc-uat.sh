#!/bin/bash
git clone https://github.com/charatkosit/go-aws-script.git temp 

cp /home/ec2-user/temp/aws-epc-uat/script/deploy-epc-uat.sh  /home/ec2-user/script/

rm -rf /home/ec2-user/temp

