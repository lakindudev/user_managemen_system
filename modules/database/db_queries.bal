import ballerina/sql;

# Constructs a parameterized query to insert a new user into the database.
#
# + name - The username of the user to be inserted
# + email - The email address of the user
# + age - The age of the user
# + return - A parameterized SQL query for inserting a user
public isolated function addUserQuery(string name, string email, int age) returns sql:ParameterizedQuery {
    return `INSERT INTO user (username, email, age) VALUES (${name}, ${email}, ${age})`;
}

# Constructs a parameterized query to retrieve a user from the database by their ID.
#
# + id - The unique identifier of the user to retrieve
# + return - A parameterized SQL query for selecting a user by ID
public isolated function getUserByIdQuery(int id) returns sql:ParameterizedQuery {
    return `SELECT * FROM user WHERE id = ${id}`;
}

# Constructs a parameterized query to retrieve all users or filter by username if provided.
#
# + username - An optional username to filter the search; if null, all users are retrieved
# + return - A parameterized SQL query for selecting users, with optional username filtering
public isolated function searchUsersQuery(string? username) returns sql:ParameterizedQuery {
    if username is string {
        return `SELECT * FROM user WHERE username LIKE ${"%" + username + "%"}`;
    }
    return `SELECT * FROM user`;
}

# Constructs a parameterized query to update a user's details in the database by their ID.
#
# + id - The unique identifier of the user to update
# + name - The updated username
# + email - The updated email address
# + age - The updated age
# + return - A parameterized SQL query for updating a user's details
public isolated function updateUserQuery(int id, string name, string email, int age) returns sql:ParameterizedQuery {
    return `UPDATE user SET username = ${name}, email = ${email}, age = ${age} WHERE id = ${id}`;
}

# Constructs a parameterized query to delete a user from the database by their ID.
#
# + id - The unique identifier of the user to delete
# + return - A parameterized SQL query for deleting a user by ID
public isolated function deleteUserQuery(int id) returns sql:ParameterizedQuery {
    return `DELETE FROM user WHERE id = ${id}`;
}


