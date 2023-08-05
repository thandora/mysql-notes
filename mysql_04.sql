/*markdown
# MySQL 04 - Refining Selection
Using SELECT and WHERE, we have learned how to create queries for our databases. Now, we will learn how to further refine our queries using some of the built-in MySQL commands.
*/

/*markdown
## Data Set
The data used in this chapter will be mostly the same with the previous chapter's, with added records.
*/

-- Add this if you have the table from the previous chapter (skip the cell immediately below).
INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
    ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
    ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
    ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

-- Use this (skip the cell above) if you don't have the table from the previous chapter.
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

-- Before we start using our database,
-- its a good idea to investigate our table first
SELECT * FROM books;

/*markdown
## DISTINCT
When used in tandem with SELECT (i.e. SELECT DISTINCT), it will only show distinct rows (within the specified columns) in the resulting table.
- If more than 1 column is specified, duplicates are those rows that have the same values in all the specified columns.
*/

SELECT DISTINCT <columns>
<...>;

/*markdown
## DISTINCT - Example
*/

-- Let us see the resulting table without using DISTINCT
SELECT author_lname
FROM books;

-- Now using DISTINCT:
SELECT DISTINCT author_lname
FROM books;
-- As we can see, the duplicates were removed.

-- For more than 1 column:
SELECT DISTINCT author_lname, released_year
FROM books

/*markdown
## ORDER BY
ORDER BY sorts the results in ascending (default) or descending order. If more than 1 column is specified to ORDER BY, the results are sorted in the order it appears in the ORDER BY CLASE. 
- The order criteria doesn't have to be in the SELECT clause.
- ASC can be omitted, rows are ordered in ascending by default.
*/

SELECT 
    <columns>
FROM <table>
ORDER BY 
    <column_1> ASC|DESC,
    <column_2> ASC|DESC,
    <...>;

-- Shorthand of specifying order criteria
SELECT
    <columns>
FROM <table>
ORDER BY 
    <n_1> ASC|DESC,
    <n_2> ASC|DESC,
    <...>;
-- Where nth column specified in the SELECT clause

/*markdown
## ORDER BY - Example
*/

-- Sort the release year of the books in ascending order (default)
SELECT 
    released_year
FROM books
ORDER BY 
    released_year;

-- Sort by release year, and by title if in the same year.
SELECT 
    released_year,
    title
FROM books
ORDER BY released_year DESC, title;

-- Sort by title
SELECT 
    title,
    released_year
FROM books
ORDER BY 1;

/*markdown
## LIMIT
LIMIT is used to specify the maximum records to return. It is relevant when dealing with large tables.
*/

<SELECT STATEMENT>
LIMIT <n>;
-- Where n is the maximum number of rows.

-- When two numbers are provided, LIMIT becomes a slice. 
<SELECT STATEMENT>
LIMIT <start_index>, <n>;
-- Where start_index is where the slice starts, and n is max
-- number of rows.

/*markdown
## LIMIT - Example
*/

-- With no LIMIT:
SELECT 
    title
FROM books

-- With LIMIT:
SELECT
    title,
    released_year
FROM books
LIMIT 4;

-- Slicing:
SELECT
    title,
    released_year
FROM books
LIMIT 2, 4;

/*markdown
## LIKE
LIKE is used in a `WHERE` clause to search for a pattern in a column.
- Wildcards are special characters used to substitue one or more characters in a string.
- The most common wildcards used in LIKE are:
  - % represents zero, one, or multiple characters.
  - _ represents exactly one character.
- To escape wildcards, i.e. we want to look for patterns with an actual percent or underscore, use backslash before the wildcard (% becomes \\%)
- Characters used in patterns in LIKE are not case sensitive.
*/

<SELECT statement>
WHERE
    <column> LIKE <pattern>

/*markdown
## LIKE - Example
*/

-- Search for books where the author's first name starts
-- with the characters da. 
-- da, dave, are both valid (DA, DAve)
SELECT
    title, 
    author_fname
FROM books
WHERE 
    author_fname LIKE 'da%';

-- Search for books where the author's first name contains
-- "on". 
-- on, none, jhon are all valid (ON, ONe, nONe, jhON)
SELECT 
    title, 
    author_fname
FROM books
WHERE 
    author_fname LIKE '%on%';