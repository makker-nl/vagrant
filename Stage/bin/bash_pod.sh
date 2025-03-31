#!/bin/bash
###############################################################################
# Copy file from Kubernetes Pod
#
# Oracle Consulting Netherlands
#
# History
# -------
# 2024-10-02, M. van den Akker, Initial Creation 
# 
############################################################################### 
export NS=${NS:-default}
export POD=$1
export CONTAINER=$2
if [ "$CONTAINER" == "" ]; then
  echo "Start bash in pod $NS:$POD"
  kubectl -n $NS exec $POD -it -- /bin/bash
else
  echo "Start bash in pod/container $NS:$POD/$CONTAINER"
  kubectl -n $NS exec $POD -c $CONTAINER -it -- /bin/bash
fi
