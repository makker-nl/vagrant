#!/bin/sh
SCRIPTPATH=$(dirname $0)
#
# Install Visual Studio Code.
# @author: Martien van den Akker, Oracle Consulting Technology Netherlands.
# 
# Taken from: https://blogs.oracle.com/wim/post/installing-visual-studio-code-on-oracle-linux-7
#
VSCODE_BIN=/usr/bin/code
#
if [ ! -f "$VSCODE_BIN" ]; then
  #
  # 1. Importeer de sleutel voor de Microsoft-repository.
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

  # 2. Maak de vereiste gegevens voor de lokale visual studio code repository. 
  echo -e "[vscode]
name=vscode
baseurl=https://packages.microsoft.com/yumrepos/vscode/
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo

  # 3. Voer de installatie uit met de opdracht dnf install.
  sudo dnf install -q -y code
else
  echo Visual Studio Code already available as: $VSCODE_BIN
fi
echo Get VS Code version:
code --version