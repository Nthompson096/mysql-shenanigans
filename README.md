# mySQL-shenanigans

Just some scripts I made for mysql for the lulz.

## Create a schema and set default

    CREATE SCHEMA `tysql` ;
     
Pretty sure I don't have to explain what create does; it creates the schema wit the name `tysql`.
     
     USE  `tysql`;

An explanation here, use basically tells the DBMS to use this database schema instead.

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


## Define primary keys

    ALTER TABLE Customers ADD PRIMARY KEY (cust_id);

## Define foreign keys

    ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (cust_id) REFERENCES Customers (cust_id);

## Insert Into

    INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country,
    cust_contact, cust_email)
    VALUES('1000000010', 'Allen Systems', '1911 Oak Ville', 'Anytown', 'PA', NULL, null, 'Marcus Allen',
    'sales@asystems.com');
    
Basically inserting data into an existing table, can use null (empty) values.

## Update table

    UPDATE Customers
    SET cust_address = '410 any street',
    cust_zip = '1910',
    cust_country = 'USA'
    WHERE cust_id = '1000000010';

Used to update values, including empty ones.

## Copy a table

    CREATE TABLE Custnew AS SELECT * FROM Customers;

As the title suggest, copies the table; great for editing stuff instead of working on live data directly.

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
    WHERE
    cust_email IS NOT NULL
        AND cust_state IS NOT NULL
        AND vend_state IS NOT NULL
    ORDER BY quantity ASC;
    
This one is tricky, basically what I had just told the database is to organize cust_id and cust_address into one, and to add in () for example: 10000010 1911 Oak Park (PA) USA and it would
go on so and and so forth, I also told the database to order by quantity Ascending, and not show null values for the specific columns, also would show unique items.

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
