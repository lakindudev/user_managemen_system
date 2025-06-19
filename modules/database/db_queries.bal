import ballerina/sql;

/// Constructs a query to insert a new user.
public isolated function addUserQuery(string name, string email, int age) returns sql:ParameterizedQuery {
    return `INSERT INTO user (username, email, age) VALUES (${name}, ${email}, ${age})`;
}

/// Constructs a query to retrieve a user by ID.
public isolated function getUserByIdQuery(int id) returns sql:ParameterizedQuery {
    return `SELECT * FROM user WHERE id = ${id}`;
}

/// Constructs a query to retrieve all users or filter by username if provided.
public isolated function searchUsersQuery(string? username) returns sql:ParameterizedQuery {
    if username is string {
        return `SELECT * FROM user WHERE username LIKE ${"%" + username + "%"}`;
    }
    return `SELECT * FROM user`;
}

/// Constructs a query to update user details by ID.
public isolated function updateUserQuery(int id, string name, string email, int age) returns sql:ParameterizedQuery {
    return `UPDATE user SET username = ${name}, email = ${email}, age = ${age} WHERE id = ${id}`;
}

/// Constructs a query to delete a user by ID.
public isolated function deleteUserQuery(int id) returns sql:ParameterizedQuery {
    return `DELETE FROM user WHERE id = ${id}`;
}


