!#/bin/bash
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

#copy /data to rest
mkdir data
cp /home/ec2-user/docker-mysql-pma/data/*.*  /home/ec2-user/data
#remove 
rm -rf docker-mysql-pma
rm -rf script

#make dir
mkdir script
mkdir docker-mysql-pma
mkdir docker-mysql-pma/data

#/data to /docker-mysql-pwa
cp /home/ec2-user/data/*.* /home/ec2-user/docker-mysql-pma/data
rm -rf /home/ec2-user/data

#copy new
cp /home/ec2-user/temp/aws-back-sit/script/*.* /home/ec2-user/script/
cp /home/ec2-user/temp/aws-back-sit/docker-mysql-pma/*.* /home/ec2-user/docker-mysql-pma/
#chmod
chmod +x /home/ec2-user/script/*.*
chmod +x /home/ec2-user/docker-mysql-pma/*.*
#remove temp
rm -rf temp

# ls
ls -l
ls -l script
ls -l docker-mysql-pma

