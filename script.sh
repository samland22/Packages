#!/bin/bash

#Auhor: Laure H
#Date: 2022-10-23
# Description: This file is to install different software/packages

echo
echo "############ Installation of httpd server ##############"
sleep 2
yum install httpd -y
if [ $? -eq 0 ]
then
echo "httpd installation successful"
else
echo "httpd intallation failed"
fi

systemctl start httpd
systemctl enable httpd
systemctl status httpd
systemctl start firewalld
firewall-cmd --add-service=http --zone=public --permanent
firewall-cmd --reload
echo
echo "############# HTTPD SUCCESSFULLY INSTALLED #############"
echo
sleep 3
echo " <<<<<<<<<<<<<<<<< Jenkins Installation >>>>>>>>>>>>>"
echo
sleep 2
yum install java-11-openjdk-devel -y
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins -y
echo
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Installation Complete >>>>>>>>>>>>>>>>>>>>>"
echo
sleep 3

echo "XXXXXXXXXXXXXXXXXXX Docker Installation XXXXXXXXXXXXXXXXXXXXXXXX"
echo
sudo yum install -y yum-utils
if [ $? -eq 0 ]
then
echo " yum utils successfully installed "
else
echo " yum utils installation failed "
fi

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo -y
yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

if [ $? -eq 0 ]
then
echo " docker successfully installed "
else
echo "docker installation failed"
fi

yum list docker-ce --showduplicates | sort -r
systemctl start docker
systemctl enable docker
systemctl status docker
echo
echo " XXXXXXXXXXXXXXXXX Docker Installation Complete XXXXXXXXXXXXXXXXXX"
sleep 3
