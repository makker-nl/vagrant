#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install helm.
# @author: Martien van den Akker, Oracle Consulting.
# 
# Taken from: https://docs.k8slens.dev/getting-started/install-lens/
#
echo add Lens repo
sudo dnf config-manager --add-repo https://downloads.k8slens.dev/rpm/lens.repo
echo install Lens Desktop
sudo dnf -y install lens
echo run Lens Desktop with: lens-desktop