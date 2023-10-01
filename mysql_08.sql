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
### Cross Join
Cross join is not commonly used as it just returns a (redundant) view of all the rows from both tables.
*/

SELECT
    *
FROM
    customers
    CROSS JOIN orders;

-- This is similar if you query everything from both tables, i.e.
SELECT
    *
FROM
    customers,
    orders;

/*markdown
### Inner Join
Inner joins are useful when we only want to records that appear in both tables.
*/

SELECT
    *
FROM
    customers
    JOIN orders ON orders.customer_id = customers.id;

-- If a column is ambiguous, like the 'id' column we have which exists in both table,
-- we should specify the table where it came from: <table>.<column>
SELECT
    orders.id as order_id,
    first_name,
    last_name,
    order_date,
    amount
FROM
    customers
    JOIN orders ON orders.customer_id = customers.id;

-- Joins is more powerful when paired with groupings and aggregate functions
SELECT
    first_name,
    last_name,
    SUM(amount) AS total
FROM
    customers
    JOIN orders ON orders.customer_id = customers.id
GROUP BY
    first_name,
    last_name
ORDER BY
    total DESC;

/*markdown
### Left Join
Useful if we want to display the original table (left), matched with the table on the right. If a row from the left table does not match with anything on the right, the columns of the right will be **NULL**.  

Left and right table are declared this way:

```
FROM
    <left_table>
    LEFT JOIN <right_table> ...
```
*/

SELECT
    *
FROM
    customers
    LEFT JOIN orders ON orders.customer_id = customers.id;
-- There might be NULL values on the first column (customers.id). This is
-- only a visual bug caused by the SQL notebook extension.

-- Example where the 'customers' table is the left table.
SELECT
    first_name,
    last_name,
    order_date,
    amount
FROM
    customers
    LEFT JOIN orders ON orders.customer_id = customers.id;

-- Example where the 'orders' table is the left table.
SELECT
    order_date,
    amount,
    first_name,
    last_name
FROM
    orders
    LEFT JOIN customers ON orders.customer_id = customers.id;

-- Example with aggregate function. 
SELECT
    first_name,
    last_name,
    IFNULL(SUM(amount), 0) AS money_spent
FROM
    customers
    LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY
    first_name,
    last_name
ORDER BY
    money_spent DESC;

/*markdown
### Right Join
Functionally same as left join, except this time all rows are displayed from the right table instead of the left.

Left and right table are declared this way:

```
FROM
    <left_table>
    RIGHT JOIN <right_table> ...
```
*/

SELECT
    first_name,
    last_name,
    order_date,
    amount
FROM
    customers
    RIGHT JOIN orders ON customers.id = orders.customer_id;