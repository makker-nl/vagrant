#RCU Operation - createRepository, generateScript, dataLoad, dropRepository
operation=dropRepository

#Enter the database connection details in the supported format. Database Connect String. This can be specified in the following format - For Oracle Database: host:port:SID OR host:port/service , For SQLServer, IBM DB2, MySQL and JavaDB Database: Server name/host:port:databaseName. For RAC database, specify VIP name or one of the Node name as Host name.For SCAN enabled RAC database, specify SCAN host as Host name.
connectString=${DB_CONNECT_STR}

#Database Type - [ORACLE|SQLSERVER|IBMDB2|EBR|MYSQL] - default is ORACLE
databaseType=ORACLE

#Database User
dbUser=sys

#Database Role - sysdba or Normal
dbRole=SYSDBA

#This is applicable only for database type - EBR
#edition=

#Prefix to be used for the schema. This is optional for non-prefixable components.
schemaPrefix=${DB_SCHEMA_PREFIX}

#List of components separated by comma. Remove the components which are not needed.
componentList=${RCU_COMPONENT_LIST}

#Yes | No - default is No. This allows user to skip dropping tablespace during drop repository operation
#skipTablespaceDrop=no

#Yes | No - default is Yes. This is applicable only for database type - SQLSERVER.
#unicodeSupport=no

#Location of ComponentInfo xml file - optional.
#compInfoXMLLocation=

#Location of Storage xml file - optional
#storageXMLLocation=

#Absolute path of Wallet directory. If wallet is not provided, passwords will be prompted.
#walletDir=

#Variable required for component SOAINFRA. Database Profile
SOA_PROFILE_TYPE=${DB_PROFILE}

#Variable required for component ACTIVITIES. Install Analytics with Partitioning (Y/N)
ANALYTICS_WITH_PARTITIONING=N

