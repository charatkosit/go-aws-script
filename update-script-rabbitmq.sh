#!/bin/bash

rm -rf  /home/ec2-user/temp

cd /home/ec2-user
git clone https://github.com/charatkosit/go-aws-script.git temp

rm -rf /home/ec2-user/Initial
rm -rf /home/ec2-user/script

mkdir Initial
mkdir script

cp /home/ec2-user/temp/aws-rabbitmq/Initial/*.* /home/ec2-user/Initial
cp /home/ec2-user/temp/aws-rabbitmq/script/*.* /home/ec2-user/script

chmod +x /home/ec2-user/Initial/*.*
chmod +x /home/ec2-user/script/*.*

rm -rf  /home/ec2-user/temp
