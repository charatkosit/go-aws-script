#!/bin/bash

rm -rf temp

mkdir Initial
mkdir script
mkdir docker-compose


git clone https://github.com/charatkosit/go-aws-script.git temp

cp /home/ec2-user/temp/update-script-rabbitmq.sh /home/ec2-user/
cp /home/ec2-user/temp/aws-rabbitmq/docker-compose/*.*  /home/ec2-user/docker-compose



cd /home/ec2-user/docker-compose/
docker-compose up -d