#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install helm.
# @author: Martien van den Akker, VirtualSciences.
# 
# Taken from: https://docs.microsoft.com/nl-nl/cli/azure/install-azure-cli-linux?pivots=dnf
#
AZ_BIN=/usr/bin/az
#
if [ ! -f "$AZ_BIN" ]; then
  #
  # 1. Importeer de sleutel voor de Microsoft-opslagplaats.
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

  # 2. Maak de vereiste gegevens voor de lokale azure-cli-opslagplaats. 

  echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo

  # 3. Voer de installatie uit met de opdracht dnf install.
  sudo yum install -q -y azure-cli 
else
  echo azure-cli already available as: $AZ_BIN
fi
echo Get azure-cli version:
az --version