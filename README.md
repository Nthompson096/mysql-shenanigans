# mySQL-shenanigans

Just some scripts I made for mysql for the lulz.

## Create a schema and set default

    CREATE SCHEMA `tysql` ;
 
Pretty sure I don't have to explain what create does; it creates the schema with the name `tysql`.

    USE  `tysql`;

An explanation here, use basically tells the DBMS to use this database schema instead.

these examples I got from [Ben Fota](https://raw.githubusercontent.com/Nthompson096/mysql-shenanigans/main/create-tables-and-populate.txt?token=GHSAT0AAAAAAB2GWU7COPOJ7CON4P73VN34Y3JXX6Q), will be used to create and populate tables

## Create a table

    CREATE TABLE Customers
        
    (
     cust_id      char(10)  NOT NULL ,
     cust_name    char(50)  NOT NULL ,
     cust_address char(50)  NULL ,
     cust_city    char(50)  NULL ,
     cust_state   char(5)   NULL ,
     cust_zip     char(10)  NULL ,
     cust_country char(50)  NULL ,
     cust_contact char(50)  NULL ,
     cust_email   char(255) NULL 
    );

The CHAR() function returns the character based on the ASCII code.
The int data type is the primary integer data type in SQL Server. 
The bigint data type is intended for use when integer values might exceed the range that is supported by the int data type.

[A website from microsoft about init](https://learn.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql?view=sql-server-ver16)


## Define primary keys

    ALTER TABLE Customers ADD PRIMARY KEY (cust_id);

## Define foreign keys

    ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (cust_id) REFERENCES Customers (cust_id);

This Alters the table of Orders and adds a constraint which would be a foreign key that key is the cust_id and it would reference the Customers table the cust_id row.

## Insert Into

    INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country,
    cust_contact, cust_email)
    VALUES('1000000010', 'Allen Systems', '1911 Oak Ville', 'Anytown', 'PA', NULL, null, 'Marcus Allen',
    'sales@asystems.com');
    
Basically inserting data into an existing table, can use null (empty) values.

## Where, Like, soundEX

I'll have you four examples for where.

## Update table

    UPDATE Customers
    SET cust_address = '410 any street',
    cust_zip = '1910',
    cust_country = 'USA'
    WHERE cust_id = '1000000010';
    
Used to update values, including empty ones, where is used to specify the value of cust_id; can be used for other things as well such as LIKE. 
TL;DR Basically, altering parts of the table

## Like

    select prod_name, prod_desc 
    from Products
    where prod_desc LIKE '%toy%carrot%';

Like is basically searching for something LIKE "toy carrot", basically think of it sort of like google almost

## Concatenated distinct query

    SELECT DISTINCT
    quantity,
    LTRIM(cust_id) AS CID,
    CONCAT(RTRIM(cust_address),
            ' (',
            RTRIM(cust_state),
            ')') AS CUST_STATE,
    CONCAT(RTRIM(cust_contact),
            ' (',
            RTRIM(cust_email),
            ')') AS CEMAIL,
    CONCAT(RTRIM(vend_address),
            ' ',
            (vend_city),
            ' (',
            RTRIM(vend_state),
            ')') AS VENDADDRESS
    FROM
    Products,
    Customers,
    Vendors,
    OrderItems
    WHERE soundex(cust_contact) = SOUNDEX('Michael Green')
        AND quantity
    #   AND cust_email IS NOT NULL
        AND cust_state IS NOT NULL
        AND vend_state IS NOT NULL
    ORDER BY quantity ASC;
    
This one is tricky, basically what I had just told the database is to organize cust_id AS CID. cust_address and cust_state as cust_address, and to add in () for example: 10000010 1911 Oak Park (PA) USA and it would go on so and and so forth, I also told the database to order by quantity Ascending, and not show null values for the specific columns, also would show unique items. The AND is used to add in when you place in where. SoundEX basically a phonetic algorithm to figure out the sound of what something sounds LIKE.

## maths

    SELECT prod_id, quantity, item_price
    FROM OrderItems
    WHERE order_num = 20008;

    SELECT prod_id,
    quantity,
    item_price,
    quantity*item_price AS expanded_price
    FROM OrderItems
    WHERE order_num = 20008;

Another example with where, seeing you can do much with it; you can ask the DBMS if the order_num can have at exactly 20008


`quantity*item_price` is a math function, to multiply by 

    quantity
    *item_price

there are different math functions such as:

    add +
    sub -
    multiply *
    divide /
    Equal =
    less < or > more
    less than equal <= or => more than equal

In fact, this is what SQL really excels at; math and such of tables and to modify them and their values.

## Copy a table

    CREATE TABLE Custnew AS SELECT * FROM Customers;

As the title suggest, copies the table; great for editing stuff instead of working on live data directly.

# Delete drop

## Schema

    DROP SCHEMA tysql;
    
This destroys you're tables/rows because it's part of the schema.

## Delete from where

    DELETE FROM Customers WHERE cust_id = '1000000010';
    
Deletes a specific part of a table.

## Drop a table

    drop table Custnew;
    
Drops the table, essentially deletes it.
