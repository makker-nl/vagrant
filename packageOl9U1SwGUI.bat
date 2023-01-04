@echo off
set VM_NAME=OL9U1
set BOX_NAME=OL9U1SwGUIv1.0
set BOX_HOME=c:\Data\Vagrant\boxes
set BOX_FILE=%BOX_NAME%.box
set BOX_PATH=%BOX_HOME%\%BOX_FILE%

@echo Remove Vagrant Box %BOX_NAME%
vagrant box remove %BOX_NAME%

@echo Delete Vagrant box %BOX_PATH%
del %BOX_PATH%

@echo Now package VM %VM_NAME% into Vagrant box %BOX_PATH%
vagrant package --base %VM_NAME% --output %BOX_PATH%