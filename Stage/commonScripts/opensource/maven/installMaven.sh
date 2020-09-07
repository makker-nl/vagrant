#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
echo Install Apache Maven
#sudo dnf -q -y install apache-maven
sudo dnf -y install maven