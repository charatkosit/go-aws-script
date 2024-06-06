#!/bin/bash

git clone https://github.com/charatkosit/go-aws-script.git temp 


#update LineToken 
#AWS-Front:
tokenLineAF=K35RgggwSNxmv2UGVT5mGmO5wAwCAuFQuNodqLh5gCG
#AWS-Back:
tokenLineAB=ImU3zoEwmB44IwAtpeoqPZihzoLld0xUVeSiy1tD1tz

cat >> ~/.bashrc << EOF
export tokenLineAF=K35RgggwSNxmv2UGVT5mGmO5wAwCAuFQuNodqLh5gCG
export tokenLineAB=ImU3zoEwmB44IwAtpeoqPZihzoLld0xUVeSiy1tD1tz
EOF

#copy new
mkdir script
mkdir Initial
mkdir docker-mysql-pma

cp /home/ec2-user/temp/aws-gw-back-pg-prod/script/*.* /home/ec2-user/script/
cp /home/ec2-user/temp/aws-gw-back-pg-prod/Initial/*.* /home/ec2-user/Initial/
cp /home/ec2-user/temp/aws-gw-back-pg-prod/docker-mysql-pma/*.* /home/ec2-user/docker-postgresql/


#chmod
chmod +x /home/ec2-user/script/*.*
chmod +x /home/ec2-user/Initial/*.*


#remove temp
rm -rf temp



# ls
ls -l
ls -l script
