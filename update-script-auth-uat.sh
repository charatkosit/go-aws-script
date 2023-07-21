!#/bin/bash
# use for update  
# 
# deploy-auth-uat.sh
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

cp /home/ec2-user/temp/aws-auth-uat/script/*.* /home/ec2-user/script/
cp /home/ec2-user/temp/aws-auth-uat/Initial/*.* /home/ec2-user/Initial/

#chmod
chmod +x /home/ec2-user/script/*.*
chmod +x /home/ec2-user/Initial/*.*


#remove temp
rm -rf temp



# ls
ls -l
ls -l script
