#/bin/bash
ES=$1
kubectl -n $NS annotate es $ES force-sync=$(date +%s) --overwrite
