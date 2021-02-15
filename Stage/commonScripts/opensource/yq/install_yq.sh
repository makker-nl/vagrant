#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
# https://snapcraft.io/install/yq/centos
#
echo Install snapd
sudo yum install snapd
echo Enable systemd unit
sudo systemctl enable --now snapd.socket
echo Wait 5 seconds to have snapd deamon started
sleep 5
echo Enable Classic snap support
sudo ln -s /var/lib/snapd/snap /snap
echo Install yq
sudo snap install yq
sudo chmod a+x /usr/bin/yq