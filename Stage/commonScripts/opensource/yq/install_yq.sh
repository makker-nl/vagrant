#!/bin/bash
#######################################################################################
# Install yq.
# @author: Martien van den Akker, Oracle Consulting
# 
# Taken from: https://github.com/yq/yq/blob/main/docs/install.md
#
#######################################################################################
#
SCRIPTPATH=$(dirname $0)
SCRIPTBASE=$(realpath $SCRIPTPATH/..)
. $SCRIPTBASE/helper_functions.sh
#
YQ_BASE_URL=https://github.com/mikefarah/yq
YQ_BIN=yq
YQ_DOWNLOAD_NAME="yq_linux_amd64"
#
# Show current version of yq
function yq_show_version(){
   $YQ_BIN --version
}
#
# Get the yq bin version
function get_yq_bin_version(){
  local yq_version=$(yq_show_version | grep version | rev | cut -d' ' -f 1 | rev | xargs)
  echo $yq_version
}
#
# Main
function main(){
  local yq_bin_path=$BIN_DIR/$YQ_BIN
  if [ -f "$yq_bin_path" ]; then
    yq_cur_ver=$(get_yq_bin_version)
    echo "$YQ_BIN already available. Current version is: $yq_cur_ver"
    yq_latest_version=$(get_git_version $YQ_BASE_URL)
    if [ "$yq_cur_ver" = "$yq_latest_version" ]; then
      echo "Current version ($yq_cur_ver) is the latest ($yq_latest_version)."
    else
      echo "Current version ($yq_cur_ver) is not the latest ($yq_latest_version)."
      backup_current_version $YQ_BIN $yq_cur_ver
    fi
  else
    echo "$YQ_BIN not available yet."
  fi
  #
  if [ ! -f "$yq_bin_path" ]; then
    download_from_git $YQ_BIN $YQ_BASE_URL $YQ_DOWNLOAD_NAME $yq_latest_version
  else
    echo $YQ_BIN already available as: $yq_bin_path
  fi
  echo "Check $yq_bin_path"
  if [ -f "$yq_bin_path" ]; then
    echo "Show $YQ_BIN version:"
    yq_show_version
  else
    echo "$YQ_BIN should be available, at this point."
  fi
}

main "$@" 
