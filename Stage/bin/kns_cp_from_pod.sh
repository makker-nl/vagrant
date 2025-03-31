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
export FROM_FILE=$2
export TO_FILE=$3
echo "Copy from pod $NS:$POD; from $FROM_FILE to $TO_FILE"
kubectl -n $NS cp $POD:$FROM_FILE $TO_FILE
