// import ballerina/sql;
import ballerinax/mysql;

// configurable string dbHost = ;
// configurable int dbPort = ?;
// configurable string dbUser = ?;
// configurable string dbPassword = ?;
// configurable string dbName = ?;



# Database Client Configuration.
configurable DatabaseConfig dbConfig = ?;


public mysql:Client dbClient = check new(
    host = dbConfig.dbHost,
    port = dbConfig.dbPort,
    user = dbConfig.dbUser,
    password = dbConfig.dbPassword,
    database = dbConfig.dbName
);

