#!/bin/bash
echo _______________________________________________________________________________
echo Install Open Java SDK 11
sudo yum install -q -y java-11-openjdk-devel
echo Set as default java
sudo rm /etc/alternatives/java
sudo ln -s /etc/alternatives/java_sdk_11_openjdk/bin/java /etc/alternatives/java
echo Show default java version:
java --version