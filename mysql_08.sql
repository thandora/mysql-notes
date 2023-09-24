/*markdown
# MySQL 08 - Relationships and Joins
Upto this point, we have been dealing with simple data stored in one table at a time, a self-contained basic table. In this chapter, we will learn about relationships between tables and how we can create them. We will also be learning about joining table views from our queries using the JOIN keyword.
*/

/*markdown
## Keys
To learn more about table relationships, we need to know about the concept of keys. Keys are identifiers used to refer to a row. A key can be classified into two: primary key and foreign key.
*/

/*markdown
### Primary Key
A primary key is a **unique** identifier for a row in a specific table. This primary key ensures that a row will be unique.
*/

/*markdown
## Foreign Key
A foreign key is a key in a table which refers to a primary key on another table.![keys](./img/keys.png)
*/

/*markdown
### Keys Example
Let us create the tables and data described in the image.
- `FOREIGN KEY (customer_id) REFERENCES customers(id)` establishes the relationship between the two tables.
- When a relationship is established, inputting a foreign key that does not exist in the referenced table will not be allowed.
- Our example is a one-to-many relationship (one customer can have many orders).
*/

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8, 2),
    customer_id INT,
    -- This line sets the column customer_id of the current table
    -- as the column to refer to the keys column of another table
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO
    customers (first_name, last_name, email)
VALUES
    ('Boy', 'George', 'george@gmail.com'),
    ('George', 'Michael', 'gm@gmail.com'),
    ('David', 'Bowie', 'david@gmail.com'),
    ('Blue', 'Steele', 'blue@gmail.com'),
    ('Bette', 'Davis', 'bette@aol.com');

INSERT INTO
    orders (order_date, amount, customer_id)
VALUES
    ('2016-02-10', 99.99, 1),
    ('2017-11-11', 35.50, 1),
    ('2014-12-12', 800.67, 2),
    ('2015-01-03', 12.50, 2),
    ('1999-04-11', 450.25, 5);

/*markdown
## Joins
Now that we have establish a relationship between tables, how do we actually make a query such that the columns between the tables are returned? That is where **JOIN** comes in. A **JOIN** clause combines rows from two or more tables, based on a related column (this is where foreign keys come in) between them.
*/

/*markdown
### Join Types
A join can be classified according to which rows from the two (or more) tables are returned.

In MySQL, there are four native types of JOIN:
1. Left
   - returns all rows from the `left`, and matched rows from the `right`.
2. Right
   - Returns all rows from the `right`, and matched rows from the `left`
3. Inner
   - Returns rows that have `matching values in both tables`.
4. Cross
   - Returns all rows from `both tables`.

Notes: 
- `left` and `right` refers to the tables in the JOIN clause. Left table refers to the table that appears first in the clause.
- Cross join is also known as full outer join in other SQL flavors.

You can manipulate the query to achieve other types of joins outside this 4.
![mysql joins](img/mysql_joins.png)
*/

/*markdown
Draft
- Relationships
  - 1 to 1
    - uncommon
  - 1 to many
    - most common
    - e.g. books and reviews relationship
  - many to many
    - pretty common
    - e.g. books and authors
- Joins
  - left
  - right
  - inner
  - outer
- Keys
  - foreign
  - primary
*/