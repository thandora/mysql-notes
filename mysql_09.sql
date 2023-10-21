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