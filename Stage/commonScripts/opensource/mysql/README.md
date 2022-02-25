# Install MySql Driver
+ To install the MySql Driver, download the connector as described [here](../../../installBinaries/opensource/mysql/README.md)
+  Unzip the connector. The resulting directory contains a "mysql-connector-java-8.0.23.jar" file.
+ Open SQL Developer and navigate to "Tools > Preferences > Database > Third Party JDBC Driver".
+ Click the "Add Entry..." button and highlight the "mysql-connector-java-8.0.23.jar" file and click the "Select" button.
+ Click the "OK" button to exit the "Preferences" dialog.
+ When you create a new connection, the "Database Type" dropdown includes a MySQL option. On older versions of SQL Developer this used to appear as a tab. Enter the connection details and test the connection.
Taken from [oracle-base.com](https://oracle-base.com/articles/mysql/mysql-connections-in-sql-developer).
