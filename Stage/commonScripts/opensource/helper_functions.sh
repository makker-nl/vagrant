#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
#######################################################################################
# Helper functions for downloading and installing tool binaries from Git
# @author: Martien van den Akker, Oracle Consulting
#
#######################################################################################
#
DOWNLOAD_DIR=~/Downloads
BIN_DIR=/usr/local/bin
#
# Show the latest version of tool on github
function get_git_version(){
  base_url=$1
  git_tool_version=$(curl -LsS -o /dev/null -w %{url_effective} $base_url/releases/latest | rev | cut -d'/' -f 1 | rev | xargs)
  echo $git_tool_version
}
#
# Backup the current version of the tool
function backup_current_version(){
local tool_binary=$1
local current_version=$2
local bin_path=$BIN_DIR/$tool_binary
local bck_bin_path=$bin_path-$current_version
echo "Backup $bin_path to $bck_bin_path"
sudo mv $ $bin_path $bck_bin_path
}
#
# Download from github
function download_from_git(){
  local tool_binary=$1
  local base_url=$2
  local download_name=$3
  local git_download_version=$4
  local git_url="$YQ_BASE_URL/releases/download/$git_download_version/$download_name"
 
  echo Download/Setup $tool_binary from $git_url
  sudo curl -L $git_url -o $BIN_DIR/$tool_binary
  sudo install -o root -g root -m 0755 $DOWNLOAD_DIR/$tool_binary $BIN_DIR/$tool_binary
}