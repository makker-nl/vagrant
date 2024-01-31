#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install kubectl.
# @author: Martien van den Akker, VirtualSciences.
# 
# Taken from: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
#
KUBE_VER=$1
echo "Requested kubectl version: $KUBE_VER"
KUBE_URL="https://dl.k8s.io/release/$KUBE_VER/bin/linux/amd64/kubectl"
DOWNLOAD_DIR=~/Downloads
BIN_DIR=/usr/local/bin
KUBE_BIN=kubectl
KUBE_DWNL_BIN=$DOWNLOAD_DIR/$KUBE_BIN 
KUBE_BIN_PATH=/usr/local/bin/$KUBE_BIN 
#
if [ -f "$KUBE_BIN_PATH" ]; then
  KUBECTL_CUR_VER=$($KUBE_BIN version | grep "Client Version" | cut -d':' -f 2 | tr -d ' ')
  echo "$KUBE_BIN already available. Current version is: $KUBECTL_CUR_VER"
  if [ "$KUBE_VER" = "$KUBECTL_CUR_VER" ]; then
    echo "Current version ($KUBECTL_CUR_VER) is requested ($KUBE_VER)."
  else
    KUBE_BCK_PATH=${KUBE_BIN_PATH}-${KUBECTL_CUR_VER}
    echo "Current version ($KUBECTL_CUR_VER) is not the requested ($KUBE_VER). Backup $KUBE_BIN_PATH to $KUBE_BCK_PATH"
    sudo mv $KUBE_BIN_PATH $KUBE_BCK_PATH
  fi
else
  echo $ISTIOCTL_BIN not available yet.
fi
#
if [ ! -f "$KUBE_BIN_PATH" ]; then
 #
  # Download/Setup kubectl
  echo Download/Setup kubectl
  sudo curl -L $KUBE_URL -o $KUBE_DWNL_BIN
  sudo install -o root -g root -m 0755 $KUBE_DWNL_BIN $KUBE_BIN_PATH
else
  echo kubectl already available as: $KUBE_BIN_PATH
fi
echo Get kubectl version:
$KUBE_BIN version