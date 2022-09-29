#!/bin/bash
# From https://tecadmin.net/restart-network-service-on-centos8/
SCRIPTPATH=$(dirname $0)
echo Restart Network
sudo systemctl restart NetworkManager.service
