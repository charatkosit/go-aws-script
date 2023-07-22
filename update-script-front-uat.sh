!#/bin/bash
git clone https://github.com/charatkosit/go-aws-script.git temp 

#remove 
rm -rf script

#make dir
mkdir script
mkdir docker-compose

#copy new
cp /home/ec2-user/temp/aws-rabbitmq/script/*.* /home/ec2-user/script/
cp /home/ec2-user/temp/aws-rabbitmq/*.* /home/ec2-user/docker-compose/


#chmod
chmod +x /home/ec2-user/script/*.*


#remove temp
rm -rf temp

# ls
ls -l
ls -l script