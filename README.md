# User Management REST Service

## Overview
This is a simple CRUD (Create, Read, Update, Delete) REST service built with Ballerina, designed to manage user data in a MySQL database. The service provides endpoints to insert, retrieve, search, update, and delete user records, with proper error handling and JSON-based request/response payloads.

## Prerequisites
To run this service, ensure you have the following installed:

- Ballerina: Version 2201.8.0 or later (Swan Lake). Install from Ballerina Downloads.
- MySQL Database: A running MySQL server (version 8.0 or later recommended).
- MySQL Connector for Ballerina: Included via the ballerinax/mysql module.

## Project Structure
The project consists of the following key files:

- main.bal: Defines the HTTP service with REST endpoints for user management.
- database.bal: Contains database interaction functions (insert, get, search, update, delete).
- queries.bal: Defines parameterized SQL queries for database operations.
- types.bal: Defines the user and DatabaseConfig record types.
- Ballerina.toml: Project configuration file specifying dependencies.
- Config.toml: Configuration file for database connection settings.

## Setup Instructions


### 1. Clone the Repository

```bash
git clone <repository-url>
cd user-management-service
```

### 2. Set Up the MySQL Database:

- Create a MySQL database (e.g., user_db).
- Execute the following SQL to create the user table:
```sql
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```




### 3.Configure Database Connection:

- Create a Config.toml file in the project root with the following content:
```toml
[user_management.database.dbConfig]
dbHost = "localhost"
dbPort = 3306
dbUser = "your_username"
dbPassword = "your_password"
dbName = "user_db"
```

- Replace your_username, your_password, and user_db with your MySQL credentials and database name.


### 4.Install Dependencies:

- Ensure the ballerinax/mysql module is included in Ballerina.toml:
```toml
[dependencies]
"ballerinax/mysql" = "1.10.0"
```

### 5.Run the Service:

- Execute the following command from the project root:

```bash
bal run
```


- The service will start on http://localhost:8080.



# API Endpoints
The service exposes the following REST endpoints under the base path /users:
1. Create a User

- Method: POST /users
- Request Body:
```json
{
    "username": "string",
    "email": "string",
    "age": 0
}
```


## Response:
- 201 Created: { "message": "User created", "user": {...} }
- 400 Bad Request: If the payload is invalid.


- Example:
```bash
curl -X POST http://localhost:8080/users -H "Content-Type: application/json" -d '{"username":"john_doe","email":"john@example.com","age":30}'
```


## 2. Get a User by ID

- Method: GET /users/{id}
- Response:
-  200 OK: User record as JSON.
-  404 Not Found: { "message": "User not found" } if no user exists.


- Example:
```bash 
curl http://localhost:8080/users/1
```


## 3. Search Users

- Method: GET /users?username={search_term}
- Query Parameter: username (optional) to filter by username.
- Response: Array of user records.
- Example:
```bash
curl http://localhost:8080/users?username=john
```


## 4. Update a User

- Method: PUT /users/{id}
```bash
Request Body:{
    "username": "string",
    "email": "string",
    "age": integer
}
```


- Response:
```bash
200 OK: { "message": "User updated", "user": {...} }
400 Bad Request: If the payload is invalid.
```


- Example:
```bash
curl -X PUT http://localhost:8080/users/1 -H "Content-Type: application/json" -d '{"username":"john_updated","email":"john_new@example.com","age":31}'
```


## 5. Delete a User

- Method: DELETE /users/{id}
- Response:
200 OK: { "message": "User deleted", "id": integer }


- Example:
```bash
curl -X DELETE http://localhost:8080/users/1
```





