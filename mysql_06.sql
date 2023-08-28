/*markdown
# MySQL 06 - Data Types
Data can be categorised into one of the data types. These types can be further categorised according to the range of the values it can have. These range can be numerical (for numbers), or the length of a string (for characters).

In this chapter, we will be discovering the different some of the common data types including the ones we have been previously using, as well as new ones. We will also be learning about some functions exclusive to some data types.

To know about all of the data types and how they work, read the official MySQL docs [Data Types](https://dev.mysql.com/doc/refman/8.0/en/data-types.html).
*/

/*markdown
## String Data Types
**CHAR** and **VARCHAR** are both used to store variable-length strings, are mostly similar but different in the way the data are stored and retrieved. When choosing between the two, speed must be considered. In cases where there are little to no variance in the length of the string, **CHAR** is more performant and should be considered.
*/

/*markdown
### CHAR
- Declared by `CHAR(<max length>)`. Maximum length of CHAR is 255.
- Stored string always uses `max length` bytes. (e.g. "cat" is stored at 4 bytes instead of 3 because when stored, it actually becomes "cat ").
- When the string is less than the specified max length, it is right padded by white space (e.g. a string "cat" stored in a CHAR(4) becomes "cat  ").
- By default, adding a value greater than the max length throws an error.
*/

/*markdown
### VARCHAR
- Declared by `CHAR(<max length>)`. Maximum length of CHAR is 65,535.
- Stored string consumes `N of bytes of string + 1` (e.g. "cat" is stored at 4 bytes).
- String is stored as is (e.g. a string "cat" sotred in VARCHAR(4) is still "cat").
- By default, adding a value greater than the max length throws an error.
*/

/*markdown
## Numeric Data Types
Numerical values are stored in fixed-size memory. M
*/