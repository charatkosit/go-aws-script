!#/bin/bash
git clone https://github.com/charatkosit/go-jenkins.git temp 

#remove 
rm -rf script

#make dir
mkdir script

#copy new
cp /home/ec2-user/temp/all-script/aws-front-uat/script/*.* /home/ec2-user/script/

#chmod
chmod +x /home/ec2-user/script/*.*

#remove temp
rm -rf temp

# ls
ls -l
ls -l script