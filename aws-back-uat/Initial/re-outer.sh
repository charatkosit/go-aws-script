!#/bin/bash

git clone https://github.com/charatkosit/go-aws-script.git temp


#remove
rm -rf /home/ec2-user/update-script-back-uat.sh

#copy
cp /home/ec2-user/temp/update-script-back-uat.sh  /home/ec2-user/script/

#
chmod +x /home/ec2-user/update-script-back-uat.sh

#clear temp
rm -rf temp
