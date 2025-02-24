#!/bin/bash
#######################################################################################
# Install argocd cli
# @author: Martien van den Akker, Oracle Consulting
# 
# Taken from: https://argo-cd.readthedocs.io/en/stable/getting_started/
#
#######################################################################################
#
SCRIPTPATH=$(dirname $0)
SCRIPTBASE=$(realpath $SCRIPTPATH/..)
. $SCRIPTBASE/helper_functions.sh
#
CJCLI_BASE_URL=https://github.com/cyberark/conjur-cli-go
CJCLI_BIN=conjur
CJCLI_DOWNLOAD_NAME="conjur-cli-go_8.0.19_amd64.rpm"
#
# Show current version of yq
function cjcli_show_version(){
   $CJCLI_BIN --version
}
#
# Get the yq bin version
function get_cjcli_bin_version(){
  local cjcli_version="v$(cjcli_show_version --version | rev | cut -d' ' -f1 | rev | cut -d'-' -f1)"
  echo $cjcli_version
}
#
# Main
function main(){
  local cjcli_bin_path="/usr/bin/$CJCLI_BIN"
  cjcli_latest_version=$(curl -Ls $CJCLI_BASE_URL/releases/latest | grep Latest -B 4 |grep "h1" | cut -d'>' -f2 | cut -d'<' -f1)
  local upgrade=false
  echo "Conjur CLI Latest version: $cjcli_latest_version"
  if [ -f "$cjcli_bin_path" ]; then
    cjcli_cur_ver=$(get_cjcli_bin_version)
    echo "$CJCLI_BIN already available. Current version is: $cjcli_cur_ver"
    if [ "$cjcli_cur_ver" == "$cjcli_latest_version" ]; then
      echo "Current version ($cjcli_cur_ver) is the latest ($cjcli_latest_version)."
    else
      echo "Current version ($cjcli_cur_ver) is not the latest ($cjcli_latest_version)."
      upgrade=true
    fi
  else
    echo "$CJCLI_BIN not available yet at $cjcli_bin_path."
  fi
  
  if [ ! -f "$cjcli_bin_path" ] || [  "$cjcli_cur_ver" != "$cjcli_latest_version" ]; then
    download_rpm_from_git $CJCLI_BASE_URL $CJCLI_DOWNLOAD_NAME $cjcli_latest_version $upgrade
  else
    echo $CJCLI_BIN already available as: $cjcli_bin_path
  fi
  echo "Check $cjcli_bin_path"
  if [ -f "$cjcli_bin_path" ]; then
    echo "Show $CJCLI_BIN version:"
    cjcli_show_version
  else
    echo "$CJCLI_BIN should be available, at this point."
  fi
}

main "$@" 