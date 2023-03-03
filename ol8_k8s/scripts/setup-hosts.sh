#!/bin/bash
# Taken from https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/ubuntu/vagrant/setup-hosts.sh
echo Set up hosts file
set -e
IFNAME=$1
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

# remove ubuntu-bionic entry
#sed -e '/^.*ubuntu-bionic.*/d' -i /etc/hosts

# Update /etc/hosts about other hosts
cat >> /etc/hosts <<EOF
192.168.56.11  kubemaster-1
192.168.56.12  kubemaster-2
192.168.56.21  kubeworker-1
192.168.56.22  kubeworker-2
192.168.56.30  lb
EOF