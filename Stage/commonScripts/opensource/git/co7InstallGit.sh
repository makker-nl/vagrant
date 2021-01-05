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