[ENGINE]

#DO NOT CHANGE THIS.
Response File Version=1.0.0.0.0

[GENERIC]

#Set this to true if custom installation must be done, all other required variables need to be provided. If this is set to true then variable "TYPICAL_TYPE" must be set to false as the variables are mutually exclusive.
INSTALL_TYPE=Typical

#Set this to true if you wish to skip software updates
DECLINE_AUTO_UPDATES=true

#My Oracle Support User Name
MOS_USERNAME=

#My Oracle Support Password
MOS_PASSWORD=<SECURE VALUE>

#If the Software updates are already downloaded and available on your local system, then specify the path to the directory where these patches are available and set SPECIFY_DOWNLOAD_LOCATION to true
AUTO_UPDATES_LOCATION=

#Proxy Server Name to connect to My Oracle Support
SOFTWARE_UPDATES_PROXY_SERVER=

#Proxy Server Port
SOFTWARE_UPDATES_PROXY_PORT=

#Proxy Server Username
SOFTWARE_UPDATES_PROXY_USER=

#Proxy Server Password
SOFTWARE_UPDATES_PROXY_PASSWORD=<SECURE VALUE>

#The oracle home location. This can be an existing Oracle Home or a new Oracle Home
ORACLE_HOME=${JDEV_HOME}


