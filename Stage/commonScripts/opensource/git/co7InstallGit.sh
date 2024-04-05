#!/bin/bash
echo _______________________________________________________________________________
echo Install Git
sudo yum install -q -y git
echo Show default Git version:
git --version
echo .
echo . Don\'t forget to execute the following commmands to config git:
echo . $ git config --global user.name "Your Name"
echo . $ git config --global user.email "you@example.com"

echo _______________________________________________________________________________
echo Install Git completion and prompt
echo . get git-completion
GIT_COMPL_SH=~/.git-completion.sh
GIT_PROMPT_SH=~/.git-prompt.sh
BASH_PROF_SH=~/.bash_profile
echo "Checking Git Completion script: $GIT_COMPL_SH"
if [ ! -f "$GIT_COMPL_SH" ]; then
  echo . Get git-completion
  curl -o $GIT_COMPL_SH https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
else
  echo "Script $GIT_COMPL_SH already exists."
fi

if [ ! -f "$GIT_PROMPT_SH" ]; then
  echo . Get git-prompt
  curl -o $GIT_PROMPT_SH https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
else
  echo "Script $GIT_PROMPT_SH already exists."
fi
