!#/bin/bash
# use for update  
# docker-compose.yml
# and  deploy-back-uat.sh
git clone https://github.com/charatkosit/go-aws-script.git temp 

#stop docker-mysql-pma
cd /home/ec2-user/docker-mysql-pma/
docker-compose down --rmi all
cd /home/ec2-user/

#update LineToken 
#AWS-Front:
tokenLineAF=K35RgggwSNxmv2UGVT5mGmO5wAwCAuFQuNodqLh5gCG
#AWS-Back:
tokenLineAB=ImU3zoEwmB44IwAtpeoqPZihzoLld0xUVeSiy1tD1tz

cat >> ~/.bashrc << EOF
export tokenLineAF=K35RgggwSNxmv2UGVT5mGmO5wAwCAuFQuNodqLh5gCG
export tokenLineAB=ImU3zoEwmB44IwAtpeoqPZihzoLld0xUVeSiy1tD1tz
EOF

#backup /data
#cp -R /home/ec2-user/docker-mysql-pma/data /home/ec2-user/data_backup

#remove 
rm -rf /home/ec2-user/docker-mysql-pma/docker-compose.yml
rm -rf script

#make dir
mkdir script
mkdir docker-mysql-pma
mkdir docker-mysql-pma/mysql-data

#restore /data to /docker-mysql-pwa
cp -R /home/ec2-user/data_backup /home/ec2-user/docker-mysql-pma/mysql-data
rm -rf /home/ec2-user/data_backup

#copy new
cp /home/ec2-user/temp/aws-auth-uat/script/*.* /home/ec2-user/script/
cp /home/ec2-user/temp/aws-auth-uat/docker-mysql-pma/*.* /home/ec2-user/docker-mysql-pma/
#chmod
chmod +x /home/ec2-user/script/*.*
chmod +x /home/ec2-user/docker-mysql-pma/*.*
#remove temp
rm -rf temp

#run mysql-pma
cd /home/ec2-user/docker-mysql-pma/
docker-compose up -d
cd /home/ec2-user

# ls
ls -l
ls -l script
ls -l docker-mysql-pma