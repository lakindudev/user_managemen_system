import ballerina/http;
import ballerina/lang.value;
import user_management.database;
import ballerina/sql;

// Define an HTTP service listening on port 8080
service / on new http:Listener(8080) {

    #  Handles POST requests to create a new user in the database
    # + caller - The HTTP caller to send the response
    # + req - The HTTP request containing user data in JSON format
    # + return - An error if the operation fails, otherwise nil
    resource function post users(http:Caller caller, http:Request req) returns error? {
        json payload = check req.getJsonPayload();
        // Extract username, email, and age from the payload, ensuring type safety
        string username = value:toJsonString(check payload.username);
        string email = value:toJsonString(check payload.email);
        int age = <int> check payload.age;

        // Insert the user into the database using the insertUser function
        sql:ExecutionResult _ =  check database:insertUser(username, email, age);

        http:Response res = new;
        res.statusCode = http:STATUS_CREATED;
        // Set response payload with a success message and the created user data
        res.setPayload({ message: "User created", user: payload });
        check caller->respond(res);
    }

    # Handles GET requests to retrieve a user by their unique ID
    # + caller - The HTTP caller to send the response
    # + req - The HTTP request
    # + id - The unique identifier of the user to retrieve
    # + return - An error if the operation fails, otherwise nil
    resource function get users/[int id](http:Caller caller, http:Request req) returns error? {
        database:user[] users = check database:getUserById(id);
        // Check if a user was found
        if users.length() > 0 {
            // Respond with the first user in the result (should be only one)
            check caller->respond(users[0]);
        } else {
            http:Response res = new;
            // Set response payload with an error message
            res.statusCode = http:STATUS_NOT_FOUND;
            res.setPayload({ message: "User not found" });
            check caller->respond(res);
        }
    }

    # Handles GET requests to retrieve users, optionally filtered by username
    # + caller - The HTTP caller to send the response
    # + req - The HTTP request containing optional query parameters
    # + return - An error if the operation fails, otherwise nil
    resource function get users(http:Caller caller, http:Request req) returns error? {
        // Get the optional 'username' query parameter from the request
        string? search = req.getQueryParamValue("username");
        // Search the database for users, applying the username filter if provided
        database:user[] users = check database:searchUsers(search);
        check caller->respond(users);
    }

    # Handles PUT requests to update an existing user’s details
    # + caller - The HTTP caller to send the response
    # + req - The HTTP request containing updated user data in JSON format
    # + id - The unique identifier of the user to update
    # + return - An error if the operation fails, otherwise nil
    resource function put users/[int id](http:Caller caller, http:Request req) returns error? {
        json payload = check req.getJsonPayload();
        // Extract username, email, and age from the payload, ensuring type safety
        string name = <string> check payload.username;
        string email = <string> check payload.email;
        int age = <int> check payload.age;

        // Update the user in the database using the updateUser function
        sql:ExecutionResult _ = check database:updateUser(id, name, email, age);

        http:Response res = new;
        res.setPayload({ message: "User updated", user: payload });
        check caller->respond(res);
    }

    # Handles DELETE requests to remove a user by their ID
    # + caller - The HTTP caller to send the response
    # + id - The unique identifier of the user to delete
    # + return - An error if the operation fails, otherwise nil
    resource function delete users/[int id](http:Caller caller) returns error? {
        // Delete the user from the database using the deleteUser function
        sql:ExecutionResult _ = check database:deleteUser(id);
        http:Response res = new;
        res.setPayload({ message: "User deleted", id: id });
        check caller->respond(res);
    }
}
