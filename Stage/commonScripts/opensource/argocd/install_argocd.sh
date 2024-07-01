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
ACD_BASE_URL=https://github.com/argoproj/argo-cd
ACD_BIN=argocd
ACD_DOWNLOAD_NAME="argocd-linux-amd64 "
#
# Show current version of yq
function acd_show_version(){
   $ACD_BIN --version
}
#
# Get the yq bin version
function get_acd_bin_version(){
  local acd_version=$(acd_show_version | grep version | rev | cut -d' ' -f 1 | rev | xargs)
  echo $acd_version
}
#
# Main
function main(){
  local acd_bin_path=$BIN_DIR/$ACD_BIN
  if [ -f "$acd_bin_path" ]; then
    acd_cur_ver=$(get_acd_bin_version)
    echo "$ACD_BIN already available. Current version is: $acd_cur_ver"
    acd_latest_version=$(get_git_version $ACD_BASE_URL)
    if [ "$acd_cur_ver" = "$acd_latest_version" ]; then
      echo "Current version ($acd_cur_ver) is the latest ($acd_latest_version)."
    else
      echo "Current version ($acd_cur_ver) is not the latest ($acd_latest_version)."
      backup_current_version $ACD_BIN $acd_cur_ver
    fi
  else
    echo "$ACD_BIN not available yet."
  fi
  #
  if [ ! -f "$acd_bin_path" ]; then
    download_from_git $ACD_BIN $ACD_BASE_URL $ACD_DOWNLOAD_NAME $ACD_VER
  else
    echo $ACD_BIN already available as: $acd_bin_path
  fi
  echo "Check $acd_bin_path"
  if [ -f "$acd_bin_path" ]; then
    echo "Show $ACD_BIN version:"
    acd_show_version
  else
    echo "$ACD_BIN should be available, at this point."
  fi
}

main "$@" 