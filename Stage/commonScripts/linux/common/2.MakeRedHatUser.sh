#!/bin/bash
#
# Script to create a OS group and user
# The script is using the file /home/root/redhat.properties to read the properties you can set, such as the password
#
SCRIPTPATH=$(dirname $0)

ENV=${1:-dev}

function prop {
    grep "${1}" $SCRIPTPATH/makeRedHatUser.properties|cut -d'=' -f2
}
#
# Create the redhat user
echo Create the redhat user
sudo /usr/sbin/useradd -u 2002 redhat
echo Setting the redhat password to...
sudo sh -c "echo $(prop 'redhat.password') |passwd redhat --stdin"
sudo chown redhat:redhat /app
#
# Add redhat to sudoers so he can perform admin tasks
echo Adding redhat user to sudo-ers.
sudo sh -c "echo 'redhat           ALL=NOPASSWD:        ALL' >> /etc/sudoers"
sudo chown -R redhat:redhat /app
sudo mkdir -p /app/oracle
sudo chown -R redhat:redhat /app/oracle
sudo mkdir -p /app/opensource
sudo chown -R redhat:redhat /app/opensource
sudo mkdir -p /app/redhat
sudo chown -R redhat:redhat /app/redhat