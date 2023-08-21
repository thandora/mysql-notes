/*markdown
# MySQL 05 - Aggregate Functions
Aggregate functions are numerical functions that take in a range of values and outputs only a single value that describes the input values. Taking the average, mininum, and maximum value of a range are just some of the aggregate functions that we can do in MySQL.
*/

/*markdown
## Data Set
We will still be using the previous books data set. The data is provided below if you don't have the previous data.
*/

CREATE TABLE books 
    (
        book_id INT AUTO_INCREMENT,
        title VARCHAR(100),
        author_fname VARCHAR(100),
        author_lname VARCHAR(100),
        released_year INT,
        stock_quantity INT,
        pages INT,
        PRIMARY KEY(book_id)
    );
    
INSERT INTO books 
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
    ('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
    ('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
    ('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
    ('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
    ('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
    ('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
    ('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
    ('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
    ('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
    ('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
    ('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
    ("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
    ('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
    ('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
    ('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
    ('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);
    ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
    ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
    ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

/*markdown
## Counting Rows: Using COUNT()
`COUNT()` is a function used to get the number of rows of a `SELECT` query. Its usage is flexible, as we will see later.
*/

-- General syntax:
COUNT(<expression>)

-- Returns the number of non-NULL rows from <column>
SELECT 
    COUNT(<column>)
FROM <table>;

-- Returns the number of all (including NULL) rows in the table
SELECT 
    COUNT(*)
FROM <table>;

-- Returns the distinct number of rows.
SELECT
    COUNT(DISTINCT <column>)
FROM <table>;

-- Returns the count per group. GROUP BY is discussed next.
SELECT 
    <column_a>,
    COUNT(<column>)
FROM <table>
GROUP BY
    <column_a>;

/*markdown
## Counting Rows - Example
*/

-- The number of book titles in the table.
-- Counts duplicates, if any.
-- Does not count NULL values.
SELECT 
    COUNT(title)
FROM books;

-- The number of rows in the table, inluding NULL rows.
-- Counts duplicates, if any.
SELECT
    COUNT(*)
FROM books;

-- The number of author last names (author_lname)
SELECT
    COUNT(author_lname)
FROM books;

-- Number of unique last names
SELECT
    COUNT(DISTINCT author_lname)
FROM books;

-- Notice how there are less unique last names.

-- Number of books per author. Grouping is discussed next.
SELECT 
    author_lname,
    author_fname,
    COUNT(title)
FROM books
GROUP BY
    author_lname,
    author_fname;

-- Without the author_fname, Harris Dan and Harris Freida
-- will be counted as one entry, and will have a COUNT of 2.

/*markdown
## Grouping: GROUP BY
`GROUP BY` is a keyword used to group entries together. This is most commonly used to apply aggregate functions by group, instead of every row in the query.

- A NULL value is considered a valid group.
*/

SELECT
    <columns>
FROM <table>
GROUP BY
    <columns>;

-- In the SELECT clause, atleast 1 column should be
-- an aggregate function, by default.

/*markdown
## Grouping: GROUP BY - Example
GROUP BY is a keyword used to group entries together. This is most commonly used to apply aggregate functions by group, instead of every row in the query.
*/

-- The number of books by published by year.
-- In this example, the rows are grouped by released_year,
-- and then the aggregate function COUNT() is applied per group.
SELECT
    released_year,
    COUNT(title)
FROM books
GROUP BY
    released_year
ORDER BY
    released_year;

-- The number of pages written per author.
SELECT
    author_lname,
    author_fname,
    SUM(pages)
FROM books
GROUP BY
    author_lname,
    author_fname
ORDER BY
    SUM(pages) DESC;

-- QUICK RUN CELL -- Run queries for testing here.
SHOW TABLES;