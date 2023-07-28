#!/bin/bash

cd /home/ec2-user/

git clone https://github.com/charatkosit/go-aws-script.git temp


#remove
rm -rf /home/ec2-user/update-script-rabbitmq.sh

#copy
cp /home/ec2-user/temp/update-script-rabbitmq.sh  /home/ec2-user/

#
chmod +x /home/ec2-user/update-script-rabbitmq.sh

#clear temp
rm -rf temp

cd /home/ec2-user
