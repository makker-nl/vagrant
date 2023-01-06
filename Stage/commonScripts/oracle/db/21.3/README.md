# Oracle Database 21c
The scripts in this folder install the Oracle Database 21c (21.3.0.0.0) 64 Bit.
The actual install script is [installDB.sh](installDB.sh).
It expects the installers in the [downloaded binaries folder ](../../../../installBinaries/Oracle/DB/21.3.0.0.0/x86_64/README.md)

In the StartStop folder the start en stop scripts are registered. These will be copied to the ~/bin folder during the install.
+ Database Environment: [StartStop/db12c_env.sh](StartStop/db21c_env.sh)
+ Start Database: [StartStop/startDB.sh](StartStop/startDB.sh)
+ Stop Database: [StartStop/startDB.sh](StartStop/stopDB.sh)