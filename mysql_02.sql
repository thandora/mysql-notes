/*markdown
# MySQL 2 - CRUD Basics
CRUD stands for **S**elect, **R**ead, **U**pdate, **D**elete.
*/

/*markdown
## Read - Using SELECT
*/

-- We have worked with SELECT before when we wanted to view
-- all the contents of our table, as follows:
SELECT * FROM <table>;
-- * means all columns in this scenario. That is, return all the
-- columns from the table, and in this case, all the entries since
-- no constraints is specified.

-- Example
SELECT * FROM cats;

/*markdown
### Selecting Specific Fields/Columns
*/

-- Now instead of using *, we can use the field/column names, 
-- separated by commas.
SELECT field_1, field_2, field_etc, FROM <table>;

-- Example
SELECT name, age FROM cats;

SELECT name, breed FROM cats;

/*markdown
### Filtering Using WHERE

The WHERE keyword can be used to filter our results using conditions. Do note that the condition does not have to be a field in the SELECT clause.
*/

-- We can write this in a single line, but as we get longer queries,
-- I'll be styling them as needed. (Styling might be inconsistent as
-- I'm still new to this.)
 
SELECT 
    <field> 
FROM <table> 
WHERE 
    <condition>;

-- Example
SELECT 
    name, age
FROM cats
WHERE
    age = 4;

-- Notice that the age in the WHERE claude is not in the SELECT clause.
-- Condition of a field is not dependent on fields specified in SELECT.
SELECT
    name, breed
FROM cats
WHERE
    age = 4;

/*markdown
### Aliases

During a query, the output field name can be set by using the AS keyword. This is purely on the output table and does not change the field name in the actual database.
*/

SELECT 
    <field_1> AS <field1_alias>, 
    <field_2> 
FROM <table>

-- Example
SELECT 
    cat_id AS 'Kitten ID',
    name 
FROM cats;

/*markdown
## Update - Using UPDATE

When we want to update records in the table, we use the `UPDATE` keyword and usually paired up with a `SET` and `WHERE` clause. Although `WHERE` is optional, it is usually specified to prevent all records to be modified.  

**NOTE**: Just like deleting (discussed later in this chapter) records or tables, be careful when doing updating records since this cannot be undone. A good practice is to verify the records first by SELECT.
*/

UPDATE <table> 
SET 
    <field> = <new_value>
WHERE 
    <condition>;

-- Example
UPDATE cats
SET
    age = 5
WHERE
    name = 'Bluey';

/*markdown
### Update With Multiple Conditions - Using AND & OR

If there is more than 1 condition, AND or OR can be used.
*/

-- Both conditions needs to be true
UPDATE <table> 
SET 
    <field> = <new_value>
WHERE 
    <condition_1> AND
    <condition_2>;


-- Either 1 or all conditions can be true
UPDATE <table> 
SET 
    <field> = <new_value>
WHERE 
    <condition_1> OR
    <condition_2>;

-- Example: Supposed we know that the cats Bluey and Reddy are
-- tabby cats (previously unlabeled), and we want to update the
-- table to reflect that.
UPDATE cats
SET
    breed = 'Tabby'
WHERE
    name = 'Bluey' OR
    name = 'Reddy';

-- QUICK RUN CELL -- Run queries for testing here.
SELECT name, age FROM cats;