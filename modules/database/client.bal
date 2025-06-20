import ballerinax/mysql;

# Database Client Configuration.
configurable DatabaseConfig dbConfig = ?;

# Initializes the MySQL database client
public mysql:Client dbClient = check new(
    host = dbConfig.dbHost,
    port = dbConfig.dbPort,
    user = dbConfig.dbUser,
    password = dbConfig.dbPassword,
    database = dbConfig.dbName
);

