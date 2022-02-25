# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH
#
export DEVHOME=/home/redhat/git/VS/redhat-fuse/application-development
export DEVCONFIG=${DEVHOME}/developer-config
export GHHOME=/home/redhat/git/makker
export NSHOME=/home/redhat/git/NS
#
. ~/bin/aliases.sh
