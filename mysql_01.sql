/*markdown
# MySQL 1 - The Basics
 This is my personal notes on MySQL. The concepts can be found on other SQL variants. Formatting and styling is loose and may evolve throughout my note taking. I might adopt this [SQL style guide](https://github.com/mattm/sql-style-guide) later.
*/

/*markdown
## Database
*/

/*markdown
### Database Basics
*/

-- -------------------------------------------------------------------------------------
-- Display all databases in server
SHOW DATABASES;

-- Create an empty database.
CREATE DATABASE <db_name>;

-- Delete database. Can't be undo, be careful.
DROP DATABASE <db_name>;

-- Selects DB and makes it the current active DB
USE <db_name>

-- Check active DB
SELECT DATABASE();

-- Example
SHOW DATABASES;
CREATE DATABASE pet_shelter;
CREATE DATABASE incorrect_database;

DROP DATABASE incorrect_database;
SHOW DATABASES;

USE pet_shelter
SELECT DATABASE()

/*markdown
## Tables
*/

/*markdown
### Creating Tables
*/

-- -------------------------------------------------------------------------------------
-- Create table inside DB
CREATE TABLE <table_name> (
    <field_1> <data_type_1>,
    <field_2> <data_type_2>,
);
-- Fields are column/headers.

-- Show tables in currently active database
SHOW TABLES;

-- Show table information
SHOW COLUMNS FROM <table_name>;

-- Alternate way of showing table information
-- using DESCRIBE or DESC
DESC <table_name>;

-- Example
CREATE TABLE cats (
    name VARCHAR(50),
    age INT
);

CREATE TABLE dogs (
    name VARCHAR(50),
    breed VARCHAR(50),
    age INT
);

CREATE TABLE dummy_field (
    name VARCHAR(25),
    number int
);

SHOW TABLES;

SHOW COLUMNS FROM dogs;

-- Using DESCRIBE
DESC dogs;

/*markdown
### Dropping (Deleting) Tables
*/

-- -------------------------------------------------------------------------------------
-- Delete a table. Again, be careful of using DROP as there is no confirmation when using it.
DROP TABLE <table_name>;

