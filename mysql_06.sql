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
Numerical values are stored in fixed-size memory. This means that choosing the right type for your data is crucial, especially the larger your database is.
*/

/*markdown
### Integers
Integers are the whole numbers (negative, zero, and positive).

Here are all the integer types, their value range, and storage requirements:
![Integer type storage table](img/int-table.png)
For example, for the `INT` type we usually used, is stored for 4 bytes of memory and can be a value between -2,147,483,648 and 2,147,483,647, including 0.

By default, integers are signed, meaning they can have values from the negative integers to the positive ones. To assign an integer to have only zero and the positive part, we can use the unsigned keyword when declaring our integer type:
*/

<column> <int_type> UNSIGNED

-- Declaration example
age TINYINT UNSIGNED

-- This makes our default range of -128 to +127 (TINYINT range) into 0 to +255 (which is more appropriate for our age column).
-- When a decimal number is inserted to an integer type column, the number is rounded and then stored.

/*markdown
### Fixed-Point (Exact Value) - DECIMAL, NUMERIC
`Decimal` and `numeric` types are equivalent to each other. They store exact numeric data values and used when it is important to preserve exact precision, like with monetary data.

- Maximum number of digits is 65.
*/

/*markdown
![Decimal params](img/decimal-params.png)
*/

<column> DECIMAL(P, S)
-- Or
<column> DECIMAL(P)
-- which is equivalent to `DECIMAL(P, 0)`

-- Where P is the precision (number of significant digits) 
-- S is the scale (number of digits after the decimal point)

-- Declaration example
salary DECIMAL(5, 2)
-- In this case, our salary column can hold a value between -999.99 to +999.99

/*markdown
### Floating-Point (Approximate Value) - FLOAT, DOUBLE
`Float` and `double` types are used to represent approximate numeric values. `FLOAT` is for single-precision (4 bytes), while `DOUBLE` is for double-precision (8 bytes).
*/

-- Floating-point can be declared with or without an argument.
<column> Float
-- or
<column> Float(P)

-- Where P is the precision in bits. MySQL uses this value to determine
-- whether to use FLOAT or DOUBLE for the resulting data type.
-- If P is 0 - 24, then FLOAT is used
-- If P is 25 - 53, then DOUBLE is used.