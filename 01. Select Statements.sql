#load sql
%load_ext sql

#connect to database
%sql mysql://studentuser:studentpw@mysqlserver/dognitiondb

#Once you are connected, the output cell (which reads "Out" followed by brackets) will read: "Connected:studentuser@dognitiondb". To make this the default database for our queries, run this "USE" command:
%sql USE dognitiondb


%sql SHOW tables

%sql SHOW columns FROM dogs

%sql DESCRIBE reviews

%sql DESCRIBE complete_tests

%sql DESCRIBE exam_answers

%sql DESCRIBE site_activities

%sql DESCRIBE users

"""
Using SELECT to look at your raw data
SELECT is used anytime you want to retrieve data from a table. In order to retrieve that data, you always have to provide at least two pieces of information:
(1) what you want to select, and      
(2) from where you want to select it.  

The skeleton of a SELECT statement looks like this:
SELECT
FROM

An important note for executing queries in Jupyter: in order to tell Python that you want to execute SQL language on multiple lines, you must include two percent signs in front of the SQL prefix instead of one.
%%sql


You can also select rows of data from different parts of the output table, rather than always just starting at the beginning. To do this, use the OFFSET clause after LIMIT. The number after the OFFSET clause indicates from which row the output will begin querying. Note that the offset of Row 1 of a table is actually 0. Therefore, in the following query:

SELECT breed
FROM dogs LIMIT 10 OFFSET 5;

10 rows of data will be returned, starting at Row 6.

An alternative way to write the OFFSET clause in the query is:
SELECT breed
FROM dogs LIMIT 5, 10;
In this notation, the offset is the number before the comma, and the number of rows returned is the number after the comma.
"""


%%sql
SELECT breed
FROM dogs LIMIT 5, 10;

#Using SELECT to query multiple columns
%%sql
SELECT *
FROM dogs LIMIT 5, 10;

#multiple columns
%%sql
SELECT dog_guid, subcategory_name, test_name
FROM reviews LIMIT 15

%%sql
SELECT activity_type, created_at, updated_at
FROM site_activities LIMIT 10 OFFSET 50

#How would you retrieve 20 rows of data from all
#the columns in the users table, starting from row 2000?
%%sql
SELECT *
FROM users
LIMIT 20 OFFSET 2000


The first thing you should do every time you start working with a database: load the SQL library
Since Jupyter is run through Python, the first thing you need to do to start practicing SQL queries is load the SQL library. To do this, type the following line of code into the empty cell below:
%load_ext sql


%sql SHOW tables

The syntax, which sounds very similar to what you would actually say in the spoken English language, looks like this:

SHOW columns FROM (enter table name here)

or if you have multiple databases loaded:

SHOW columns FROM (enter table name here) FROM (enter database name here)
or

SHOW columns FROM databasename.tablename

%sql SHOW columns FROM dogs

DESCRIBE tablename
%sql DESCRIBE reviews

EXAMPLE:
The following SQL statement selects all the columns from the "Customers" table:
SELECT * FROM Customers;

%%sql
SELECT user_guid, free_start_user
FROM users
WHERE free_start_user=1
LIMIT 5

/*How would you select the Dog IDs for the dogs
in the Dognition data set that were DNA tested
(these should have a 1 in the dna_tested field
of the dogs table)? Try it below (if you do not
limit your output, your query should output data
from 1433 dogs):*/
%%sql
SELECT dog_guid
FROM dogs
WHERE dna_tested=1
LIMIT 5

/*How would you query the User IDs of customers
who bought annual subscriptions, indicated by
a "2" in the membership_type field of the users
table? (If you do not limit the output of this
query, your output should contain 4919 rows.)*/

%sql SHOW columns FROM users

%%sql
SELECT user_guid
FROM users
WHERE membership_type=2
LIMIT 10

"""
/*Strings enclosed in quotation or backticks can be used with many of the same operators as numerical data. For example, imagine that you only wanted to look at data from dogs of the breed "Golden Retrievers." You could query (note that double quotation marks could have been used in this example is well):

SELECT dog_guid, breed
FROM dogs
WHERE breed='golden retriever';

The IN operator allows you to specify multiple values in a WHERE clause. Each of these values must be separated by a comma from the other values, and the entire list of values should be enclosed in parentheses. If you wanted to look at all the data from Golden Retrievers and Poodles, you could certainly use the OR operator, but the IN operator would be even more efficient (note that single quotation marks could have been used in this example, too):

SELECT dog_guid, breed
FROM dogs
WHERE breed IN ("golden retriever","poodle");

The LIKE operator allows you to specify a pattern that the textual data you query has to match. For example, if you wanted to look at all the data from breeds whose names started with "s", you could query:

SELECT dog_guid, breed
FROM dogs
WHERE breed LIKE ("s%");

In this syntax, the percent sign indicates a wild card. Wild cards represent unlimited numbers of missing letters. This is how the placement of the percent sign would affect the results of the query:
WHERE breed LIKE ("s%") = the breed must start with "s", but can have any number of letters after the "s"
WHERE breed LIKE ("%s") = the breed must end with "s", but can have any number of letters before the "s"
WHERE breed LIKE ("%s%") = the breed must contain an "s" somewhere in its name, 
but can have any number of letters before or after the "s"
*/
"""

/* How would you query all the data from customers 
located in the state of North Carolina (abbreviated "NC")
or New York (abbreviated "NY")? If you do not limit
the output of this query, your output should contain 1333 rows.
*/

%%sql
SELECT *
FROM users
WHERE state IN ("NC", "NY")
LIMIT 10

/*Question 4: Now that you have seen how datetime data can be used to impose criteria on the data
you select, how would you select all the Dog IDs and time stamps of Dognition tests completed before 
October 15, 2015 (your output should have 193,246 rows)?
*/
%%sql
SELECT dog_guid, created_at
FROM complete_tests
WHERE created_at < '2015-10-15'
LIMIT 10


%%sql
SELECT COUNT(*)
FROM
(SELECT dog_guid, created_at
FROM complete_tests
WHERE created_at < '2015-10-15')
myNewTable;


/***Question 5: How would you select all the User IDs of customers who do not have null 
values in the State field of their demographic information (if you do not limit the output, 
you should get 17,985 from this query -- there are a lot of null values in the state field!)?**
*/

%%sql
SELECT COUNT(*)
FROM
(SELECT user_guid
FROM users
WHERE state IS NOT NULL)
myNewTable;


/*Question 6: How would you retrieve the Dog ID, subcategory_name, and test_name fields,
in that order, of the first 10 reviews entered in the Reviews table to be submitted in 2014?
*/
%%sql
SHOW columns FROM reviews

%%sql
SELECT dog_guid, subcategory_name, test_name, created_at
FROM reviews
WHERE created_at  > '2014-01-01'
LIMIT 10;

/*
Question 7: How would you select all of the User IDs of customers who have
 female dogs whose breed includes the word "terrier" somewhere in its name
  (if you don't limit your output, you should have 1771 rows in your output)?
*/

%%sql
SHOW columns FROM users

SHOW columns FROM dogs

#variables include: gender ("female" or "male"), breed, user_guid

%%sql
SELECT user_guid, gender, breed
FROM dogs
WHERE gender ="female" AND breed  LIKE ("%terrier%");

/*Question 8: How would you select the Dog ID, test name, 
and subcategory associated with each completed test for
 the first 100 tests entered in October, 2014?*/
 
%%sql
SELECT dog_guid, test_name, subcategory_name
FROM complete_tests
WHERE created_at  BETWEEN '2014-10-01' AND  '2014-10-31'
LIMIT 100;