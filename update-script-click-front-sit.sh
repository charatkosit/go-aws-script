#!/bin/bash
git clone https://github.com/charatkosit/go-aws-script.git temp 

#remove 
rm -rf script

#make dir
mkdir script

#copy new
cp /home/ec2-user/temp/aws-click-front-sit/script/*.* /home/ec2-user/script/

#chmod
chmod +x /home/ec2-user/script/*.*

#remove temp
rm -rf temp

# ls
ls -l
ls -l script