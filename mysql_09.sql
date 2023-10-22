/*markdown
# MySQL 09 - Views, Modes, and Others
This chapter is a collection for those MySQL concepts which are important but not large enough to warrant their own chapter.
*/

/*markdown
## Dataset
The data used would be from the previous chapter's **Many-to-Many Relationships** section. If you've already have it, you can skip this step.
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
## Views
A view is a stored query and acts almost like a table. The columns (fields) in a view are fields from one or more real tables in the database.
*/

/*markdown
### Creating a View
To create a new view, you just prepend the query with the `CREATE VIEW` clause.
*/

-- Create view
CREATE VIEW <view_name> AS
<QUERY>

-- Create view example:
CREATE VIEW ordered_series AS
SELECT * 
FROM series 
ORDER BY released_year;

-- The previous query will create a view, which can be
-- confirmed by the following statements:

-- Views will appear as a table.
SHOW TABLES;

-- Show current tables with type.
SHOW FULL TABLES;

/*markdown
### Deleting a View
To delete a view, use the `DROP VIEW` keyword.
*/

-- Delete a view. Keywords on [BRACKETS] is optional.
DROP VIEW [IF EXISTS] <view_name>;

/*markdown
### Replace/Update a View
As long as a view is [updatable](https://dev.mysql.com/doc/refman/8.0/en/view-updatability.html), it can be updated either by the `REPLACE VIEW` or `ALTER VIEW` clause.
*/

-- Replace a view
CREATE OR REPLACE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year DESC;
 
-- Replace using different keyword
ALTER VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;

/*markdown
## HAVING Clause
HAVING is a keyword used to specify conditions on groups formed by `GROUP BY`. This is in contrast with `WHERE` clause which can't refer to aggregate functions.
*/

-- Let us create a new view first. We will be using this view for the
-- succeeding examples.
CREATE VIEW full_reviews AS
SELECT
    title,
    released_year,
    genre,
    rating,
    first_name,
    last_name
FROM
    reviews
    JOIN series ON series.id = reviews.series_id
    JOIN reviewers ON reviewers.id = reviews.reviewer_id;

-- Having
-- Filter results after grouping (based on *conditions on aggregated data*)
SELECT 
    title, 
    AVG(rating),
    COUNT(rating) AS review_count
FROM full_reviews 
GROUP BY 
    title 
HAVING
    COUNT(rating) > 1;

-- versus:
-- WHERE
-- Filter results BEFORE grouping.
SELECT 
    title, 
    AVG(rating),
    COUNT(rating) AS review_count
FROM full_reviews 
WHERE released_year = 2016
GROUP BY 
    title ;

/*markdown
## WITH ROLLUP
Shows the summary of higher-level summary operations. That is, per level in a multi-group query, a summary output is included for group by category.

Another explanation: include super-aggregate rows at the end that provide subtotals for each group as well as a grand total for the entire result set.

This best shown with an example:
*/

-- Notice the NULL value in the title column. This means that
-- this is the summary row for that group (title). i.e. the
-- average rating of all the title (shows).
SELECT
    title, AVG(rating)
FROM full_reviews
GROUP BY
    title
WITH ROLLUP;

-- This is a more obvious version of the previous example. The row
-- with the NULL value for title means that the summary on that row
-- is for that grouping (title).
SELECT
    title, COUNT(rating)
FROM full_reviews
GROUP BY
    title
WITH ROLLUP;

-- This example will be grouped by released_year and genre. Notice
-- how there are considerably more NULL values.

-- The rows with NULL genre are the average rating for all the genres
-- for that specific year.

-- The row with NULL year are the average rating for all the genres
-- across all the years. (i.e. average of the whole query)
SELECT
    released_year, genre, AVG(rating)
FROM full_reviews
GROUP BY
	released_year,
    genre
WITH ROLLUP;