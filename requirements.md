Please keep in mind that one of the requirements for this task is extensive experience with recursive SQL queries.  If you're not exactly sure what they are - please reconsider your interest in this task.  

If you are curious what a recursive SQL query is - check out this youtube video ( https://www.youtube.com/watch?v=7hZYh9qXxe4 ). 

Here are the requirements for this task ...

- use PostgreSQL - version 13 or higher.

- write a recursive SQL query that queries two tables (resources and resource_data) and returns JSON that matches the JSON in the attached file ```results.json```
- the database consists of the following two tables ...
	- resources
       	- this table stores the description/definition of generic models

	- resource_data
    	- this table stores the actual data for models defined in the 'resources' table
    	   	
- both these tables can be generated with the following sql statements ...

```
-- DDL generated by Postico 1.5.19
-- Not all database features are supported. Do not use for backup.

-- Table Definition ----------------------------------------------

CREATE TABLE resources (
    id BIGSERIAL PRIMARY KEY,
    name character varying,
    version integer,
    schema jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX resources_pkey ON resources(id int8_ops);


-- DDL generated by Postico 1.5.19
-- Not all database features are supported. Do not use for backup.

-- Table Definition ----------------------------------------------

CREATE TABLE resource_data (
    id BIGSERIAL PRIMARY KEY,
    resource_id integer,
    data jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX resource_data_pkey ON resource_data(id int8_ops);

```

<br>
A file containing insert statements necessary to populate these two tables can be found in the attached file 'seed_data.sql'.  

I'm going to assume that you know how to ...
- create a database
- populate the database with the supplied 'seed' data


Understanding the data model of the two tables (```resources``` and ```resource_data```) is essential to performing this task.

The primary purpose of the ```resources``` table is store a definition of the models used by the system.  That definition is stored in the ```schema``` attribute.  Because the ```schema``` attribute is JSON - users are free to define an arbitrarily complex data model.  

The one I've defined in the supplied sample is relatively simple - but complex enough to make it interesting.  


<br>
The data model contained within the attached 'seed_data.sql' defines an ```Author``` object.  Here's the JSON definition of an ```Author``` ...

```
{
  "name": {
    "type": "string",
    "label": "Name",
    "accessor": "name",
    "is_association": false
  },
  "books": {
    "type": "array",
    "label": "Books",
    "accessor": "books",
    "is_association": true
  },
  "email": {
    "type": "string",
    "label": "Email",
    "accessor": "email",
    "is_association": false
  },
  "date_of_birth": {
    "type": "date",
    "label": "Birthday",
    "accessor": "date_of_birth",
    "is_association": false
  }
}
```

<br>
Attributes in any data model described in the ```resources``` table are defined using the same set of 'keys'.  They are ...
- 'type' - describes the data type of the attribute.  possibilities include ...
	- 'string'
	- 'integer'
	- 'date'
	- 'array'
		- this 'type' is the only one that needs additional explanation.  An attribute of type 'array' is designed to contain an array of ```ids``` of 'child' records (an example of a ```parent -> child``` relationship will be provided below)
	- 'label' - describes the label to use in a future user interface
	- 'accessor' - describes the name of the accessor that can be used to access the value associated with this attribute from its 'parent' object
	- 'is_association' - a boolean [true or false] indicating whether or not the current attribute describes a relationship between the current ('parent') object and a child (or set of child objects)
	
An Author can have one or more ```Book's```.  A ```Book``` has the following definition ...

```
{
  "name": {
    "type": "string",
    "label": "Name",
    "accessor": "name",
    "is_association": false
  },
  "reviews": {
    "type": "array",
    "label": "Reviews",
    "accessor": "reviews",
    "is_association": true
  },
  "author_id": {
    "type": "integer",
    "label": "Author",
    "accessor": "author_id",
    "is_association": false
  },
  "publishers": {
    "type": "array",
    "label": "Publishers",
    "accessor": "publishers",
    "is_association": true
  }
}

```
Just like with an Author - the attributes of a Book are defined as 'keys' within the object and the value of each 'key' are the properties of the respective attribute.  

One Book attribute that's worth mentioning is the ```author_id```.  This is the 'id' (aka the foreign_key) of the parent (Author) record

Each Book can have multiple ```Reviews``` and/or multiple ```Publishers```

A ```Review``` has the following definition ...

```
{
  "stars": {
    "type": "integer",
    "label": "Stars",
    "accessor": "stars",
    "is_association": false
  },
  "review": {
    "type": "string",
    "label": "Review",
    "accessor": "review",
    "is_association": false
  }
}
```

A ```Publisher``` has the following definition ...

```
{
  "date": {
    "type": "date",
    "label": "Date",
    "accessor": "date",
    "is_association": false
  },
  "name": {
    "type": "string",
    "label": "Name",
    "accessor": "name",
    "is_association": false
  }
}
```

<br>

Examining in more detail the ```parent -> child``` relationship between two sets of objects will be helpful in understanding the data model and the task at large.  

Up until now - I've focused primarily on describing the data in the ```resources``` table.  As mentioned above - this table contains the definition of the available 'models'.

The ```resource_data``` table stores the actual data associated with objects.

For example - consider the following ```resource_data``` table record for an ```Author``` ...

```
id	resource_id	data	created_at	updated_at
15	3	{"name": "Stephen King", "books": [16, 17, 18, 19], "email": "stephen.king@gmail.com", "date_of_birth": "1947-09-21"}	2022-04-05 00:15:50.049241	2022-04-05 00:15:50.064113
```

- 15 - represents the 'id' of this ```resource_data``` record
- 3 - represents the 'resource_id' associated with this record.  If you look at the data for the ```resources``` table - you'll see that the record with id 3 is this ```Author``` record...

```{"name": "Stephen King", "books": [16, 17, 18, 19], "email": "stephen.king@gmail.com", "date_of_birth": "1947-09-21"}``` 

NOTE: this is the ACTUAL author data for this ```Author``` object

<br>
If you look at the ```value``` associated with the ```books``` key - you'll see an array of numbers.  Those are the actual 'ids' of the 'child' ```Book``` objects belonging to this ```Author```.  If you lookup the ```resource_data``` records with each of those ids ```[16,17,18,19]``` - you'll see the ```resource_data``` records with the following 'data' values ...
	
```
16	6	{"name": "Carrie", "reviews": [20, 21], "author_id": 15, "publishers": [22]}	2022-04-05 00:15:50.052548	2022-04-05 00:15:50.090448
17	6	{"name": "The Shining", "reviews": [], "author_id": 15, "publishers": [23]}	2022-04-05 00:15:50.055954	2022-04-05 00:15:50.09248
18	6	{"name": "The Stand", "reviews": [], "author_id": 15, "publishers": [24]}	2022-04-05 00:15:50.059299	2022-04-05 00:15:50.094905
19	6	{"name": "The Dark Tower", "reviews": [], "author_id": 15, "publishers": [25]}	2022-04-05 00:15:50.062536	2022-04-05 00:15:50.09696
```

<br>
Finally - if you look at the ```results.json``` file ...

```
[
  {
    "id": 11,
    "books": [
      {
        "id": 12,
        "reviews": [
        ],
        "publishers": [
        ],
        "name": "Dune"
      },
      {
        "id": 13,
        "reviews": [
        ],
        "publishers": [
        ],
        "name": "Dune Messiah"
      },
      {
        "id": 14,
        "reviews": [
        ],
        "publishers": [
        ],
        "name": "Children of Dune"
      }
    ],
    "name": "Frank Herbert",
    "email": "frank.herbert@gmail.com",
    "date_of_birth": "1920-10-08"
  },
  {
    "id": 15,
    "books": [
      {
        "id": 16,
        "reviews": [
          {
            "id": 20,
            "stars": 5,
            "review": "Couldn't sleep for a week - amazing writing !!!"
          },
          {
            "id": 21,
            "stars": 4,
            "review": "A real 'page turner'"
          }
        ],
        "publishers": [
          {
            "id": 22,
            "date": "1974-04-01",
            "name": "Simon And Shuster"
          }
        ],
        "name": "Carrie"
      },
      {
        "id": 17,
        "reviews": [
        ],
        "publishers": [
          {
            "id": 23,
            "date": "1977-01-01",
            "name": "Simon And Shuster"
          }
        ],
        "name": "The Shining"
      },
      {
        "id": 18,
        "reviews": [
        ],
        "publishers": [
          {
            "id": 24,
            "date": "1978-10-01",
            "name": "John Wiley & Sons"
          }
        ],
        "name": "The Stand"
      },
      {
        "id": 19,
        "reviews": [
        ],
        "publishers": [
          {
            "id": 25,
            "date": "2004-09-01",
            "name": "HarperCollins"
          }
        ],
        "name": "The Dark Tower"
      }
    ],
    "name": "Stephen King",
    "email": "stephen.king@gmail.com",
    "date_of_birth": "1947-09-21"
  }
]
```

<br>
You will see all the ```child``` data associated with each respective ```parent```.  

Unlike the data stored in the database - child ```ids``` are replaced by the actual ```child``` data.  This is because this data is meant to be consumed by front-end web apps and supplying the actual data as opposed to the database record ```ids``` reducesthe amount of queries the front-end has to make of the back-end in order to retrieve the data it needs.
<br>
<br>
Again - the goal of this job is to create a recursive (PostgreSQL) SQL query which generates JSON matching that found in the attached ```results.json``` file.

------------------------------------------------------------------------
Original craigslist post:
https://sfbay.craigslist.org/sfc/cpg/d/san-francisco-looking-for-db-postgresql/7467128374.html
About craigslist mail:
https://craigslist.org/about/help/email-relay
Please flag unwanted messages (spam, scam, other):
https://post.craigslist.org/mailflag?flagCode=34&smtpid=5b1e216b2ef776b02cd64295841aa1a554ebc622.1
------------------------------------------------------------------------