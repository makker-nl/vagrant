#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install kubectl.
# @author: Martien van den Akker, VirtualSciences.
# 
# Taken from: https://kubernetes.io/docs/tasks/tools/install-kubectl/
#
KUBE_BIN=/usr/local/bin/kubectl
if [ ! -f "$KUBE_BIN" ]; then
 #
  # Download/Setup kubectl
  echo Download/Setup kubectl
  sudo curl -L "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" -o $KUBE_BIN
  sudo chmod +x $KUBE_BIN
else
  echo kubectl already available as: $KUBE_BIN
fi
echo Get kubectl version:
kubectl version