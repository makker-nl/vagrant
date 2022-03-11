# Oracle Linux 7.7: Oracle Weblogic
This vagrant projec creates a VM with Oracle Weblogic and Oracle Database 12cR1

## Users: 
+ root - vagrant
+ vagrant - vagrant
+ oracle - welcome1

## Installations:
The following is installed:
+ **OracleJDK 8** 
+ **Oracle Database 12.1 (12.1.0.2)** 
+ **Oracle SQL Developer 19.4**
+ **Weblogic 12.2.1.3** 

## Provisioners:
The following provisioners are created.

| Name                   | run     | Description                      | Install Scripts     | Install Binaries |
| ---------------------- | --------|----------------------------------| --------------------|------------------|
| init                   | once    | Initialize VM                    |                     |                  |
| installOJava8          | once    | Install Oracle JDK 8             | [oracle/java](../Stage/commonScripts/oracle/java/README.md) | [installBinaries/Oracle/Java](../Stage/installBinaries/Oracle/Java/README.md) |
| installDB12c           | once    | Install Oracle Database 12cR1    | [commonScripts/oracle/db/12.1](../Stage/commonScripts/oracle/db/12.1/README.md) | [installBinaries/Oracle/DB/12.1.0.2/x86_64](../Stage/installBinaries/Oracle/DB/12.1.0.2/x86_64/README.md) |
| startDB                | always  | Start Oracle Database 12cR1      | [commonScripts/oracle/db/12.1](../Stage/commonScripts/oracle/db/12.1/README.md) |  |
| installSQLDev          | once    | Oracle SQL Developer 19.4        | [commonScripts/oracle/db/sqldev](../Stage/commonScripts/oracle/db/sqldev/README.md) |  [installBinaries/Oracle/DB/SQLDeveloper](../Stage/installBinaries/Oracle/DB/SQLDeveloper/README.md) |
| installWLS12c          | once    | Start Weblogic 12cR2 (12.2.1.3)  | [commonScripts/oracle/fmw/wls/12.2.1.3](../Stage/commonScripts/oracle/fmw/wls/12.2.1.3/README.md) | [installBinaries/Oracle/FMW/12.2.1.3/WLS](../Stage/installBinaries/Oracle/FMW/12.2.1.3/WLS/README.md) |
| installOpenDJ          | once    | OpenDJ Community Edition 4.4.11  | [commonScripts/opensource/openDJ](../Stage/commonScripts/opensource/openDJ/README.md) |   [installBinaries/OpenSource/OpenDJ](../Stage/installBinaries/OpenSource/OpenDJ/README.md) |