CREATE DATABASE test_db;

 USE test_db;
 
 CREATE TABLE customers (

       customer_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,

       first_name VARCHAR(50),

       last_name VARCHAR(50),

       phone VARCHAR(15)

       ) ENGINE = InnoDB;
       
INSERT INTO customers(first_name, last_name, phone) VALUES ('JOHN', 'DOE', '111111');

INSERT INTO customers(first_name, last_name, phone) VALUES ('MARY', 'SMITH', '222222');

INSERT INTO customers(first_name, last_name, phone) VALUES ('JACOB', 'JAMES', '444444');

INSERT INTO customers(first_name, last_name, phone) VALUES ('STEVE', 'JACKES', '888888');

INSERT INTO customers(first_name, last_name, phone) VALUES ('MARY', 'SMITH', '222222');

INSERT INTO customers(first_name, last_name, phone) VALUES ('RIAN', 'WHITE', '101010');

INSERT INTO customers(first_name, last_name, phone) VALUES ('APPLE', 'GRABRIEL', '242424');

INSERT INTO customers(first_name, last_name, phone) VALUES ('RIAN', 'WHITE', '101010');

INSERT INTO customers(first_name, last_name, phone) VALUES ('JACOB', 'JAMES', '444444');

INSERT INTO customers(first_name, last_name, phone) VALUES ('JOHN', 'DOE', '111111');


SELECT

       customer_id,

       first_name,

       last_name,

       phone

       FROM customers;
       
       
-- Determine the Duplicate Rows

SELECT
    
    first_name,
    last_name,
    phone,
    COUNT(*) AS total_count
FROM
    customers
GROUP BY
    first_name, last_name, phone
HAVING
    total_count > 1;

-- The next step is determining the rows that should remain when the duplicates are deleted.
-- Use the command below to get the PRIMARY KEYs of these rows.

SELECT MIN(customer_id)

       FROM CUSTOMERS

       GROUP BY CONCAT(first_name, last_name, phone);
       
-- Drop the Duplicate Rows

DELETE FROM customers

       WHERE customer_id NOT IN

       (

           SELECT

           customer_id

           FROM

           (

               SELECT MIN(customer_id) as customer_id

               FROM CUSTOMERS

               GROUP BY CONCAT(first_name, last_name, phone)

           ) AS duplicate_customer_ids

       );