# Represents a user entity in the database.
#
# + id - The unique identifier of the user
# + username - The username of the user
# + email - The email address of the user
# + age - The age of the user
# + created_at - The timestamp when the user was created
public type user record {|
    int id;
    string username;
    string email;
    int age;
    string created_at;
|};

# Represents the configuration details for connecting to the database.
#
# + dbHost - The host address of the database server
# + dbPort - The port number used to connect to the database
# + dbUser - The username for authenticating with the database
# + dbPassword - The password for authenticating with the database
# + dbName - The name of the database to connect to
type DatabaseConfig record {|
    string dbHost;
    int dbPort;
    string dbUser;
    string dbPassword;
    string dbName;
    
|};
