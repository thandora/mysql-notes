/*markdown
# MySQL 09 - Views, Modes, and Others
This chapter is a collection for those MySQL concepts which are important but not large enough to warrant their own chapter.
*/

-- Create view
CREATE VIEW <view_name> AS
<QUERY>

-- Views will appear as a table.
SHOW TABLES;

-- Show current tables with type.
SHOW FULL TABLES;

-- Delete a view. Keywords on [BRACKETS] is optional.
DROP VIEW [IF EXISTS] <view_name>;

-- Some views are updatable
-- https://dev.mysql.com/doc/refman/8.0/en/view-updatability.html

-- Create view
CREATE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;
 
-- Replace a view
CREATE OR REPLACE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year DESC;
 
-- Replace using different keyword
ALTER VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;

-- Having
-- Filter results after GROUPING (based on *conditions on aggregated data*)
SELECT 
    title, 
    AVG(rating),
    COUNT(rating) AS review_count
FROM full_reviews 
GROUP BY 
    title HAVING COUNT(rating) > 1;

-- WHERE
-- Filter results before GROUPING
SELECT 
    title, 
    AVG(rating),
    COUNT(rating) AS review_count
FROM full_reviews 
WHERE released_year = 2016
GROUP BY 
    title ;
