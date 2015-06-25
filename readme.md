# Assignments API

## Authentication

You can read public assignments without a token; however, to create, update, and delete assignments on a user’s behalf an access token is required as a query parameter
with the key `access_token`.

You can generate an access token at https://github.com/settings/tokens/new for testing purposes.

## List all assignments

```
GET /assignments
```

lists all assignments given ever.

##  Create an Assignment

```
POST /assignments
```

creates a new assignment. required parameters are:

### Input

| Name | Type | Description |
|---|---|---|
| `title` | `string` | **Required.** The title of the assignment | 
| `weekday` | `string` | **Required.** The weekday of the assignment of format w00d00 | 
| `repo_url` | `string` | **Required.** The git cloneable repository url of the assignment |
| `due_date` | `string` | The due date of the assignment of format w00d00 | 
| `rubric_url` | `string` | A link to the rubric of the assignment | 

## Get a single assignment

```
GET /assignments/:id
```

lists an assignment by both id and weekday value. As an example:

```
http://api.wdidc.org/assignments/1 
```

or

```
http://api.wdidc.org/assignments/w03d02
```

## Local Setup

    $ git clone git@github.com:wdidc/api-assignment.git
    $ cd api-assignment
    $ bundle install
    $ rake db:create
    $ rake db:migrate
    $ rake db:seed
    $ rails s
