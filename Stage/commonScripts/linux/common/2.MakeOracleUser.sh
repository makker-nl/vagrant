#!/bin/bash
#
# Script to create a OS group and user
# The script is using the file /media/sf_Stage/commonScripts/linux/common/makeOracleUser.properties to read the properties you can set, such as the password
#
SCRIPTPATH=$(dirname $0)
#SCRIPTPATH=/media/sf_Stage/commonScripts/linux/common

ENV=${1:-dev}

function prop {
    grep "${1}" $SCRIPTPATH/makeOracleUser.properties|cut -d'=' -f2
}

# As we are using the database as well, we need a group named dba
echo Creating group dba
sudo /usr/sbin/groupadd -g 2001 dba

# We also need a group named oinstall as Oracle Inventory group
echo create group oinstall
sudo /usr/sbin/groupadd -g 2000 oinstall

#
# Create the Oracle user
echo Create the oracle user
sudo /usr/sbin/useradd -u 2000 -g oinstall -G dba oracle
echo Setting the oracle password to...
sudo sh -c "echo $(prop 'oracle.password') |passwd oracle --stdin"

#
# Add Oracle to sudoers so he can perform admin tasks
echo Adding oracle user to sudo-ers.
sudo sh -c "echo 'oracle           ALL=NOPASSWD:        ALL' >> /etc/sudoers"
#
# Create oraInst.loc and grant to Oracle
echo Create oraInventory folder
sudo chown -R oracle:oinstall /app
sudo mkdir -p /app/oracle/oraInventory
sudo chown -R oracle:oinstall /app/oracle
echo Create oraInst.loc and grant to Oracle
sudo sh -c "echo \"inventory_loc=/app/oracle/oraInventory\" > /etc/oraInst.loc"
#sudo sh -c "echo \"\" > /etc/oraInst.loc"
sudo sh -c "echo \"inst_group=oinstall\" >> /etc/oraInst.loc"
sudo chown oracle:oinstall /etc/oraInst.loc
sudo mkdir -p /app/opensource
sudo chown -R oracle:oinstall /app/opensource
