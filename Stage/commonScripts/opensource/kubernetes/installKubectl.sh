#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install kubectl.
# @author: Martien van den Akker, Oracle Consulting
#
# Taken from: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
#
KUBECTL_VER=$(curl -L -s https://dl.k8s.io/release/stable.txt)
echo "Latest kubectl version: $KUBECTL_VER"
KUBECTL_URL="https://dl.k8s.io/release/$KUBECTL_VER/bin/linux/amd64/kubectl"
DOWNLOAD_DIR=~/Downloads
BIN_DIR=/usr/local/bin
KUBECTL_BIN=kubectl
KUBECTL_DWNL_BIN=$DOWNLOAD_DIR/$KUBECTL_BIN
KUBECTL_BIN_PATH=/usr/local/bin/$KUBECTL_BIN
#
function check_version(){
  if [ -f "$KUBECTL_BIN_PATH" ]; then
    KUBECTL_CUR_VER=$($KUBECTL_BIN version | grep "Client Version" | cut -d':' -f 2 | tr -d ' ')
    echo "$KUBECTL_BIN already available. Current version is: $KUBECTL_CUR_VER"
    if [ "$KUBECTL_VER" = "$KUBECTL_CUR_VER" ]; then
      echo "Current version ($KUBECTL_CUR_VER) is the latest ($KUBECTL_VER)."
    else
      KUBECTL_BCK_PATH=${KUBECTL_BIN_PATH}-${KUBECTL_CUR_VER}
      echo "Current version ($KUBECTL_CUR_VER) is not the latest ($KUBECTL_VER). Backup $KUBECTL_BIN_PATH to $KUBECTL_BCK_PATH"
      sudo mv $KUBECTL_BIN_PATH $KUBECTL_BCK_PATH
    fi
  else
    echo $KUBECTL_BIN not available yet.
  fi
}
#
function install_kubectl(){
  if [ ! -f "$KUBECTL_BIN_PATH" ]; then
    # Download/Setup kubectl
    echo "Download/Setup $KUBECTL_BIN from  $KUBECTL_URL to $KUBECTL_DWNL_BIN"
    mkdir -p $DOWNLOAD_DIR
    sudo curl -L $KUBECTL_URL -o $KUBECTL_DWNL_BIN
    sudo install -o root -g root -m 0755 $KUBECTL_DWNL_BIN $KUBECTL_BIN_PATH
    echo "Remove $KUBECTL_DWNL_BIN"
    rm $KUBECTL_DWNL_BIN
  else
    echo $KUBECTL_BIN already available as: $KUBECTL_BIN_PATH
  fi
}
#
function show_version(){
  echo Get $KUBECTL_BIN version:
  $KUBECTL_BIN version
}
#
function main(){
  check_version
  install_kubectl
  show_version
}

main "$@"