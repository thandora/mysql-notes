/*markdown
# MySQL 06 - Data Types
Data can be categorised into one of the data types. These types can be further categorised according to the range of the values it can have (the larger the range, the more memory it takes up).

In this chapter, we will be discovering the different some of the common data types including the ones we have been previously using, as well as new ones. We will also be learning about some functions exclusive to some data types.

To know about all of the data types and their nuances, read the official MySQL docs [Data Types](https://dev.mysql.com/doc/refman/8.0/en/data-types.html).
*/

/*markdown
## Dataset
We will be playing with the following dataset when we come to the date and time type section.
*/

CREATE TABLE birthd_people (
    name VARCHAR(100),
    birth_date DATE,
    birth_time TIME,
    birth_dt DATETIME
);

INSERT INTO
    birthd_people (
        name,
        birth_date,
        birth_time,
        birth_dt
    )
VALUES
    (
        'Elton',
        '2000-12-25',
        '11:00:00',
        '2000-12-25 11:00:00'
    ),
    (
        'Lulu',
        '1985-04-11',
        '9:45:10',
        '1985-04-11 9:45:10'
    ),
    (
        'Juan',
        '2020-08-15',
        '23:59:00',
        '2020-08-15 23:59:00'
    );

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

< column > < int_type > UNSIGNED -- Declaration example
age TINYINT UNSIGNED -- This makes our default range of -128 to +127 (TINYINT range) into 0 to +255 (which is more appropriate for our age column).
-- When a decimal number is inserted to an integer type column, the number is rounded and then stored.

/*markdown
### Fixed-Point (Exact Value) - DECIMAL, NUMERIC
`Decimal` and `numeric` types are equivalent to each other. They store exact numeric data values and used when it is important to preserve exact precision, like with monetary data.

- Maximum number of digits is 65.
*/

/*markdown
![Decimal params](img/decimal-params.png)
*/

< column > DECIMAL(P, S) -- Or
< column > DECIMAL(P) -- which is equivalent to `DECIMAL(P, 0)`
-- Where P is the precision (number of significant digits) 
-- S is the scale (number of digits after the decimal point)
-- Declaration example
salary DECIMAL(5, 2) -- In this case, our salary column can hold a value between -999.99 to +999.99

/*markdown
### Floating-Point (Approximate Value) - FLOAT, DOUBLE
`Float` and `double` types are used to represent approximate numeric values. `FLOAT` is for single-precision (4 bytes), while `DOUBLE` is for double-precision (8 bytes).
*/

-- Floating-point can be declared with or without an argument.
< column > Float -- or
< column > Float(P) -- Where P is the precision in bits. MySQL uses this value to determine
-- whether to use FLOAT or DOUBLE for the resulting data type.
-- If P is 0 - 24, then FLOAT is used
-- If P is 25 - 53, then DOUBLE is used.

/*markdown
## Date and Time Data Types
The types for representing temporal values are `date`, `time`, `datetime`, `timestamp`, and `year`.
*/

/*markdown
### DATE
Dates are values with a date but no time, stored in `YYYY-MM-DD` format.
*/

/*markdown
### TIME
Time are values with a time but no date, and used to represent time (of day) or duration, in `hh:mm:ss` or `hhh:mm:ss` for larger values.
- Time has a range of `-838:59:59` to `838:59:59`
*/

/*markdown
### DATETIME
Values with a date and time, with the format `YYYY-MM-DD hh:mm:ss`. DATETIME's supported range is `1000-01-01 00:00:00` to `9999-12-31 23:59:59`. 
*/

/*markdown
### TIMESTAMP
Almost exactly like `DATETIME`, except that it consumes less storage memory, but less range of the dates it can store. It can only store `1970-01-01 00:00:01` UTC to `2038-01-19 03:14:07` UTC. 
*/

