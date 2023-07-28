#!/bin/bash
git clone https://github.com/charatkosit/go-aws-script.git temp 

#remove 
rm -rf script

#make dir
mkdir script
mkdir Initial

#copy new
cp /home/ec2-user/temp/aws-front-sit/script/*.* /home/ec2-user/script/
cp /home/ec2-user/temp/aws-front-sit/Initial/*.* /home/ec2-user/Initial/

#chmod
chmod +x /home/ec2-user/script/*.*
chmod +x /home/ec2-user/Initial/*.*

#remove temp
rm -rf temp

# ls
ls -l
ls -l script