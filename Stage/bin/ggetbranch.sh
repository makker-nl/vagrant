#!/bin/bash
#############################################################################
# Fetch branch to be merged
#
# @author Martien van den Akker, Oracle Consulting
# @version 1.0, 2024-11-22 - Initial creation
#
#############################################################################
SCRIPTPATH=$(dirname $0)
#
main () {
  local branch_name=$(echo $1 | tr " " "-" )
  echo "fetch origin $branch_name"
  git fetch origin $branch:$branch

}
main "$@"
