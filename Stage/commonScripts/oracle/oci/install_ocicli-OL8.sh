#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
echo Install OCI cli with default settings for Oracle Linux 8
sudo dnf -y install oraclelinux-developer-release-el8
sudo dnf -y install python36-oci-cli
# Create .kube config folder
mkdir -p $HOME/.kube