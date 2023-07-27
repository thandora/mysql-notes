/*markdown
# MySQL 03 - String Functions
Functions are reusable set of codes that can be run. A function can take an input (arguments), and output something. In this chapter, we will be dealing with string functions, which are built-in MySQL functions that deals with the string data type. The functions that will be used here are not exhaustive. To see every string functions, refer to the MySQL [documentation](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html).
*/

/*markdown
#TODO
- Add dataset
*/

/*markdown
## CHAR_LENGTH()
Returns the number of characters in a string. Not to be confused with LENGTH(), which returns the size in bytes of a string
*/

CHAR_LENGTH(<string>);

/*markdown
## CHAR_LENGTH() - Example
*/

-- White space is also counted!
SELECT CHAR_LENGTH('Hello World');

/*markdown
## CONCAT() and CONCAT_WS()
CONCAT is short for contatenation, and is used to concatenate strings together. CONCAT_WS is a concat with separator, and makes the first argument provided as the separator between the concatenated objects.
*/

-- CONCAT()
-- Can take 1 or more arguments.
CONCAT(<x>, <y>);

-- CONCAT_WS() 
CONCAT_WS(<separator>, <x>, <y>)

-- Where x and y are strings or fields to be concatenated.

/*markdown
## CONCAT() and CONCAT_WS() - Example
*/

SELECT CONCAT('Hello', 'World')
SELECT CONCAT('Hello', 'COOL', 'World');

-- The above can be done with CONCAT_WS()
SELECT CONCAT_WS('COOL', 'Hello', 'World');

-- Working with fields
SELECT 
    CONCAT_WS(' ', author_fname, author_lname) AS 'author_fullname'
FROM books;

/*markdown
## SUBSTRING()
SUBSTRING is a function that allows selecting a part of a string. SUBSTRING can take different combinations of argument which alters its behavior. The first character in the string is considered as index 1, and the last character as -1. This allows the use of negative integers.
*/

SUBSTRING(<string>, <initial_pos>, <substring_length>)
-- If no substring_length is provided, the resulting substring
-- will start from initial_pos and end upto the end of the string.
-- SUBSTRING will return NULL if substring length is less than 1.
-- SUBSTRING can also be shortened to SUBSTR

/*markdown
## SUBSTRING() - Example
SUBSTRING is a function that allows selecting a part of a string. SUBSTRING can take different combinations of argument which alters its behavior.
*/

-- Select 'Hello'
SELECT SUBSTRING('HelloWorld', 1, 5);

-- Select 'World' and using SUBSTR
SELECT SUBSTR('HelloWorld', 6);

-- Select 'loWorld' using negative index
SELECT SUBSTRING('HelloWorld', -7);

-- Select 'Wor' using negative index
SELECT SUBSTRING('HelloWorld', -5, 3);

-- For a substring length < 1; NULL is returned
SELECT SUBSTRING('HelloWorld', 6, 0);

/*markdown
## Combining Multiple Functions
Two or more functions can be chained or combined as long as the data types are compatible. For example, if we have two functions that have following characteristics: func_a takes a number input, and func_b returns (outputs) a number input; it is possible to use func_b as the input the func_a. This will be more clear when we get to the actual statement.
*/

-- Say we want to take the initials of the book authors
-- such that 'Foo Bar' becomes 'F.B.'
SELECT 
    CONCAT (
        SUBSTRING('Foo', 1, 1),
        '.',
        SUBSTRING('Bar', 1, 1),
        '.'
    );

-- Unfortunately, the format of the output on some more complex
-- queries are broken (as of 2023-07-23).

-- Example using our sample data
SELECT 
    CONCAT (
        SUBSTRING(author_fname, 1, 1),
        '.',
        SUBSTRING(author_lname, 1, 1),
        '.'
    )
FROM books;

/*markdown
## REPLACE()
Replaces ALL matched subset of a string to a specified one.
*/

REPLACE(<string>, <to_replace>, <replacement>);
-- Note that to_replace is case-sensitive.

/*markdown
## REPLACE() - Example
*/

SELECT REPLACE('BlueBar', 'Blue', 'Foo');

SELECT REPLACE('Apple Banana Orange', ' ', 'YUMMY');

/*markdown
## UPPER() and LOWER()
Turns the english alphabet in the string to uppercase or lowercase.
*/

UPPER(<string>);
LOWER(<string>);

/*markdown
## UPPER() and LOWER() - Example
*/

SELECT UPPER('Hello World');

SELECT LOWER('Hello World');
