#!/bin/bash
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
# From: https://github.com/containers/skopeo/blob/main/install.md
echo Install Skopeo
sudo dnf -y install skopeo
echo Show Skopeo version:
skopeo --version