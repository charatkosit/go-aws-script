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
tokenLineJF=K35RgggwSNxmv2UGVT5mGmO5wAwCAuFQuNodqLh5gCG
#Jenkins-Back:
tokenLineJB=ImU3zoEwmB44IwAtpeoqPZihzoLld0xUVeSiy1tD1tz

cat >> ~/.bashrc << EOF
export tokenLineJF=K35RgggwSNxmv2UGVT5mGmO5wAwCAuFQuNodqLh5gCG
export tokenLineJB=ImU3zoEwmB44IwAtpeoqPZihzoLld0xUVeSiy1tD1tz
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
rm -rf new-installl-jenkins.sh

curl -X POST -H "Authorization: Bearer ${tokenLineJF}" -F "message= pass jenkins ${jenkinsPass} ok" https://notify-api.line.me/api/notify
curl -X POST -H "Authorization: Bearer ${tokenLineJB}" -F "message= Back ok" https://notify-api.line.me/api/notify