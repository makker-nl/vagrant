#!/bin/bash
#
# 2023-01-11, taken from https://www.atlantic.net/vps-hosting/how-to-install-ansible-on-oracle-linux-8/
# 
# 
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
CD=$(pwd)
ANSIBLE_HOSTS=hosts
ANSIBLE_PATH=/etc/ansible
ANSIBLE_CFG=/etc/ansible/ansible.cfg
HOSTS_TPL=hosts.tpl
export HOST_IP=$(hostname)
echo Install Ansible
sudo dnf -yq install ansible
ansible --version
echo Generated RSA key
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
cat ~/.ssh/id_rsa.pub>>~/.ssh/authorized_keys
echo Copy Ansible hosts
envsubst < $SCRIPTPATH/$HOSTS_TPL > $SCRIPTPATH/$ANSIBLE_HOSTS
sudo mkdir -p $ANSIBLE_PATH
sudo mv $SCRIPTPATH/$ANSIBLE_HOSTS $ANSIBLE_PATH
echo Add "host_key_checking = False" to $ANSIBLE_CFG
sudo sed -ie '/^\[defaults\]/a host_key_checking = False' $ANSIBLE_CFG
echo Add "deprecation_warnings=False" to $ANSIBLE_CFG
sudo sed -ie '/^\[defaults\]/a deprecation_warnings=False' $ANSIBLE_CFG
