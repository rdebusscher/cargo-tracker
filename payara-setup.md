Payara config
-----

Commands to create a JDBC connection pool and resource.

The example is created with MySQL driver but can be adjusted for any database by using correct library, Driver name, JDBC url, ... 

./asadmin add-library <path-to>/mysql-connector-java-5.1.39.jar

./asadmin create-jdbc-connection-pool --datasourceclassname com.mysql.jdbc.jdbc2.optional.MysqlDataSource --restype javax.sql.XADataSource --property url="jdbc\:mysql\://localhost\:3306/rubus" cargo-pool

./asadmin set resources.jdbc-connection-pool.cargo-pool.property.password=<mySecretPw> resources.jdbc-connection-pool.cargo-pool.property.databaseName=rubus resources.jdbc-connection-pool.cargo-pool.property.serverName=localhost resources.jdbc-connection-pool.cargo-pool.property.user=rubus resources.jdbc-connection-pool.cargo-pool.property.portNumber=3306

./asadmin ping-connection-pool cargo-pool

./asadmin create-jdbc-resource --enabled=true --poolName=cargo-pool --target=domain jdbc/cargo-ds

./asadmin create-resource-ref --enabled=true --target=server jdbc/cargo-ds


Persistence of EJB timers

./asadmin set configs.config.cluster-config.ejb-container.ejb-timer-service.ejb-timer-service=DataGrid


Config   

./asadmin set-config-property --propertyName=GraphTraversalUrl --propertyValue=http://<public_dns_name>/cargo-tracker/rest/graph-traversal/shortest-path --source=application --sourceName=cargo-tracker --target=<deployment-group>

 
the above has an currently an issue, use this

./asadmin create-jvm-options --target cluster-config -DGraphTraversalUrl=http://<public_dns_name>/cargo-tracker/rest/graph-traversal/shortest-path
