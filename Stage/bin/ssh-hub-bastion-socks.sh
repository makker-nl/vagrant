#!/bin/bash
###############################################################################
# Create a tunnel and guard it.
#
# Oracle Consulting Netherlands
#
# History
# -------
# 2024-08-22, M. van den Akker, Initial Creation 
# 
############################################################################### 
export TUNNEL_HOST=vm-ams-hub-bastion
export TUNNEL_PORT=8080
export TUNNEL_USER=opc
export RSA_KEY=~/.ssh/id_rsa_makker_202502
export SLEEP_INTERVAL=10
while true
do
  ssh_ps=$(ps -ef |grep ssh | grep $TUNNEL_HOST | grep $TUNNEL_PORT)
  exit_code=$?
  ssh_pid=$(echo $ssh_ps | tr -s ' ' | cut -d' ' -f2)
  if [[ "$exit_code" == 0 ]]; then
    echo "SSH Tunnel for $TUNNEL_USER@$TUNNEL_HOST is already running with pid $ssh_pid"
  else
    echo "Start SSH Tunnel for $TUNNEL_USER@$TUNNEL_HOST with key $RSA_KEY"
    ssh -D $TUNNEL_PORT -q -fN -i $RSA_KEY $TUNNEL_USER@$TUNNEL_HOST
  fi
  sleep $SLEEP_INTERVAL
done

