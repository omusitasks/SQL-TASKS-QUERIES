-- GROUP BY and HAVING clauses to find and delete duplicate records in a database. 
-- Use the logic each time you import data from non-relational data sources to 
-- eliminate identical rows that might interfere with your business logic.

create database newdata;
drop table customers;
use newdata;

select * from customer;

-- Determine the Duplicate Rows

SELECT
    name,
    email,
    year,
    country,
    state,
    COUNT(*) as total_count
FROM 
    customer
GROUP BY
    name, email, year, country, state
HAVING 
    total_count > 1;


-- The next step is determining the rows that should remain when the duplicates are deleted.
-- Use the command below to get the PRIMARY KEYs of these rows.

SELECT MIN(id)

       FROM CUSTOMER

       GROUP BY CONCAT(name, email, year, country, state);
       
   
-- Drop the Duplicate Rows

DELETE FROM customer
       WHERE id NOT IN
       (
           SELECT id
           FROM
           (
               SELECT MIN(id) as id
               FROM CUSTOMER
          --      GROUP BY CONCAT(name, email, year, country, state)
          GROUP BY id
           ) AS duplicate_customer_ids
       );

0 row(s) affected, 1 warning(s): 1052 Column 'id' in group statement is ambiguous

DELETE FROM customer
WHERE id IN
(
  SELECT id
  FROM (
    SELECT id, COUNT(*) AS count
    FROM customer
    GROUP BY id
    HAVING COUNT(*) > 1
  ) AS duplicate_customers
);

select * from customer;
DELETE FROM customer
WHERE id IN
(
  SELECT id
  FROM (
    SELECT id, ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS row_num
    FROM customer
    GROUP BY id
    HAVING COUNT(*) > 1
  ) AS duplicate_customers
  WHERE row_num 
);




-- Ensure that your customers table doesn't contain any more duplicates by 
-- executing the GROUP BY and HAVING statement one more time.
-- This time around, you should get an Empty set since there are no duplicates.


SELECT
    name,
    email,
    year,
    country,
    state,
    COUNT(*) as total_count
FROM 
    customer
GROUP BY
    name, email, year, country, state
HAVING 
    total_count > 1;

-- Query the customers table again.
select * from customer;