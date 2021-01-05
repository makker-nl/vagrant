#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
MSHFT_HOME=/app/redhat/minishift
#
# From https://www.redhat.com/sysadmin/learn-openshift-minishift
# And https://docs.okd.io/3.11/minishift/getting-started/setting-up-virtualization-environment.html#setting-up-kvm-driver
#
echo Install MiniShift
echo . Install QEmu-kvm and libvirt 
sudo yum -y -q install libvirt  qemu-kvm* 
echo . Enable lib-virt
sudo systemctl enable --now libvirtd
echo . Check Libvirt group:
grep libvirt /etc/group
echo Add libvirt group to current user and logon withit
sudo usermod -a -G libvirt $(whoami)
newgrp - libvirt
groups
# 
echo . Install docker-machine-linux
#sudo curl --location \
#https://github.com/docker/machine/releases/download/v0.16.1/docker-machine-Linux-`uname -i` > \
#/usr/local/bin/docker-machine
sudo curl -L https://github.com/docker/machine/releases/download/v0.16.1/docker-machine-Linux-`uname -i` -o /usr/local/bin/docker-machine
sudo chmod +x /usr/local/bin/docker-machine
#
echo . Install docker machine kvm driver
sudo curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-centos7 -o /usr/local/bin/docker-machine-driver-kvm
sudo chmod +x /usr/local/bin/docker-machine-driver-kvm
#
echo . Get MiniShift
mkdir -p /app/redhat/minishift
mkdir -p ~/bin
wget -qO- \
https://github.com/minishift/minishift/releases/download/v1.34.0/minishift-1.34.0-linux-amd64.tgz \
| tar --extract --gzip --verbose -C $MSHFT_HOME
echo . Make link minishift
ln -s \
$MSHFT_HOME/minishift-1.34.0-linux-amd64/minishift \
~/bin/minishift