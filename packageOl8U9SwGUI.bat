@echo off
set VM_NAME=OL8SwGUI
set BOX_NAME=OL8SwGUIv9.0
set BOX_HOME=c:\Data\Vagrant\boxes
set BOX_FILE=%BOX_NAME%.box
set BOX_PATH=%BOX_HOME%\%BOX_FILE%

@echo Remove Vagrant Box %BOX_NAME%
vagrant box remove %BOX_NAME%

@echo Delete Vagrant box %BOX_PATH%
del %BOX_PATH%

@echo Now package VM %VM_NAME% into Vagrant box %BOX_PATH%
vagrant package --base %VM_NAME% --output %BOX_PATH%

@echo Generate MD5 checksum for Vagrant box %BOX_PATH%
certutil -hashfile %BOX_PATH% MD5