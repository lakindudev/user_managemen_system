import ballerina/sql;

public function insertUser(string name, string email, int age) returns sql:ExecutionResult|error {
    sql:ParameterizedQuery query = addUserQuery(name, email, age);
    return dbClient->execute(query);
}

# Description.
#
# + id - parameter description
# + return - return value description
public function getUserById(int id) returns user[]|error {
    sql:ParameterizedQuery query = getUserByIdQuery(id);
    stream<user, sql:Error?> resultStream = dbClient->query(query);
    user[] users = [];
    check from user u in resultStream do {
        users.push(u);
    };
    return users;
}

# Description.
#
# + username - parameter description
# + return - return value description
public function searchUsers(string? username) returns user[]|error {
    sql:ParameterizedQuery query = searchUsersQuery(username);

    stream<user, sql:Error?> resultStream = dbClient->query(query);
    user[] users = [];
    check from user u in resultStream do {
        users.push(u);
    };
    return users;
}

# Description.
#
# + id - parameter description  
# + name - parameter description  
# + email - parameter description  
# + age - parameter description
# + return - return value description
public function updateUser(int id, string name, string email, int age) returns sql:ExecutionResult|error {
    sql:ParameterizedQuery query = updateUserQuery(id,name,email,age);
    return dbClient->execute(query);
}

# Description.
#
# + id - parameter description
# + return - return value description
public function deleteUser(int id) returns sql:ExecutionResult|error {
    sql:ParameterizedQuery query = deleteUserQuery(id);
    return dbClient->execute(query);
}
