#!/bin/bash

#สตาร์ท mysql
cd /home/ec2-user/docker-mysql-pma
docker-compose up -d
cd /home/ec2-user/

#สตาร์ท go-auth-uat
cd /home/ec2-user/script
docker run -p 3100:3100 -d charat/go-auth-uat:latest


