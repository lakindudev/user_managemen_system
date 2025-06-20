import ballerina/sql;

# Inserts a new user into the database.
#
# + name - The username of the user to be inserted 
# + email - The email address of the user 
# + age - The age of the user
# + return - The result of the SQL execution or an error if the operation fails
public function insertUser(string name, string email, int age) returns sql:ExecutionResult|error {
    sql:ParameterizedQuery query = addUserQuery(name, email, age);
    return dbClient->execute(query);
}

# Retrieves a user from the database by their ID.
#
# + id - The unique identifier of the user to retrieve
# + return - An array of user records (expected to contain one user) or an error if the query fails
public function getUserById(int id) returns user[]|error {
    sql:ParameterizedQuery query = getUserByIdQuery(id);
    stream<user, sql:Error?> resultStream = dbClient->query(query);
    user[] users = [];
    check from user u in resultStream do {
        users.push(u);
    };
    return users;
}

# Searches for users in the database, optionally filtering by username.
#
# + username - An optional username to filter the search; if null, all users are returned
# + return - An array of user records matching the search criteria or an error if the query fails
public function searchUsers(string? username) returns user[]|error {
    sql:ParameterizedQuery query = searchUsersQuery(username);

    stream<user, sql:Error?> resultStream = dbClient->query(query);
    user[] users = [];
    check from user u in resultStream do {
        users.push(u);
    };
    return users;
}

# Updates an existing user's details in the database.
#
# + id - The unique identifier of the user to update
# + name - The updated username
# + email - The updated email address
# + age - The updated age
# + return - The result of the SQL execution or an error if the operation fails
public function updateUser(int id, string name, string email, int age) returns sql:ExecutionResult|error {
    sql:ParameterizedQuery query = updateUserQuery(id,name,email,age);
    return dbClient->execute(query);
}

#  Deletes a user from the database by their ID.
#
# + id - The unique identifier of the user to delete
# + return - he result of the SQL execution or an error if the operation fails
public function deleteUser(int id) returns sql:ExecutionResult|error {
    sql:ParameterizedQuery query = deleteUserQuery(id);
    return dbClient->execute(query);
}
