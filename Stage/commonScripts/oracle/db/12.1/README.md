# Oracle Database 12c R1
The scripts in this folder install the Oracle Database 12cR1 (12.1.0.2) 64 Bit.
The actual install script is [installDB.sh](installDB.sh).
In the StartStop folder the start en stop scripts are registered. Which will be copied to the ~/bin folder during the install.
+ Database Environment: [StartStop/db12c_env.sh](StartStop/db12c_env.sh)
+ Start Database: [StartStop/startDB.sh](StartStop/startDB.sh)
+ Stop Database: [StartStop/startDB.sh](StartStop/stopDB.sh)
It expects the installers in the [downloaded binaries folder ](../../../../installBinaries/Oracle/DB/12.1.0.2/x86_64/README.md)