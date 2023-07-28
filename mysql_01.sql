/*markdown
# MySQL 01 - Overview
This overview will show quick examples on some MySQL commands and features. Formatting and styling may be inconsistent at first and may evolve overtime as I adopt this [SQL style guide](https://github.com/mattm/sql-style-guide).
*/

/*markdown
## Database
*/

/*markdown
### Database Basics
*/

-- This cell is not meant to be run. This is for syntax

-- Display all databases in server.
SHOW DATABASES;

-- Create an empty database.
CREATE DATABASE <db_name>;

-- Delete database. This can't be undone (normally), be careful.
DROP DATABASE <db_name>;

-- Delete database. This can't be undone (normally), be careful.
DROP DATABASE <db_name>;

-- Select database and make it the current active database.
-- Most commands and SQL statements only works after this step.
USE <db_name>;

-- See what database is currently active.
SELECT DATABASE();

/*markdown
### Database Basics - Example
*/

-- Displays all databases in server.
SHOW DATABASES;

-- Create two databases.
CREATE DATABASE pet_shelter;
CREATE DATABASE bad_database;

-- Confirm if databases are now on the list.
SHOW DATABASES;

-- Delete bad_database.
DROP DATABASE bad_database;

-- Confirm that bad_database has been deleted.
SHOW DATABASES;

-- Select database.
USE pet_shelter;

-- Confirm that database is now the active one.
SELECT DATABASE();
-- We can now run SQL statements on our pet_shelter database!

/*markdown
## Tables
*/

/*markdown
### Creating Tables
*/

-- Create table inside database.
CREATE TABLE <table_name> (
    <field_1> <field1_data_type>,
    <field_2> <field2_data_type>
);
-- Field is just an SQL term for columns.

/*markdown
### Creating Tables - Example
*/

-- Create a table named cats inside our pet_shelter database.
-- The cats table will have 2 fields, name and age, with the data type
-- VARCHAR and INT, respectively.
CREATE TABLE cats (
    name VARCHAR(50),
    age INT
);

-- Create a table for the sole purpose of being deleted later.
CREATE TABLE wrong_table (
    some_name VARCHAR(25),
    some_number int
);

/*markdown
### Other Table Commands
*/

-- Show tables in currently active database.
SHOW TABLES;

-- Show table information.
SHOW COLUMNS FROM <table_name>;
-- Alternatively, we can use the DESCRIBE or DESC keyword.
DESCRIBE <table_name>;
DESC <table_name>;

/*markdown
### Other Table Commands - Example
*/

SHOW TABLES;

-- Show relevant information about the cats table.
DESC cats;

/*markdown
### Inserting (Adding) Data to Table
This is discussed more in the next chapter and is only discussed here for the purpose of the succeeding topics (default and null values).
*/

INSERT INTO <table_name> (
    <field_1>,
    <field_2>
)
VALUES (
    <field1_value>,
    <field2_value>
);

/*markdown
### Inserting (Adding) Data to Table - Example
*/

INSERT INTO cats (
    name,
    age
)
VALUES (
    'Tabby',
    3
);

/*markdown
### Dropping (Deleting) Tables
*/

-- Delete a table. Be careful as there is no confirmation and 
-- this can't be undone in normal circumstances.
DROP TABLE <table_name>;

