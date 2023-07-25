/*markdown
# MySQL 03 - String Functions

Functions are reusable set of codes that can be run. A function can take an input (arguments), and output something. In this chapter, we will be dealing with string functions, which are built-in MySQL functions that deals with the string data type. The functions that will be used here are not exhaustive. To see every string functions, refer to the MySQL [documentation](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html).
*/

/*markdown
## Concat()
*/

desc books;

SELECT CONCAT(author_fname, author_lname)

FROM books;

SELECT 4 + 2;