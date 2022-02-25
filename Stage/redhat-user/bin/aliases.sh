#!/bin/bash
# Common
alias his="history | grep "
# git aliases
alias ga="git add ."
alias gc="git commit -m $1"
alias gp="git push"
alias gpl="git pull"
alias gs="git status"
alias gclndev="git clone --single-branch --branch develop $1"
alias gcln="git clone $1"
alias gr="git reset --hard HEAD"
alias glsunc="git ls-files -v | grep '^[[:lower:]]'"
alias gls="git ls-files -v"
# docker compose
alias dkrc_up="docker-compose up" 
alias dkrc_upb="docker-compose up --build"
alias dkrc_dwn="docker-compose down"
#docker
alias dckr_ps="docker ps"
alias dckr_prn="docker system prune -a"
alias dckr_im="docker images"
# oc
alias ocgn="oc get nodes"
alias ocgp="oc get pods"
alias ocgs="oc get services"
alias ocgr="oc get routes"
alias ocgpsts="oc get pods -o wide| awk '{print \$1 \" - \"  \$3}'"
