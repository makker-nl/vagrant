#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install kubectl.
# @author: Martien van den Akker, VirtualSciences.
# 
# Taken from: https://kubernetes.io/docs/tasks/tools/install-kubectl/
#
KUBE_VER=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
KUBE_URL="https://storage.googleapis.com/kubernetes-release/release/$KUBE_VER/bin/linux/amd64/kubectl"
KUBE_DIR=~/Downloads/KUBE-$KUBE_VER-linux-amd64
KUBE_BIN=/usr/local/bin/kubectl
#
echo Latest version kubectl: $KUBE_VER
#
if [ ! -f "$KUBE_BIN" ]; then
 #
  # Download/Setup kubectl
  echo Download/Setup kubectl
  sudo curl -L $KUBE_URL -o $KUBE_BIN
  sudo chmod +x $KUBE_BIN
else
  echo kubectl already available as: $KUBE_BIN
fi
# echo Get kubectl version:
# kubectl version