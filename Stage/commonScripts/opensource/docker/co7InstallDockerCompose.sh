#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install docker-compose on Oracle Linux.
# @author: Martien van den Akker, VirtualSciences.
# 
# Taken from: https://phoenixnap.com/kb/install-docker-compose-centos-7
#
DCKRC_BIN=/usr/local/bin/docker-compose
DCKRC_VER=1.27.4
if [ ! -f "$DCKRC_BIN" ]; then
 #
  # Download/Setup Docker Compose
  echo Download/Setup Docker Compose
  sudo curl -L "https://github.com/docker/compose/releases/download/${DCKRC_VER}/docker-compose-$(uname -s)-$(uname -m)" -o $DCKRC_BIN
  sudo chmod +x $DCKRC_BIN
else
  echo Docker Compose already available as: $DCKRC_BIN
fi
echo Get docker-compose version:
docker-compose --version