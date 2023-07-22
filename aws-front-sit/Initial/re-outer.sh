!#/bin/bash

git clone https://github.com/charatkosit/go-aws-script.git temp


#remove
rm -rf /home/ec2-user/update-script-front-sit.sh

#copy
cp /home/ec2-user/temp/update-script-front-sit.sh  /home/ec2-user/

#
chmod +x /home/ec2-user/update-script-front-sit.sh

#clear temp
rm -rf temp
