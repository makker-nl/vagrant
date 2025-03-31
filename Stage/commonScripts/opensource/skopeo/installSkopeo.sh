#!/bin/bash
#
# Install skopeo.
# @author: Martien van den Akker, Oracle Consulting
#
# From: https://github.com/containers/skopeo/blob/main/install.md
#
SCRIPTPATH=$(dirname $0)
#
. $SCRIPTPATH/../../install_env.sh
#
function main(){
  echo Install Skopeo
  sudo dnf -y install skopeo
  echo Show Skopeo version:
  skopeo --version  
}

main "$@"