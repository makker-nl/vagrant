#!/bin/bash
###############################################################################
# Copy file to Kubernetes Pod
#
# Oracle Consulting Netherlands
#
# History
# -------
# 2025-02-14, M. van den Akker, Initial Creation 
# 
############################################################################### 
export NS=${NS:-default}
export POD=$1
export FROM_FILE=$2
export TO_FILE=$3
echo "Copy to pod $NS:$POD; from $FROM_FILE to $TO_FILE"
kubectl -n $NS cp $FROM_FILE $POD:$TO_FILE
