# SoapUI 5.7.x
## Install Script
The script that installs SoapUI is [installSoapUI.sh](installSoapUI.sh). 
It determines the version of SoapUI OpenSource by inspecting the page https://www.soapui.org/downloads/latest-release/, in search for the line: 'Latest SoapUI Open Source Downloads'.
Using that, it downloads SoapUI from SOAPUI_URL=https://dl.eviware.com/soapuios/$SOAPUI_VER/$SOAPUI_TAR_NAME
So, there is no need to pre-download the binary in [installBinaries/OpenSource/SoapUI](../../../../installBinaries/OpenSource/SoapUI).