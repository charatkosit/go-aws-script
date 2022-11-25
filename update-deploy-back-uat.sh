!#/bin/bash
git clone https://github.com/charatkosit/go-aws-script.git temp 

cp /home/ec2-user/temp/aws-back-uat/script/deploy-back-uat.sh  /home/ec2-user/script/

rm -rf /home/ec2-user/temp

