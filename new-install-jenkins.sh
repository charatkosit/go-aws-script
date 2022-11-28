#!/bin/bash
# new install 
#date
ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
date

#install docker
yum update -y
amazon-linux-extras install docker -y
yum install docker -y
service docker start
systemctl enable --now docker
systemctl is-enabled docker
docker images
chmod 777 /var/run/docker.sock

#install docker compose
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose version

#env
#Jenkins-Front:
tokenLineF=KU7zIs892MzQrur12rZSsEQCxGyDtHFEWDQiyir87zv
#Jenkins-Back:
tokenLineB=jK01GQRfcbCkrExb8euztYLqB1WpDgMhIIR1pah5OCH

cat >> ~/.bashrc << EOF
export tokenLineF=KU7zIs892MzQrur12rZSsEQCxGyDtHFEWDQiyir87zv
export tokenLineB=jK01GQRfcbCkrExb8euztYLqB1WpDgMhIIR1pah5OCH
EOF

#jenkins
yum update -y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade
amazon-linux-extras install java-openjdk11 -y
yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins
jenkinsPass=`cat /var/lib/jenkins/secrets/initialAdminPassword`

#portainer
mkdir /opt/portainer_data
docker pull portainer/portainer
docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer_data:/data portainer/portainer

#copy
cp /home/ec2-user/temp/update-aws-jenkins.sh /home/ec2-user

mkdir /home/ec2-user/script
mkdir /home/ec2-user/script/front
mkdir /home/ec2-user/script/back

cp /home/ec2-user/temp/aws-jenkins/front/*.* /home/ec2-user/script/front
cp /home/ec2-user/temp/aws-jenkins/back/*.* /home/ec2-user/script/back
chmod +x /home/ec2-user/script/front/*.*
chmod +x /home/ec2-user/script/back/*.*
chmod +x /home/ec2-user/update-aws-jenkins.sh

rm -rf temp
rm -rf new-install-jenkins.sh

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message= pass jenkins ${jenkinsPass} ok" https://notify-api.line.me/api/notify
curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message= Back ok" https://notify-api.line.me/api/notify