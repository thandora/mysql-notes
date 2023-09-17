/*markdown
# MySQL 07 - Constraints and Modifying Table
This chapter will be on placing constraints on the data we can input, as well as making modifications to an existing table.
*/

/*markdown
## Dataset
*/

CREATE TABLE members (
	name VARCHAR(20) NOT NULL,
    age INT
);

/*markdown
## Constraints
When creating a table, you can limit what kind of data can be accepted by a column. For example, a column cannot be a NULL, a concept we have already familiar with. Aside from not being NULL, there are other constraints that can be specified.
*/

/*markdown
### NOT NULL
Disallows the use of the NULL (or NA) values.
*/

-- Syntax
...
<column_declaration> NOT NULL
...

-- Example: for a contacts table, the name column should be provided.
CREATE TABLE contacts (
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE
);

/*markdown
### UNIQUE
Only allow unique values i.e. values that do not currently exist for that column.
*/

-- Syntax
...
<column_declaration> UNIQUE
...

-- Example: for a contacts table, the phone number column should be unique from others'.
CREATE TABLE contacts (
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE
);

/*markdown
### CHECK
Allows values that pass a conditional expression.
*/

-- Syntax
...
<column_declaration> CHECK <conditional>
...

-- Example: only allow members whose age is >18.
CREATE TABLE members (
    username VARCHAR(20) NOT NULL,
    age INT CHECK (age > 18)
);

/*markdown
#### Named Check
By default, a check constraint is named as follows:  
`<table>_chk_<n>`  
Where n is the nth check constraint in the table.  

A named check is important because it allows you to get a quick overview of what was wrong in your data in case you fail to meet the check (if your check was appropriately named). It also gives you a way to identify a check and allow you to add or remove it later using an ALTER TABLE statement (will be discussed later on in this chapter).

*/

-- Syntax
CONSTRAINT <check_name> CHECK <conditional>

-- Example: same from our previous members table, except our CHECK constraint is named.
CREATE TABLE members2 (
    username VARCHAR(20) NOT NULL,
    age INT,
    CONSTRAINT age_over_18 CHECK (age > 18)
);

/*markdown
### Multiple Column Constraints
With the CONSTRAINT keyword, we can declare constraints involving multiple columns on a separate statement, instead of in the actual column declaration. 
*/

-- Example. A companies table where the name and address are both unique.
CREATE TABLE companies (
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    CONSTRAINT name_address UNIQUE (name, address)
);

-- Example. A CHECK constraint depending on two columns.
CREATE TABLE houses (
    purchase_price INT NOT NULL,
    sale_price INT NOT NULL,
    CONSTRAINT sprice_gt_pprice CHECK(sale_price >= purchase_price)
);

-- sprice_gt_pprice: sale price greater than purchase price

/*markdown
## ALTER TABLE
The ALTER TABLE statement is used to add, delete, or modify columns in an existing table. It can also be used to add and drop constraints on an existing table.

ALTER TABLE offers more than the aforementioned use cases, read more on [MySQL ALTER TABLE](https://dev.mysql.com/doc/refman/8.0/en/alter-table.html).
*/

/*markdown
### Adding Columns
*/

ALTER TABLE <table>
ADD [COLUMN]
    <column_declaration>

-- [COLUMN] is an optional keyword

/*markdown
#### Adding Columns - Example
*/

-- Add an email column of varchar type to the table "members".
ALTER TABLE members
ADD 
    email varchar(255);

/*markdown
### Dropping Columns
*/

ALTER TABLE <table>
DROP [COLUMN]
    <column>

-- [COLUMN] is an optional keyword

/*markdown
#### Dropping Columns - Example
*/

-- Remove the email column from the table "members".
ALTER TABLE members 
DROP 
    email;

/*markdown
### Renaming Columns
Unlike ADD and REMOVE, the COLUMN keyword is **mandatory**.
*/

ALTER TABLE <table>
RENAME COLUMN <old_name> to <new_name>

-- <old_name> and <new_name> refers to column name.

/*markdown
#### Renaming Columns - Example
*/

ALTER TABLE members
RENAME COLUMN email to email_address;

/*markdown
### Modifying Columns
*/

/*markdown
#### MODIFY
Allows changing of column's data type.
*/

ALTER TABLE <table>
MODIFY [COLUMN] <column_definition>

-- [COLUMN] is an optional keyword

-- Example: change type of age from int to varchar
ALTER TABLE members
MODIFY age VARCHAR(50);

/*markdown
#### CHANGE
Allows changing of column's name AND data type.
- New name can be the same as old name.
*/

ALTER TABLE <table>
CHANGE [COLUMN] <old_name> <new_name> <column_definition>

-- [COLUMN] is an optional keyword

-- Example: Change type age to int.
ALTER TABLE members
CHANGE age age INT;

/*markdown
### Adding Check Constraint
*/

ALTER TABLE <Table>
ADD
    CONSTRAINT <check_name> CHECK <conditional>

ALTER TABLE members
ADD 
    CONSTRAINT positive_age CHECK (age >= 0);

/*markdown
#### Removing Check Constraint
*/

ALTER TABLE <Table>
DROP
    CONSTRAINT <check_name>

ALTER TABLE members 
DROP 
    CONSTRAINT positive_age;