#!/bin/bash
# use for update  
# 
# deploy-auth-prod.sh
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

cp /home/ec2-user/temp/aws-auth-prod/script/*.* /home/ec2-user/script/
cp /home/ec2-user/temp/aws-auth-prod/Initial/*.* /home/ec2-user/Initial/
cp /home/ec2-user/temp/aws-auth-prod/docker-mysql-pma/*.* /home/ec2-user/docker-mysql-pma/

#chmod
chmod +x /home/ec2-user/script/*.*

#remove temp
rm -rf temp



# ls
ls -l
ls -l script
