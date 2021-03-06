#MySQL Exercise 1: Welcome to your first notebook!¶


/*The first thing you should do every time you start working with a database: load the SQL library*/

#load sql library
%load_ext sql


/*The second thing you must do every time you want to start working with a database: connect to the database you need to use.*/

%sql mysql://studentuser:studentpw@mysqlserver/dognitiondb

/*The third thing you should do every time you start working with a new database: get to know your data*/

%sql SHOW tables

SHOW columns FROM (enter table name here)

/*or if you have multiple databases loaded:*/
SHOW columns FROM (enter table name here) FROM (enter database name here)

/*An alternate way to learn the same information would be to use the DESCRIBE function. The syntax is:
*/

%sql DESCRIBE complete_tests

%sql DESCRIBE exam_answers

%sql DESCRIBE site_activities


%%sql
SELECT breed
FROM dogs;

/*10 rows of data will be returned, starting at Row 6.*/
SELECT breed
FROM dogs LIMIT 10 OFFSET 5;

SELECT breed
FROM dogs LIMIT 5, 10;


/*Using SELECT to query multiple columns*/
SELECT breed, breed_type, breed_group
FROM dogs LIMIT 5, 10;


SELECT *
FROM dogs LIMIT 5, 10;

/*Question 9: Go ahead and try it, adding in a column to your 
output that shows you the original median_iti in minutes.*/
SELECT median_iti_minutes / 60
FROM dogs LIMIT 5, 10;

/*Question 10: How would you retrieve the first 15
 rows of data from the dog_guid, subcategory_name,
 and test_name fields of the Reviews table, in that order?*/
SELECT dog_guid, subcategory_name, test_name
FROM reviews LIMIT 15

/*
Question 11: How would you retrieve 10 rows of data from
the activity_type, created_at, and updated_at fields of the 
site_activities table, starting at row 50? What do you notice
 about the created_at and updated_at fields?*/
 SELECT activity_type, created_at, updated_at
FROM site_activities LIMIT 10 OFFSET 50


/*Question 12: How would you retrieve 20 rows of data 
from all the columns in the users table, starting from row 
2000? What do you notice about the free_start_user field?*/
SELECT *
FROM users
LIMIT 20 OFFSET 2000