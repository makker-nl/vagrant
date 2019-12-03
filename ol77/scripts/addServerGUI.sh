#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# https://linuxconfig.org/install-gnome-gui-on-rhel-7-linux-server
echo Installing Server with GUI package group.
sudo yum -q -y groupinstall 'Server with GUI'
echo Update runlevel to make GUI default
sudo systemctl set-default graphical.target