#!/bin/bash
echo set Install environment
export STAGE_HOME=/media/sf_Stage
export EXTRACT_HOME=/media/sf_Stage/Extracted
export TMP_DIR=/tmp
export INSTALL_TMP_DIR=/app/tmp
export SCRIPT_HOME=/vagrant/scripts
export DB_VER=12.1.0.2/x86_64
export DB_STAGE_HOME=$STAGE_HOME/DBInstallation/$DB_VER
export FMW_VER=12.2.1.3
export FMW_STAGE_HOME=$STAGE_HOME/FMWInstallation/$FMW_VER
export OS_BASE=/app/opensource