/*markdown
### NOTE
Because of the way the output is formatted, DATES and DATETIMES might show time zone data. This is caused by the way the SQL notebook extension we are using. This is the reason you'll see that we manually format some of our queries with `FORMAT_DATE()`.

You can run the queries in other tools like MySQL CLI or MySQL Workbench to see a cleaner version.
*/

/*markdown
## Date and Time Functions
Just like strings that have functions that deals with strings, date and time data types also have functions related to them. All the functions are listed in [MySQL Date and Time Functions](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html).
*/

/*markdown
### CURDATE(), CURTIME(), and NOW()
`CURDATE()` - synonym for `CURRENT_DATE()`:  
Returns the current DATE in `YYYY-MM-DD` or `YYYYMMDD` format, depending on whether the function is used in string or numeric context.

`CURTIME()` - synonym for `CURRENT_TIME()`:  
Returns the current TIME in `hh:mm:ss` or `hhmmss` format, depending on whether the function is used in string or numeric context.

`NOW()` - synonym for `CURRENT_TIMESTAMP()`, `LOCALTIME()`:  
Returns the current date and time in `YYYY-MM-DD hh:mm:ss` or `YYYYMMDDhhmmss`, depending on whether the function is used in string or numeric context.
*/

/*markdown
### CURDATE(), CURTIME(), and NOW() - Example
*/

SELECT
    CURDATE();

-- Or if you are seeing timezone info:
SELECT
    DATE_FORMAT(CURDATE(), '%Y-%m-%d');

SELECT
    CURTIME();

SELECT
    NOW();

INSERT INTO
    birthd_people (name, birth_date, birth_time, birth_dt)
VALUES
    ('Barfoo', CURDATE(), CURTIME(), NOW());

/*markdown
### Date Functions
These are some of the functions that can take DATE data types:

`DAY()`:  
Returns the day (integer of 1 to 31) for date. Returns 0 for dates with zero day part (such as 2008-00-00).

`DAYOFWEEK()`:  
Returns the week day (integer of 1 to 7, where 1 = Sunday , .., 7 = Saturday) for date.

`DAYOFYEAR()`:  
Returns the day of year (integer of 1 to 366) for date.

`MONTHNAME()`:  
Returns the name of the month of date.

`YEAR()`:  
Returns the year of date.
*/

/*markdown
### Date Functions - Example
*/

SELECT
    DATE_FORMAT(birth_date, '%Y-%m-%d') as birth_date,
    DAY(birth_date),
    DAYOFWEEK(birth_date),
    DAYOFYEAR(birth_date)
FROM
    people;

SELECT
    DATE_FORMAT(birth_date, '%Y-%m-%d') as birth_date,
    MONTHNAME(birth_date),
    YEAR(birth_date)
FROM
    people;

/*markdown
### Time Functions
These are some of the functions that can deal with DATETIME/TIME data types:

`HOUR()`:  
Returns the hour (0 - 23) for time.

`MINUTE()`:  
Returns the minute (0 - 59) for time.
*/

/*markdown
### Time Functions - Example
*/

SELECT
    birth_time,
    HOUR(birth_time),
    MINUTE(birth_time)
FROM
    people;

SELECT
    birth_dt,
    MONTH(birth_dt),
    DAY(birth_dt),
    HOUR(birth_dt),
    MINUTE(birth_dt)
FROM
    people;

/*markdown
## Formatting Dates using DATE_FORMAT()
If you want to format a DATETIME (or any variation of DATE/TIME) type to a specific format, you can use DATE_FORMAT:

`DATE_FORMAT(<date>, <format>)`

Where `format` is the format (in string form) you want to achieve. Format is specified by the use of format codes, for example, if you want to display the time in 24 hour format (hh:mm:ss), you can use the code `%T`. To see the list of format codes, see [DATE_FORMAT() on w3schools](https://www.w3schools.com/sql/func_mysql_date_format.asp).
*/

/*markdown
## Formatting Dates - Example
*/

-- Format birth date in month name abbrev (%b), and day with suffix (%D).
SELECT
    DATE_FORMAT(birth_date, '%Y-%m-%d') as birth_date,
    DATE_FORMAT(birth_date, '%b %D')
