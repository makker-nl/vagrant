#!/bin/bash
#############################################################################
# Backup user data
#
# @author Martien van den Akker, Oracle Consulting
# @version 1.0, 2025-03-30 - Initial creation
#
#############################################################################
SCRIPTPATH=$(dirname $0)
#
  SSH_SOURCE=~/.ssh
  SSH_DEST=/vagrant
#
  BIN_SOURCE=~/bin
  BIN_DEST=/media/sf_Stage/
#
  OCI_SOURCE=~/.ssh
  OCI_DEST=/vagrant
#
  KUBE_SOURCE=~/.kube
  KUBE_DEST=/vagrant
#
  BASH_DEST=/vagrant/bash
#
  POL_DEST=/media/sf_Projects/Politie
#
function backup_ssh(){
  echo "Copy $SSH_SOURCE to $SSH_DEST"
  cp -R "$SSH_SOURCE" "$SSH_DEST"
}
#
function backup_bin(){
  echo "Copy $BIN_SOURCE to $BIN_DEST"
  mkdir -p "$BIN_DEST"
  cp -RL "$BIN_SOURCE" "$BIN_DEST"
}
#
function backup_oci(){
  echo "Copy $OCI_SOURCE to $OCI_DEST"
  cp -R "$OCI_SOURCE" "$OCI_DEST"
}
#
function backup_kube(){
  echo "Copy $KUBE_SOURCE to $KUBE_DEST"
  cp -R "$KUBE_SOURCE" "$KUBE_DEST"
}
#
function backup_bash(){
  echo "Copy bash_profile, bashrc to $BASH_DEST"
  mkdir -p "$BASH_DEST"
  cp ~/.bash_profile ~/.bash_rc ~/.bashrc "$BASH_DEST"
}
#
function backup_pol(){
  echo "Copy Politie files"
  mkdir -p $POL_DEST/bin
  cp ~/git/politie/tf_env.sh $POL_DEST/bin
  cp ~/git/politie/tf_env.sh $POL_DEST/bin

}
#
main () {
  backup_ssh
  backup_bin
  backup_oci
  backup_kube
  backup_bash
  backup_pol
}
main "$@"
