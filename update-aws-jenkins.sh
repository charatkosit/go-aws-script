#!/bin/bash
git clone https://github.com/charatkosit/go-aws-script.git temp

chmod 666 /var/run/docker.sock
#remove
rm -rf script


#mkdir
mkdir script
cd script
mkdir front
mkdir back
mkdir auth
mkdir epc
mkdir click-front
mkdir click-back
cd ..

#copy
cp /home/ec2-user/temp/aws-jenkins/front/*.* /home/ec2-user/script/front/
cp /home/ec2-user/temp/aws-jenkins/back/*.* /home/ec2-user/script/back/
cp /home/ec2-user/temp/aws-jenkins/auth/*.* /home/ec2-user/script/auth/
cp /home/ec2-user/temp/aws-jenkins/epc/*.* /home/ec2-user/script/epc/
cp /home/ec2-user/temp/aws-jenkins/click-front/*.* /home/ec2-user/script/click-front/
cp /home/ec2-user/temp/aws-jenkins/click-back/*.* /home/ec2-user/script/click-back/
#cp /home/ec2-user/temp/update-aws-jenkins.sh /home/ec2-user/

#chmod
chmod +x /home/ec2-user/script/front/*.*
chmod +x /home/ec2-user/script/back/*.*
chmod +x /home/ec2-user/script/auth/*.*
chmod +x /home/ec2-user/script/epc/*.*
chmod +x /home/ec2-user/script/click-front/*.*
chmod +x /home/ec2-user/script/click-back/*.*
chmod +x /home/ec2-user/*.*

#clean
rm -rf temp

#list 
ls -la
ls /home/ec2-user/script/ -la
ls /home/ec2-user/script/front -la
ls /home/ec2-user/script/back -la
ls /home/ec2-user/script/auth -la
ls /home/ec2-user/script/epc -la
ls /home/ec2-user/script/click-front -la
ls /home/ec2-user/script/click-back -la
