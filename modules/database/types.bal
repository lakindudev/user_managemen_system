public type user record {|
    int id;
    string username;
    string email;
    int age;
    string created_at;
|};

type DatabaseConfig record {|
# Host of the database
    string dbHost;
    # Port
    int dbPort;
    # User of the database
    string dbUser;
    # Password of the database
    string dbPassword;
    # Name of the database
    string dbName;
    
|};
