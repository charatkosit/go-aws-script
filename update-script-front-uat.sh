#!/bin/bash
git clone https://github.com/charatkosit/go-aws-script.git temp 

#remove 
rm -rf script

#make dir
mkdir script
mkdir docker-compose

#copy new
cp /home/ec2-user/temp/aws-front-uat/script/*.* /home/ec2-user/script/
cp /home/ec2-user/temp/aws-front-uat/Initial/*.* /home/ec2-user/Initial/


#chmod
chmod +x /home/ec2-user/script/*.*


#remove temp
rm -rf temp

# ls
ls -l
ls -l script