-- Deleting from a specific database. This works even if the database is
-- not currently active.
-- Note that backticks ( ` ) are used, not apostrophes ( ' ).
DROP TABLE `<db_name>`.`<table_name>`;

/*markdown
### Dropping (Deleting) Tables - Example
*/

DROP TABLE wrong_table;

-- Confirm wrong_table is no longer on the list.
SHOW TABLES;

/*markdown
## Null and Default Values
NULL, NaN, or NA values are empty or unknown values. This occurs for a variety of reasons, most commonly by not entering a value for a field, or errors (both human or system).
*/

/*markdown
### NOT NULL Keyword
The NOT NULL keyword will forbid NULL values in the field. This will reject adding in records containing a NULL value in the constrained field.
*/

-- Create a table with 2 fields field_1 and field_2.
-- field_1 will not allow NULL values, but field_2 will.
CREATE TABLE <table_name> (
    <field_1> <field1_data_type> NOT NULL,
    <field_2> <field2_data_type>
);

/*markdown
### NOT NULL Keyword - Example
*/

-- Create a cats2 table where only the breed field can be NULL.
CREATE TABLE cats2 (
    name VARCHAR(100) NOT NULL,
    breed VARCHAR(100)
);

/*markdown
### Field Default Value
We can create a default value for a field if no value is provided for that field.
*/

CREATE TABLE <table_name> (
    <field> <field_type> DEFAULT <default_value>
);

-- The DEFAULT keyword can also be used to insert the default value, when possible.
INSERT INTO <table_name> (
    <field_1>,
    <field_2>
)
VALUES (
    DEFAULT,
    <field2_value>
);

/*markdown
### Field Default Value - Example
*/

-- Create a cats3 table where the age is defaulted to 0 if no age is provided.
CREATE TABLE cats3 (
    name VARCHAR(100),
    age INT DEFAULT 0
);

INSERT INTO cats3 (
    name,
    age
)
VALUES (
    'Tabby',
    DEFAULT
);

-- The above example can also be done by omitting the field with a default value.
INSERT INTO cats3 (
    name
)
VALUES (
    'Tabby'
);

/*markdown
## Primary Key
Primary keys are unique identifiers for records in a table. This is useful when two or more entries share the same value for a field. For example, if there are two cats having the same name in our table, the primary keys will allow us to distinguish between the two.  
Note that although primary keys can be of any data type, it is a convention for a primary key to be of integer type (specific int size might vary according to size of table), since it is faster and can be used in tandem with the AUTO_INCREMENT keyword.
*/

/*markdown
### Creating a Primary Key Field
*/

-- There are two common ways to initialize a primary key field.
-- Say we want field_1 to be the primary key:
CREATE TABLE <table_name> (
    <field_1> <int_type> PRIMARY KEY,
    <field_2> <field2_type>
);

-- Or we can declare our primary key field separately:
CREATE TABLE <table_name> (
    <field_1> <int_type>,
    <field_2> <field2_type>,
    PRIMARY KEY (<field_1>)
);
-- Notice that there is no NOT NULL constraint for the key field.
-- This is because primary keys can never be null in the first place,
-- making the NOT NULL keyword redundant for primary key fields.

/*markdown
### Creating a Primary Key Field - Example
*/

CREATE TABLE unique_cats (
    cat_id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- The above example is identical to:
CREATE TABLE unique_cats (
    cat_id INT,
    name VARCHAR(100),
    PRIMARY KEY (cat_id)
);

/*markdown
### Auto Increment for Primary Keys
To not worry about manually typing in a primary key every time, AUTO_INCREMENT (note the underscore) can be used. AUTO_INCREMENT automatically inserts a value for the keys incrementally.  
Note that even if AUTO_INCREMENT will always increment by 1 from the last assigned value it gave, even if that record is removed. e.g. We have the keys 1, 2, 3, and the records corresponding to keys 2 and 3 has been removed; when a new record is added, AUTO_INCREMENT will assign the key as 4, not 2.
*/

CREATE TABLE <table_name> (
    <field_1> <int_type> PRIMARY KEY AUTO_INCREMENT,
    <field_2> <field2_type>
);

-- Alternatively:
CREATE TABLE <table_name> (
    <field_1> <int_type> AUTO_INCREMENT,
    <field_2> <field2_type>,
    PRIMARY KEY (<field_1>)
);

/*markdown
### Auto Increment for Primary Keys - Example
*/

CREATE TABLE unique_cats3 (
    cat_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

-- QUICK RUN CELL -- Run queries for testing here.
SHOW TABLES;