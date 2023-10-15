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
A foreign key is a key in a table which refers to a primary key on another table.
![keys](./img/keys.png)
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
## Relationships
Relationships are how tables relate to each other. The relationship type is determined on how a row on one table maps to another, specifically, on how many rows from, say `table B`, relates to a row in `table A`. There are three kinds of relationships:
1. One to One (Uncommon)
2. One to Many (Most Common)
3. Many to Many (Common)

A quick example:  
![Relationship types](img/relationships.png)  
Note: _Assuming_ that a teacher (and headteacher) can only be employed in 1 school.
*/

/*markdown
## Joins
Now that we have established a relationship between tables, how do we actually make a query such that the columns between the tables are returned? That is where **JOIN** comes in. A **JOIN** clause combines rows from two or more tables, based on a related column (this is where foreign keys come in) between them.
*/

/*markdown
### Join Types
![mysql joins](img/mysql_joins.png)

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
- You can manipulate the query to achieve other types of joins outside this 4.
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
    JOIN orders ON customers.id = orders.customer_id;

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
    JOIN orders ON customers.id = orders.customer_id;

-- Joins is more powerful when paired with groupings and aggregate functions
SELECT
    first_name,
    last_name,
    SUM(amount) AS total
FROM
    customers
    JOIN orders ON customers.id = orders.customer_id
GROUP BY
    first_name,
    last_name
ORDER BY
    total DESC;

/*markdown
### Left Join
Useful if we want to display the original table (left), matched with the table on the right. If a row from the left table does not match with anything on the right, the columns of the right will be **NULL**.  
Left and right tables are declared this way:  
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
    LEFT JOIN orders ON customers.id = orders.customer_id;
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
    LEFT JOIN orders ON customers.id = orders.customer_id;

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

/*markdown
## Many to Many Relationship
Let's look at some operations involving many to many relationships.
*/

/*markdown
### Data
We will be dealing with reviews on some TV series. Our tables will be data on **reviewers**, **reviews**, and **tv series**.
*/

-- Tables
CREATE TABLE reviewers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE series (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    released_year YEAR,
    genre VARCHAR(100)
);

CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    rating DECIMAL(2, 1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY (series_id) REFERENCES series (id),
    FOREIGN KEY (reviewer_id) REFERENCES reviewers (id)
);

-- Data
INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
 
INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    
INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),(8,4,8.5),(8,2,7.8),(8,6,8.8),
    (8,5,9.3),(9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),
    (9,5,4.5),(10,5,9.9),(13,3,8.0),(13,4,7.2),(14,2,8.5),
    (14,3,8.9),(14,4,8.9);

/*markdown
### Exercises
*/

-- Show titles and respective ratings
SELECT
    title,
    rating
FROM
    reviews
    JOIN series ON reviews.series_id = series.id
LIMIT 8;

-- Show titles and their average rating, sorted from lowest.
SELECT
	title,
	AVG(rating) as avg_rating
FROM
	series
	JOIN reviews ON series.id = reviews.series_id
GROUP BY
	title
ORDER BY
	avg_rating
LIMIT 8;

-- Reviewers' names and their ratings 
-- (rating doesn't need to be specified for what for now)
SELECT
	first_name,
    last_name,
    rating
FROM
	reviewers
    JOIN reviews ON reviewers.id = reviews.reviewer_id
LIMIT 8;

-- Title of unreviewed series
SELECT
	title as unreviewed_series
FROM
	series
    LEFT JOIN reviews ON series.id = reviews.series_id
WHERE 
	rating IS NULL
LIMIT 8;

-- Average rating of genre
SELECT
	genre,
    AVG(rating)
FROM
	series
    JOIN reviews ON series.id = reviews.series_id
GROUP BY
	genre
LIMIT 8;

-- Name of reviewer, their rating stats, and status.
SELECT
	first_name,
    last_name,
    COUNT(rating),
    IFNULL(MIN(rating), 0) as 'min',
    IFNULL(MAX(rating), 0) as 'max',
    IFNULL(ROUND(AVG(rating), 2), 0) as 'avg',
    IF(COUNT(rating) != 0, 
    'ACTIVE', 
    'INACTIVE'
    ) as 'status'
FROM
	reviewers
    LEFT JOIN reviews ON reviewers.id = reviews.reviewer_id
GROUP BY
	last_name,
    first_name
LIMIT 8;

-- Reviews on series and the reviewer
SELECT
	title,
    rating,
    CONCAT(first_name, ' ', last_name) as 'reviewer'
FROM
	reviews
    LEFT JOIN series ON reviews.series_id = series.id
    LEFT JOIN reviewers ON reviews.reviewer_id = reviewers.id;