-- Deleting from a specific database. This works even if the database is not currently selected/active.
-- Note that ( ` ) is backtick, not apostrophe ( ' ).
DROP TABLE `<db_name>`.`<table_name>`;

-- Example
SHOW TABLES;
DROP TABLE dummy_field;
SHOW TABLES;

/*markdown
### Inserting (Adding) Data Into Table
*/

-- -------------------------------------------------------------------------------------
-- Insert row into database table.
INSERT INTO <table> (<field_1>, <field_2>)
VALUES (<field_1_value>, <field_2_value>);


-- Inserting values on ALL fields, the fields can be empty:
INSERT INTO <table>
VALUES (<field_1_value>, <field_2_value>);


-- Multiple insert
INSERT INTO <table> (<field_a>, <field_b>)
VALUES (<row_1a_val>, <row_1b_value>),
        (<row_2a_val>, <row_2b_value>),
        (<row_3a_val>, <row_3b_value>);


-- Show all (indicated *) columns of entries in a table.
-- SELECT is further discussed later.
SELECT * FROM <table>;

-- Example
-- Insert a row in the cats table for a cat named Purrson, age 3.
INSERT INTO cats (name, age)
VALUES ('Purrson', 3);

-- View cats table to confirm added entry.
SELECT * FROM cats;

/*markdown
## Null and Default Values
*/

/*markdown
### NOT NULL
*/

-- -------------------------------------------------------------------------------------
-- NULL Value
-- NULL values are empty values or unknown values. We can use
-- the keywords NOT NULL to forbid NULL values in our table.
CREATE TABLE <table_name> (
    <field_1> <data_type_1> NOT NULL,
    <field_2> <data_type_2>,
);
-- The following table will have 2 fields: field_1 and field_2.
-- field_1 will not allow NULL values, but field 2 will.

-- Example
-- Create a cats table where the breed field, 
-- and only the breed field, can be NULL.

CREATE TABLE cats2 (
    name VARCHAR(100) NOT NULL,
    breed VARCHAR(100),
    age INT NOT NULL
);

/*markdown
### Default Value for Fields
*/

-- We can create a field in a table where a default value
-- will be provided if no value is provided in that field.
CREATE TABLE <table_name> (
    <field> <field_type> DEFAULT <field_default>
);

-- Example
CREATE TABLE cats3 (
    name VARCHAR(100) DEFAULT 'Tabby',
    age INT
);

-- Note that no value is provided for the "name" field.
-- This will add an entry of a cat named Tabby (default) aged 3.
INSERT INTO cats3 (age)
VALUES (3);

SELECT * FROM cats3;

/*markdown
### Inserting a Default Value
We can insert the default value to a field by using the DEFAULT keyword during our INSERT statement. This will insert the default value into the field, or NULL if no default value is provided.





Assuming a field is set to have a default and not null constraints, we can insert
*/

-- Assuming we have 2 fields in a table, and field_1 has the default value
-- 'Magic String', and we do the following:
INSERT INTO <table> (<field_1>, <field_2>)
VALUES (DEFAULT, <field_2_value>);
-- This will insert into field_1 the default value 'Magic String'.

INSERT INTO magical_table (title, n_pages)
VALUES (DEFAULT, 342);

-- Example
-- DEFAULT is useful specially useful when dealing with primary keys.
-- Note: primary keys is discussed later on in this chapter.

-- Assuming a table magical_table2 with fields book_id, title, n_pages;
-- where book_id is a primary key field with auto increment:
INSERT INTO magical_table2
VALUES (DEFAULT, 'Gatsby The Great', 342);

/*markdown
### NULL and DEFAULT
Even with a default value, we can still explicitly insert a NULL value into a field. If we don't want this behaviour, we can chain the NOT NULL and DEFAULT constraints.
*/

CREATE TABLE <table_name> (
    <field> <field_type> NOT NULL DEFAULT <field_default>
);

-- Example
CREATE TABLE cats4 (
    name VARCHAR(100) NOT NULL DEFAULT 'Tabby',
    age INT
);

-- This will not be allowed since name CAN'T be NULL.
INSERT INTO cats4 ()
VALUES(NULL, 3);

/*markdown
## Primary Keys
Primary keys are unique identifiers for entries in a table. This is useful when two entries share the same value for a field. For example, in a cat's table, if there are two cats named Tabby, the primary key of each cat will allow us to distinguish between the two cats.
*/

/*markdown
Note that it is a convention for a primary key to be an integer data type since it is faster than strings and can be used in tandem with the AUTO_INCREMENT keyword. There are a few integer data types and they differ in the maximum number they can allow.
*/

-- There are two ways to initialize a primary key field:
-- Say we want field_1 to be the primary key

-- First option
CREATE TABLE <table_name> (
    <field_1> <int_type> PRIMARY KEY,
    <field_2> <field_2_type>,
);

-- Alternative
CREATE TABLE <table_name> (
    <field_1> <int_type>,
    <field_2> <field_2_type>,
    PRIMARY KEY (field_1)
);

-- Notice that there is no NOT NULL constraint for the key field.
-- This is because it is reduntant since primary keys can never
-- be null in the first place.

-- Example
CREATE TABLE unique_cats (
    cat_id INT PRIMARY KEY,
    name VARCHAR(100),
);

CREATE TABLE unique_cats2 (
    cat_id INT,
    name VARCHAR(100),
    PRIMARY KEY (cat_id)
);

/*markdown
### Auto Increment on Primary Keys
To not worry about manually typing in a primary key, AUTO_INCREMENT (note the underscore) can be used. AUTO_INCREMENT automatically inserts a value for the keys incrementally.
*/

CREATE TABLE <table_name> (
    <field_1> <int_type> PRIMARY KEY AUTO_INCREMENT,
    <field_2> <field_2_type>,
);

-- Example
CREATE TABLE unique_cats3 (
    cat_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
);


-- QUICK RUN CELL -- Run queries here
DESC unique_cats3;

