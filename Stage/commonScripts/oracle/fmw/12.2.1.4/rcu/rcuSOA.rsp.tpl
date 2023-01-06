#RCU Operation - createRepository, generateScript, dataLoad, dropRepository, consolidate, generateConsolidateScript, consolidateSyn, dropConsolidatedSchema, reconsolidate
operation=createRepository

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
componentList=${RCU_SOA_COMPONENT_LIST}

#Specify whether dependent components of the given componentList have to be selected. true | false - default is false
#selectDependentsForComponents=false

#If below property is set to true, then all the schemas specified will be set to the same password.
useSamePasswordForAllSchemaUsers=false

#This allows user to skip cleanup on failure. yes | no. Default is no.
#skipCleanupOnFailure=no

#Yes | No - default is Yes. This is applicable only for database type - SQLSERVER.
#unicodeSupport=no

#Location of ComponentInfo xml file - optional.
#compInfoXMLLocation=

#Location of Storage xml file - optional
#storageXMLLocation=

#Tablespace name for the component. Tablespace should already exist if this option is used.
#tablespace=

#Temp tablespace name for the component. Temp Tablespace should already exist if this option is used.
#tempTablespace=

#Absolute path of Wallet directory. If wallet is not provided, passwords will be prompted.
#walletDir=

#true | false - default is false. RCU will create encrypted tablespace if TDE is enabled in the database.
#encryptTablespace=false

#true | false - default is false. RCU will create datafiles using Oracle-Managed Files (OMF) naming format if value set to true.
#honorOMF=false

#Variable required for component SOAINFRA. Database Profile (SMALL/MED/LARGE)
SOA_PROFILE_TYPE=${DB_PROFILE}

#Variable required for component SOAINFRA. Healthcare Integration(YES/NO)
HEALTHCARE_INTEGRATION=NO

