#!/bin/bash
# From: https://github.com/containers/skopeo/blob/main/install.md#rhel--centos-stream--8
SCRIPTPATH=$(dirname $0)
#
export STORAGE_CONF=storage.conf
export STORAGE_CONF_TPL=$STORAGE_CONF.tpl
export STORAGE_CONF_FLDR=~/.config/containers

#
function main(){
  echo _______________________________________________________________________________
  echo Install podman
  sudo dnf install -q -y podman
  echo Show Podman version:
  podman --version
  # Move container data location
  # See https://docs.oracle.com/en/operating-systems/oracle-linux/podman/podman-ConfiguringStorageforPodman.html#podman-install-storage
  USER=$(whoami)
  export USERID=$(id $USER | cut -d'(' -f 1 | cut -d'=' -f 2)
  echo Id of user $USER: $USERID
  echo Expand $SCRIPTPATH/$STORAGE_CONF_TPL to $STORAGE_CONF_FLDR/$STORAGE_CONF
  mkdir -p $STORAGE_CONF_FLDR
  envsubst < $SCRIPTPATH/$STORAGE_CONF_TPL > $STORAGE_CONF_FLDR/$STORAGE_CONF
  CONTAINER_DATA=$(cat $STORAGE_CONF_FLDR/$STORAGE_CONF | grep graphroot | grep -v "#" | cut -d"=" -f 2 | tr -d " \"")
  echo Container Image data will be stored in $CONTAINER_DATA 
}

main "$@"