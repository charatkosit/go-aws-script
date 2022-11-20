!#/bin/bash
git clone https://github.com/charatkosit/go-jenkins.git temp 

#remove 
rm -rf docker-mysql-pma
rm -rf script

#make dir
mkdir script
mkdir docker-mysql-pma

#copy new
cp /home/ec2-user/temp/all-script/aws-back-sit/script/*.* /home/ec2-user/script/
cp /home/ec2-user/temp/all-script/aws-back-sit/docker-mysql-pma/*.* /home/ec2-user/docker-mysql-pma/
#chmod
chmod +x /home/ec2-user/script/*.*
chmod +x /home/ec2-user/docker-mysql-pma/*.*
#remove temp
rm -rf temp

# ls
ls -l
ls -l script
ls -l docker-mysql-pma

