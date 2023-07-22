#!/bin/bash
rm -rf  /home/ec2-user/temp
rm -rf /home/ec2-user/docker-rabbitmq

git clone https://github.com/charatkosit/go-aws-script.git temp

mkdir /home/ec2-user/docker-rabbitmq

cp /home/ec2-user/temp/aws-rabbitmq/docker-compose.yml /home/ec2-user/docker-rabbitmq

