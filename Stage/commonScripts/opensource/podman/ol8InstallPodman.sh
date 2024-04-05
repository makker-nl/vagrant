#!/bin/bash
echo _______________________________________________________________________________
echo Install podman
sudo dnf install -q -y podman
echo Show default Podman version:
podman --version