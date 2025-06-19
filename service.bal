import ballerina/http;
import ballerina/lang.value;
import user_management.database;
import ballerina/sql;

service / on new http:Listener(8080) {

    resource function post users(http:Caller caller, http:Request req) returns error? {
        json payload = check req.getJsonPayload();
        string username = value:toJsonString(check payload.username);
        string email = value:toJsonString(check payload.email);
        int age = <int> check payload.age;

        sql:ExecutionResult result =  check database:insertUser(username, email, age);

        http:Response res = new;
        res.statusCode = http:STATUS_CREATED;
        res.setPayload({ message: "User created", user: payload });
        check caller->respond(res);
    }

    resource function get users/[int id](http:Caller caller, http:Request req) returns error? {
        database:user[] users = check database:getUserById(id);
        if users.length() > 0 {
            check caller->respond(users[0]);
        } else {
            http:Response res = new;
            res.statusCode = http:STATUS_NOT_FOUND;
            res.setPayload({ message: "User not found" });
            check caller->respond(res);
        }
    }

    resource function get users(http:Caller caller, http:Request req) returns error? {
        string? search = req.getQueryParamValue("username");
        database:user[] users = check database:searchUsers(search);
        check caller->respond(users);
    }

    resource function put users/[int id](http:Caller caller, http:Request req) returns error? {
        json payload = check req.getJsonPayload();
        string name = <string> check payload.username;
        string email = <string> check payload.email;
        int age = <int> check payload.age;

        sql:ExecutionResult result = check database:updateUser(id, name, email, age);

        http:Response res = new;
        res.setPayload({ message: "User updated", user: payload });
        check caller->respond(res);
    }

    resource function delete users/[int id](http:Caller caller) returns error? {
        sql:ExecutionResult result = check database:deleteUser(id);
        http:Response res = new;
        res.setPayload({ message: "User deleted", id: id });
        check caller->respond(res);
    }
}
