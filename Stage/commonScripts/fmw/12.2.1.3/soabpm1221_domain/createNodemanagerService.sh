#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/fmw12c_env.sh
echo
echo Create Nodemanager service for: $NODEMGR_HOME
echo
echo Run As Root!!!!
export SERVICE_SCRIPT=nodemanager_admin
export INITD_LOC=/etc/init.d
sudo mv -f $NODEMGR_HOME/$SERVICE_SCRIPT $INITD_LOC
sudo chmod +x $INITD_LOC/$SERVICE_SCRIPT
echo
echo Add Service $SERVICE_SCRIPT
sudo chkconfig --add $SERVICE_SCRIPT
echo
echo Enable Service $SERVICE_SCRIPT
sudo chkconfig $SERVICE_SCRIPT on
echo
echo Restart Service $SERVICE_SCRIPT
sudo service $SERVICE_SCRIPT restart

