#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
echo Install Red Hat Ansible
sudo yum -y install ansible