FROM
    birthd_people;

-- Format birth date in 12-hour time format
SELECT
    DATE_FORMAT(birth_dt, '%Y-%m-%d %H:%i:%s') as birth_dt,
    DATE_FORMAT(birth_dt, 'BORN ON: %r')
FROM
    birthd_people;

/*markdown
## Date Arithmetic
You can perform date arithmetic on dates either manually by treating them as numerics (by use of + or - operators), or by using functions (like `DATEDIFF()`). For example, when you use `DATEDIFF()`, you are getting the number days between two dates.
*/

/*markdown
### Arithmetic Functions
Some arithmetic functions are as follows:

`DATEDIFF()`:  
Subtract two dates, the result being the number of days.

`TIMEDIFF()`:  
Subtract two dates (DATE or TIME), the result being in time format (hh:mm:ss or hhh:mm:ss).
*/

/*markdown
#### DATE_ADD() and DATE_SUB()  
Adds/subtracts a date and an expression using temporal intervals:

`DATE_ADD(<date>, INTERVAL <expression> <unit>)`

To know about temporal interval, read [MySQL Temporal Interval](https://dev.mysql.com/doc/refman/8.0/en/expressions.html#temporal-intervals).

A quick way to be acquianted with the function is to see an example.
*/

/*markdown
#### DATE_ADD() and DATE_SUB() - Example
*/

-- Suppose we want to know the dates when the people in our table turns 25.
SELECT
    birth_date,
    DATE_ADD(birth_date, INTERVAL 25 YEAR)
FROM
    birthd_people;

-- Output may contain

-- The same as above, but without using a function.
SELECT
    birth_date,
    birth_date + INTERVAL 25 YEAR
FROM
    birthd_people;

/*markdown
## DEFAULT and ON UPDATE (DATETIME or TIMESTAMP)
Just like other data types, we can set the default value for a DATETIME (or TIMESTAMP) column, which is commonly the current time.

When any value (column) of a row is updated, we can update a DATETIME column by using the ON UPDATE keyword.
*/

/*markdown
### DATETIME Default
*/

CREATE TABLE < table_name > (
    < column > < DATETIME | TIMESTAMP > DEFAULT < value >
)

/*markdown
### DATETIME Default - Example
*/

-- Say we want to create a table containing "text" and a "created_on" field:
CREATE TABLE text_dates (
    text VARCHAR(150),
    created_on TIMESTAMP default CURRENT_TIMESTAMP
);

-- Now that we have our table, let us add a new entry with the text column only.
INSERT INTO
    text_dates (text)
VALUES
    ("I think, therefore I am");

-- Let us see our entry.
SELECT
    *
FROM
    text_dates;

-- Notice how created_on is set to the DATETIME the entry was created.

/*markdown
### ON UPDATE (Keyword)
When any value (column) of a row is updated, the column of the entry where ON UPDATE is specified is automatically updated.  
Read more on: [Automatic Initialization and Updating for TIMESTAMP and DATETIME](https://dev.mysql.com/doc/refman/8.0/en/timestamp-initialization.html).
*/

CREATE TABLE < table_name > (
    < column > < DATETIME | TIMESTAMP > ON UPDATE < value >
)

/*markdown
### ON UPDATE - Example
*/

-- Create a table to better illustrate the difference between DEFAULT and ON UPDATE
CREATE TABLE text_dates2 (
    text VARCHAR(150),
    created_on TIMESTAMP default CURRENT_TIMESTAMP,
    updated_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Add an entry
INSERT INTO
    text_dates2 (text)
VALUES
    ("I am, therefore I think");

-- Check entry
SELECT
    *
FROM
    text_dates2;

-- Update
UPDATE
    text_dates2
SET
    text = "I am not, therefore I think not"
WHERE
    text = "I am, therefore I think";

-- Check entry again. Notice how updated on was updated.
SELECT
    *
FROM
    text_dates2;