#!/bin/bash
#############################################################################
# Merge branch into current
#
# @author Martien van den Akker, Oracle Consulting
# @version 1.0, 2024-11-22 - Initial creation
#
#############################################################################
SCRIPTPATH=$(dirname $0)
#
main () {
  local branch_name=$(echo $1 | tr " " "-" )
  echo "Merge branch $branch_name into current."
  git merge $branch --no-ff
}
main "$@"
