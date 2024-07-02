#!/bin/bash
# new install 
#date
ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
date

#install docker
yum update -y
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
# tokenLineF=KU7zIs892MzQrur12rZSsEQCxGyDtHFEWDQiyir87zv
# new token add to Jenkins-Front-Deploy 19/12/65
tokenLinkF=UkdkuBI1jgYBARUR6his0S4B3OjmN89t1KuvdUNxj5S
#Jenkins-Back:
# tokenLineB=jK01GQRfcbCkrExb8euztYLqB1WpDgMhIIR1pah5OCH
# new token add to Jenkins-Back-Deploy 19/12/65
tokenLinkF=iS17GPyH2nREJzOvnqmzVM5rsLGRPnGiBwiuvTNSv6b
#
export tokenLineDeployGroup=nS2OKcPZ9lXNb03JHJ7xzl4YNDBdzswkTg1qK8iNDQD

cat >> ~/.bashrc << EOF
export tokenLineF=KU7zIs892MzQrur12rZSsEQCxGyDtHFEWDQiyir87zv
export tokenLineB=jK01GQRfcbCkrExb8euztYLqB1WpDgMhIIR1pah5OCH
export tokenLineDeployGroup=nS2OKcPZ9lXNb03JHJ7xzl4YNDBdzswkTg1qK8iNDQD
EOF

#jenkins
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum upgrade

yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins
jenkinsPass=`cat /var/lib/jenkins/secrets/initialAdminPassword`

#portainer
# mkdir /opt/portainer_data
# docker pull portainer/portainer
# docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer_data:/data portainer/portainer

#copy
cp /home/charat/temp/update-aws-jenkins-centos.sh /home/charat 
cp /home/charat/temp/runfirst.sh /home/charat

mkdir /home/charat/script
mkdir /home/charat/script/front
mkdir /home/charat/script/back
mkdir /home/charat/script/auth

cp /home/charat/temp/aws-jenkins/front/*.* /home/charat/script/front
cp /home/charat/temp/aws-jenkins/back/*.* /home/charat/script/back
cp /home/charat/temp/aws-jenkins/auth/*.* /home/charat/script/auth
chmod +x /home/charat/script/front/*.*
chmod +x /home/charat/script/back/*.*
chmod +x /home/charat/script/auth/*.*
chmod +x /home/charat/update-aws-jenkins-centos.sh
chmod +x /home/charat/runfirst.sh

rm -rf temp
rm -rf new-install-jenkins-centos.sh

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message= pass jenkins ${jenkinsPass} ok" https://notify-api.line.me/api/notify
curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message= Back ok" https://notify-api.line.me/api/notify

sudo bash
chmod 775 .