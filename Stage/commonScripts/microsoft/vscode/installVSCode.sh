#!/bin/sh
SCRIPTPATH=$(dirname $0)
#
# Install Visual Studio Code.
# @author: Martien van den Akker, Oracle Consulting Technology Netherlands.
# 
# Taken from: https://blogs.oracle.com/wim/post/installing-visual-studio-code-on-oracle-linux-7
#
VSCODE_BIN=/usr/bin/code
SETTINGS_JSON=~/.config/Code/User/settings.json
#
#
function install_vscode(){
  if [ ! -f "$VSCODE_BIN" ]; then
    echo "Install Visual Studio Code"
    #
    # 1. Import the key for the Microsoft-repository.
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

    # 2. Create the necessary info for the local visual studio code repository. 
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
    # 3. Install with dnf install.
    sudo dnf check-update
    sudo dnf install -q -y code
  else
    echo "Visual Studio Code already available as: $VSCODE_BIN"
  fi
  if [ ! -f "$SETTINGS_JSON" ]; then
    echo "Set native window style"
    echo '{ "window.titleBarStyle": "native" }' > $SETTINGS_JSON
  else
    echo "Settings file $SETTINGS_JSON already exists!"
  fi
 
}
#
function show_version(){
  echo "Get VS Code version:"
  code --version
}
#
function main(){
  install_vscode
  show_version
}

main "$@"