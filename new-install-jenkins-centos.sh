#!/bin/bash
# new install 
#date
ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
date

#ติดตั้ง Docker
dnf update -y
dnf install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf install docker-ce docker-ce-cli containerd.io -y
systemctl start docker
systemctl enable docker
docker --version
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
dnf install java-11-openjdk -y

sudo tee /etc/yum.repos.d/jenkins.repo<<EOF
[jenkins]
name=Jenkins-stable
baseurl=https://pkg.jenkins.io/redhat-stable/
gpgcheck=1
EOF
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key


dnf install jenkins -y
systemctl enable jenkins
systemctl start jenkins
systemctl status jenkins

jenkinsPass=`cat /var/lib/jenkins/secrets/initialAdminPassword`

#firewall
firewall-cmd --permanent --zone=public --add-port=8080/tcp
firewall-cmd --reload

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

chown -R jenkins:jenkins /home/charat/script/
chmod -R +x /home/charat/script/
chown -R jenkins:jenkins /var/lib/jenkins/.docker
chmod -R 755 /var/lib/jenkins/.docker
chmod +x /var/lib/jenkins/
chmod +x /var/lib/

chmod 666 /var/run/docker.sock

rm -rf temp
rm -rf new-install-jenkins-centos.sh

curl -X POST -H "Authorization: Bearer ${tokenLineF}" -F "message= pass jenkins ${jenkinsPass} ok" https://notify-api.line.me/api/notify
curl -X POST -H "Authorization: Bearer ${tokenLineB}" -F "message= Back ok" https://notify-api.line.me/api/notify

sudo bash
chmod 775 .