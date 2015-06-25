# Assignments API

## List all assignments

```
get /assignments
```

lists all assignments given ever.

##  Create an Assignment

```
post /assignments
```

creates a new assignment. required parameters are:

### Input

| Name | Type | Description |
|---|---|---|
| `title` | `string` | The title of the assignment | 

- title
- weekday 
  - format: w00d00
- due_date 
  - format: w00d00
- repo_url
  - a clonebale git repository url
- rubric_url


## `get /assignments/:id`

lists an assignment by both id and weekday value. As an example:

```
http://api.wdidc.org/assignments/1 

//or

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
