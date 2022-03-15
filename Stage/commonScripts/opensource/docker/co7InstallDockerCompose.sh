#!/bin/bash
SCRIPTPATH=$(dirname $0)
#
# Install docker-compose on CentOS Linux.
# @author: Martien van den Akker, VirtualSciences.
# 
# Taken from: https://phoenixnap.com/kb/install-docker-compose-centos-7
#
DCKRC_BIN=/usr/local/bin/docker-compose
DCKRC_URL=https://github.com/docker/compose/releases
DCKRC_VER=$(curl -sSL ${DCKRC_URL} | sed -n '/Latest<\/span><\/a>/,$p' | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1)
if [ ! -f "$DCKRC_BIN" ]; then
 #
  # Download/Setup Docker Compose
  echo Download/Setup Docker Compose version ${DCKRC_VER}
  sudo curl -L "${DCKRC_URL}/download/${DCKRC_VER}/docker-compose-$(uname -s)-$(uname -m)" -o $DCKRC_BIN
  sudo chmod +x $DCKRC_BIN
else
  echo Docker Compose already available as: $DCKRC_BIN
fi
# echo Get docker-compose version:
# docker-compose --version