#!/bin/bash
SCRIPTPATH=$(dirname $0)
# 20230104, M. van den Akker: Oracle EPEL is already in the repos.
# 20230924, M. van den Akker: Check if there is a repo file that contains the OL8 EPEL
EPEL=`sudo grep -i -r --include="*.repo" "/OracleLinux/OL8/developer/EPEL/" /etc/yum.repos.d |wc|awk '{print $1}'`
if [ $EPEL -gt 0 ]
then 
  echo OL8 developer EPEL repository already added.
else
# https://techviewleo.com/how-to-enable-epel-repository-on-oracle-linux/
  echo First add OL8 developer EPEL repository
  sudo cp $SCRIPTPATH/ol8-epel.repo /etc/yum.repos.d
  sudo chmod -x /etc/yum.repos.d/ol8-epel.repo
fi
#
echo Installing packages required by the software
sudo dnf -y upgrade
sudo dnf -y install  libstdc* gcc-c++* ksh libaio-devel* dos2unix system-storage-manager
#
# Install Haveged
sudo dnf makecache
echo Install Haveged
sudo dnf -q -y install haveged
#
echo 'Adding entries into /etc/security/limits.conf for oracle user'
if grep -Fq oracle /etc/security/limits.conf
then
    echo 'WARNING: Skipping, please verify!'
else
    echo 'Adding'
    sudo sh -c "sed -i '/End of file/i # Oracle account settings\noracle soft core unlimited\noracle hard core unlimited\noracle soft data unlimited\noracle hard data unlimited\noracle soft memlock 3500000\noracle hard memlock 3500000\noracle soft nofile 1048576\noracle hard nofile 1048576\noracle soft rss unlimited\noracle hard rss unlimited\noracle soft stack unlimited\noracle hard stack unlimited\noracle soft cpu unlimited\noracle hard cpu unlimited\noracle soft nproc unlimited\noracle hard nproc unlimited\n' /etc/security/limits.conf"
fi

# 20230303, M. van den Akker: his should be moved to the installation of Oracle Database.
# echo 'Changing /etc/sysctl.conf'
# if grep -Fq net.core.rmem_max /etc/sysctl.conf
# then
    # echo 'WARNING: Skipping, please verify!'
# else
    # echo 'Adding'
    # sudo sh -c "echo '
# #ORACLE
# fs.aio-max-nr = 1048576
# fs.file-max = 6815744
# kernel.shmall = 2097152
# kernel.shmmax = 4294967295
# kernel.shmmni = 4096
# kernel.sem = 250 32000 100 128
# net.ipv4.ip_local_port_range = 9000 65500
# net.core.rmem_default = 262144
# net.core.rmem_max = 4194304
# net.core.wmem_default = 262144
# net.core.wmem_max = 4194304
# '>>/etc/sysctl.conf"
# /sbin/sysctl -p
# fi

echo 'Allow PasswordAuthhentication'
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.org
sudo sed -i 's/PasswordAuthentication no/#PasswordAuthentication no/g' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo service sshd restart