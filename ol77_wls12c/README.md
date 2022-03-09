# Oracle Linux 7.7: Oracle Weblogic
This vagrant projec creates a VM with Oracle Weblogic and Oracle Database 12cR1

## Users: 
+ root - vagrant
+ vagrant - vagrant
+ oracle - welcome1

## Installations:
The following is installed:
+ **OracleJDK 8** in /app/oracle/product/jdk8 [Download Installer](../Stage/installBinaries/Oracle/Java).
+ **Oracle Database** 
+ **Weblogic 12.2.1.3** 

## Provisioners:
The following provisioners are created.

| Name                   | run           | Description                     | Install Script      | Install Binary |
| ---------------------- | ------------- |---------------------------------| --------------------|----------------|
| init                   | once          | Initialize VM                   |                     |                |
| installOJava8          | once          | Install Oracle JDK 8            | [oracle/java/jdk8/installJava8.sh](../Stage/commonScripts/oracle/java/jdk8/installJava8.sh) |                |

