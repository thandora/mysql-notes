/*markdown
# MySQL 02 - CRUD Basics
CRUD stands for **S**elect, **R**ead, **U**pdate, **D**elete. CRUD in most context refers to the operations on the records (rows or data) in the table like in this chapter, but CRUD can also apply for tables in a database.
*/

/*markdown
## Create: Using INSERT
In the context of CRUD, create is the operation of adding new data (record) in a database. This is done by using the INSERT INTO clause.  
This section is taken from chapter 1 (mysql_01).
*/

/*markdown
### Adding Record
*/

-- Insert record (row) into database table.
INSERT INTO <table> (
    <field_1>, 
    <field_2>
)
VALUES (
    <field_1_value>, 
    <field_2_value>
);

-- When inserting values on ALL fields, the fields can be omitted:
INSERT INTO <table>
VALUES (
    <field_1_value>, 
    <field_2_value>
);

/*markdown
### Adding Record - Example
*/

-- The order in which the fields are specified matters when defining the values 
-- e.g. field_1_value value should correspond to the field_1 field.
-- Example: Assuming we have a cats table with a name and age field:
-- Insert a row in the cats table for a cat named Purrson, age 3.
INSERT INTO cats (
    age,
    name
)
VALUES (
    3,
    'Purrson'
);

-- Alternatively, we can omit naming the fields if we plan to supply to all the fields.
-- But being explicit just like above is preferred. (Explicit is better than implicit --Python Zen)
INSERT INTO cats
VALUES (
    'Purrson',
    3
);

/*markdown
### Adding Multiple Records
*/

-- Multiple insert
INSERT INTO <table> (
    <field_a>,
    <field_b>
)
VALUES 
    (<row_1a_val>, <row_1b_value>),
    (<row_2a_val>, <row_2b_value>),
    (<row_3a_val>, <row_3b_value>);

/*markdown
### Adding Multiple Records - Example
*/

INSERT INTO cats (
    name,
    age
)
VALUES 
    ('Purrson', 3),
    ('Paws', 2),
    ('Catson', 6);

-- The above example can be further simplified:
INSERT INTO cats
VALUES 
    ('Purrson', 3),
    ('Paws', 2),
    ('Catson', 6);

/*markdown
## Read: Using SELECT
*/

/*markdown
### Selecting All Fields
*/

-- We have worked with SELECT before when we wanted to view
-- all the contents of our table, as follows:
SELECT * FROM <table>;
-- * means all columns in this scenario. That is, return all the
-- columns from the table, and in this case, all the entries since
-- no constraints is specified.

/*markdown
### Selecting All Fields - Example
*/

SELECT * FROM cats;

/*markdown
### Selecting Specific Fields
*/

-- Now instead of using *, we can use the field/column names, 
-- separated by commas.
SELECT 
    field_1, 
    field_2, 
    field_etc
FROM <table>;

/*markdown
### Selecting Specific Fields - Example
*/

SELECT 
    name,
    breed
FROM cats;

/*markdown
### Filtering Using WHERE
The WHERE keyword can be used to filter our results using conditions that evaluate to 1 (TRUE). The condition does not have to be a field in the SELECT clause.
*/

-- We can write this in a single line, but as we get longer queries,
-- I'll be styling them as needed. (Styling might be inconsistent as
-- I'm still new to this.)
 
SELECT 
    <field> 
FROM <table> 
WHERE 
    <condition>;

/*markdown
#### Conditions
In MySQL, conditions are commonly done by comparisons. These comparisons can either evaluate to 1 (TRUE), 0 (FALSE), or NULL. The comparators are: 

```
Name 	Description
> 	Greater than operator
>= 	Greater than or equal operator
< 	Less than operator
<>, != 	Not equal operator
<= 	Less than or equal operator
<=> 	NULL-safe equal to operator
= 	Equal operator 
```
*/

/*markdown
### Filtering Using WHERE - Example
*/

-- Notice that the age in the WHERE claude is not in the SELECT clause.
-- Condition of a field is not dependent on fields specified in SELECT.
SELECT
    name, 
    breed
FROM cats
WHERE
    age = 4;

/*markdown
### WHERE - Multiple Conditions
There can be multiple conditions in a WHERE clause.
*/

-- Both conditions needs to be true
WHERE 
    <condition_1> AND
    <condition_2>;

-- Either 1 or all conditions can be true
WHERE 
    <condition_1> OR
    <condition_2>;

/*markdown
### Aliases
During a query, the output field name can be set by using the AS keyword. This is purely on the output table and does not change the field name in the actual database.
*/

SELECT 
    <field_1> AS <field1_alias>, 
    <field_2> 
FROM <table>

/*markdown
### Aliases - Example
During a query, the output field name can be set by using the AS keyword. This is purely on the output table and does not change the field name in the actual database.
*/

SELECT 
    cat_id AS 'Kitten ID',
    name 
FROM cats;

/*markdown
## Update: Using UPDATE
When we want to update records in the table, we use the `UPDATE` keyword and usually paired up with a `SET` and `WHERE` clause. Although `WHERE` is optional, it is usually specified to prevent all records to be modified.  
**NOTE**: Just like deleting (discussed next) records or tables, be careful when doing updating records since this cannot be undone. A good practice is to verify the records first by SELECT.
*/

/*markdown
### Updating A Field
*/

UPDATE <table> 
SET 
    <field> = <new_value>
WHERE 
    <condition>;

/*markdown
### Updating A Field - Example
*/

UPDATE cats
SET
    age = 5
WHERE
    name = 'Bluey';

/*markdown
### Update With Multiple Conditions
If there is more than 1 condition, the AND & OR keywords can be used to join multiple conditions.
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

/*markdown
### Update With Multiple Conditions - Example
*/

-- Example: Supposed we know that the cats Bluey and Reddy are
-- tabby cats (previously unlabeled), and we want to update the
-- table to reflect that.
UPDATE cats
SET
    breed = 'Tabby'
WHERE
    name = 'Bluey' OR
    name = 'Reddy';

/*markdown
## Delete: Using DELETE
To delete records (not tables), the DELETE keyword is used.
*/

/*markdown
### Deleting Records
*/

DELETE FROM <table>
WHERE
    <condition>

/*markdown
### Deleting Records - Example
*/

-- Good practice is to confirm record to be deleted first.
SELECT *
FROM cats
WHERE
	name = 'Dodger';

-- Delete. Just change SELECT * to DELETE
DELETE FROM cats
WHERE
	name = 'Dodger';

-- QUICK RUN CELL -- Run statements for testing here.
SELECT name, age FROM cats;
