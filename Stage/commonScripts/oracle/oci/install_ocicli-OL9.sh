#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
function main(){
  echo Install OCI cli with default settings for Oracle Linux 9
  sudo dnf -y install oraclelinux-developer-release-el9 python39-oci-cli
  # Create .kube config folder
  mkdir -p $HOME/.kube
}

main "$@"