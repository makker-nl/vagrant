# vagrant

Uprgade to OL 7.7
After Fresh Install OL7.7 Server with GUI:
. sudo yum install kernel-header kernel-devel
. yum search kernel
. yum install kernel-headers.x86_64
. yum install kernel-devel.x86_64
. yum install kernel-headers-$(uname -r) kernel-devel-$(uname -r) --> pacakges not found!
. yum install build-essential gcc make perl dkms
. yum -y install kernel-uek-devel
. yum -y install kernel-uek-headers -> package not found!
. yum repolist
. yum-config-manager --enable ol7_addons
. yum repolist
. yum upgrade
