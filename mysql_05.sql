/*markdown
# MySQL 05 - Aggregate Functions
Aggregate functions are numerical functions that take in a range of values and outputs only a single value that describes the input values. Taking the average, mininum, and maximum value of a range are just some of the aggregate functions that we can do in MySQL.
*/

/*markdown
## Dataset
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
-- This is dicussed later in the "Grouping By Multiple Columns" section.

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

-- Just like ORDER BY, GROUP BY has can specify group criteria
-- by integers
SELECT
    <columns>
FROM <table>
GROUP BY
    <n_1>,
    <n_2>,
    <...>;
-- Where nth is column order specified in the SELECT clause.
-- e.g. first column in SELECT clause is 1



/*markdown
### Example
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

-- The same as previous example, but using integers for specifying groups
-- and sorting.
SELECT
    released_year,
    COUNT(title)
FROM books
GROUP BY
    1
ORDER BY
    1;

/*markdown
### Grouping By Multiple Columns
When grouping data with a single criteria, we might not get the full picture that query is showing us. Grouping by multiple criteria gives us a more specific and clearer picture on what the data indicates.
*/

-- Let us group our data by author_lname.
-- Take notice that the count for "Harris" is 2. We might assume
-- from this that an author with the last name Harris has two
-- published books.
SELECT
    author_lname,
    COUNT(*)
FROM books
GROUP BY
    author_lname;

-- Now grouping by multiple columns, author_lname and author_lname.
-- As we can see, our "Harris" group is now separated in two unique
-- rows. This might seem weird at first, but we can surmise that
-- these two Harris are actually different from each other, as
-- we will see in the example.
SELECT
    author_lname,
    COUNT(*)
FROM books
GROUP BY
    author_lname,
    author_fname;

-- The same as the previous query, with the added author_fname
-- in the SELECT clause. This reveals that there are indeed
-- 2 authors having the last name of Harris. This shows that
-- grouping by more columns gives us more detail on our queries.
SELECT
    author_lname,
    author_fname,
    COUNT(*)
FROM books
GROUP BY
    author_lname,
    author_fname;

/*markdown
### Grouping By Multiple Columns - Example
*/

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

/*markdown
## MIN() and MAX()
Returns the minimum or the maximum of a column. It also works on non-numerical columns, just like sorting by ORDER BY does.
*/

SELECT
    MIN(<column>)
FROM <table>;

/*markdown
### Example
*/

SELECT
    MIN(released_year)
FROM books;

SELECT
    MAX(pages)
FROM books;

/*markdown
### On Grouped Data
Just like other aggregate functions, MIN() and MAX() can be used on grouped data.
*/

SELECT
    <column_a>,
    MIN(<column>)
FROM <table>
GROUP BY 
    <column_a>;

/*markdown
### On Grouped Data - Example
*/

-- Return the number of pages of longest book by release year.
SELECT
    released_year,
    MAX(pages)
FROM books
GROUP BY 
    released_year;

-- Aggregated book data grouped by author.
SELECT 
	CONCAT(author_fname, ' ',author_lname) as author,
	COUNT(*) as books_written, 
	MAX(released_year) AS latest_release,
	MIN(released_year)  AS earliest_release,
    MAX(pages) AS longest_page_count
FROM books 
GROUP BY 
    author;

/*markdown
## Subqueries
A subquery is an SQL query within another query. It can be used to be more specific on your selection. Some things about subqueries:
- The innermost subquery is evaluated first, working its way to the outermost query.
- A subquery may occur in :
  - A SELECT clause
  - A FROM clause
  - A WHERE clause
- Usually added within the WHERE Clause of another SQL SELECT statement.
- Can be used inside a SELECT, INSERT, UPDATE, or DELETE statement.
- Can be inside another subquery.
*/

-- Example 1
-- Find the book(s) with the most pages by using a subquery.
SELECT
    title,
    pages
FROM books
WHERE
    pages = (
        SELECT 
            MAX(pages)
        FROM books
    );

-- What is important to know where is the WHERE clause. It sets up the
-- filter to return the pages of a certain value. This value is evaluated
-- by our subquery, which is tasked to find the maximum value of the pages column.

-- In steps, this is what happens:
-- The subquery returns a single numerical value (maximum value of pages column).
-- The subquery result is then passed to the WHERE clause of the main query.
-- The main query is finally evaluated.

-- Example 2
-- Find the earliest released book(s) by using a subquery.
SELECT
    title,
    released_year
FROM books
WHERE
    released_year = (
        SELECT
            MIN(released_year)
        FROM books
    );

/*markdown
## SUM()
SUM() takes the sum of a column. It only adds up numerical values and ignores strings (that has no numerical character) and NULL values.
*/

SELECT
    SUM(<column>)
FROM <table>;

/*markdown
## SUM() - Example
*/

-- Total number of pages per release year, and the number of books.
SELECT
    released_year,
    SUM(pages),
    COUNT(*)
FROM books
GROUP BY
    released_year;

/*markdown
## AVG()
Takes the average of a columnn. Ignores strings (that has no numerical character) and NULL values.
*/

SELECT
    AVG(<column>)
FROM <table>;

/*markdown
## AVG() - Example
*/

-- Average number of pages of all the books.
SELECT
    AVG(pages)
FROM books;

-- Average length by release year.
SELECT 
    released_year, 
    FORMAT(AVG(pages), 0) as 'avg pages', 
    COUNT(*)
FROM books
GROUP BY released_year;
-- FORMAT dictates the number of digits after the decimal point,
-- in this case, 0.

-- QUICK RUN CELL -- Run queries for testing here.
SHOW TABLES;