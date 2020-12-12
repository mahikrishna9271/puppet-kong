#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No hostname supplied"
    exit
fi
env=$1
echo $env
hostname=`hostname`
yum update -y
echo "set hostname and updated the yum"
rpm -ivh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
echo "added puppet central-repo"
yum -y install puppetserver
echo "installed puppet-server"
sed -i "s/$hostname/$env/g" /etc/hostname
echo "set hostname in /etc/hostname file"
systemctl start puppetserver
systemctl enable puppetserver
echo "start and enable puppet-server service"
firewall-cmd --add-port=8140/tcp --permanent
firewall-cmd --reload
echo "firewall rules are added"
reboot
