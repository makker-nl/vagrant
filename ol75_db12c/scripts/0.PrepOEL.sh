#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
echo Installing packages required by the software
sudo yum -q -y install compat-libcap1* compat-libstdc* libstdc* gcc-c++* ksh libaio-devel* dos2unix system-storage-manager
echo install Haveged from OL7 developer EPEL repository
sudo yum-config-manager --enable ol7_developer_EPEL
sudo yum -q -y install haveged
#
echo 'Adding entries into /etc/security/limits.conf for oracle user'
if grep -Fq oracle /etc/security/limits.conf
then
    echo 'WARNING: Skipping, please verify!'
else
    echo 'Adding'
    sudo sh -c "sed -i '/End of file/i # Oracle account settings\noracle soft core unlimited\noracle hard core unlimited\noracle soft data unlimited\noracle hard data unlimited\noracle soft memlock 3500000\noracle hard memlock 3500000\noracle soft nofile 1048576\noracle hard nofile 1048576\noracle soft rss unlimited\noracle hard rss unlimited\noracle soft stack unlimited\noracle hard stack unlimited\noracle soft cpu unlimited\noracle hard cpu unlimited\noracle soft nproc unlimited\noracle hard nproc unlimited\n' /etc/security/limits.conf"
fi

echo 'Changing /etc/sysctl.conf'
if grep -Fq net.core.rmem_max /etc/sysctl.conf
then
    echo 'WARNING: Skipping, please verify!'
else
    echo 'Adding'
    sudo sh -c "echo '
#ORACLE
fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmall = 2097152
kernel.shmmax = 4294967295
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 4194304
'>>/etc/sysctl.conf"
/sbin/sysctl -p
fi
