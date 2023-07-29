-- Prac #7
-- SQL Practice
-- 1. Using SQL Commands on MySQL Workbench for Creating a Database
-- Model
-- 2. Writing/Executing SQL queries in MySQL Workbench to extract
-- information from a database 

-- [Task 3]
-- Extract information from the database using SQL commands on MySQL Workbench

-- Q1. Write a query that displays the first and last name of every patron. (See the figure below for
-- first part of the output. The actual result will have 50 rows)

SELECT PAT_FNAME, PAT_LNAME
FROM patron
ORDER BY PAT_LNAME;

-- Q2. Write a query to display the checkout number, check out date, and due date for every book
-- that has been checked out sorted by checkout number. (See the figure below for first part of
-- the output. The actual result will have 68 rows)

SELECT 
checkout.CHECK_NUM, 
DATE_FORMAT(checkout.CHECK_OUT_DATE, '%m/%d/%Y') As CHECK_OUT_DATE,
DATE_FORMAT(checkout.CHECK_DUE_DATE, '%m/%d/%Y') As CHECK_DUE_DATE
FROM checkout
ORDER BY checkout.check_num;


-- Q3. Write a query to display the book number, book title, and subject for every book sorted by
-- book number (See the figure below for the output. The actual result will have 20 rows)

SELECT BOOK_NUM, book_title As TITLE, book_subject As "Subject of Book"
FROM book
ORDER BY book_num;


-- Q4. Write a query to display the book number, title, and cost of each book sorted by book
-- number (See the figure below for the output. The actual result will have 20 rows).

SELECT BOOK_NUM, BOOK_TITLE, book_cost As "Replacement Cost"
FROM book
ORDER BY book_num;


-- Q5. Write a query to display the different years in which books have been published in. Include
-- each year only once and sort the results by year (See the figure below for the output).

SELECT DISTINCT BOOK_YEAR
FROM book
ORDER BY book_year;


-- Q6. Write a query to display the different subjects on which this library has books. Include each
-- subject only once and sort the results by subject (See the figure below for the output).

SELECT DISTINCT BOOK_SUBJECT
FROM book
ORDER BY book_subject;


-- Q7. Write a query to display the checkout number, book number, patron ID, checkout date, and
-- due date for every checkout that has ever occurred in the system. Sort the results by
-- checkout date in descending order and then by checkout number in ascending order (See
-- the figure below for first part of the output. The actual result will have 68 rows)

SELECT 
checkout.CHECK_NUM,
checkout.BOOK_NUM, 
checkout.PAT_ID, 
DATE_FORMAT(checkout.CHECK_OUT_DATE, '%m/%d/%Y') As CHECK_OUT_DATE,
DATE_FORMAT(checkout.CHECK_DUE_DATE, '%m/%d/%Y') As CHECK_DUE_DATE
FROM checkout
ORDER BY checkout.check_out_date DESC, checkout.check_num;


-- Q8. Write a query to display the book title, year, and subject for every book. Sort the results by
-- book subject in ascending order, year in descending order, and then title in ascending order
-- (See the figure below for the output. The actual result will have 20 rows).

SELECT BOOK_TITLE, BOOK_YEAR, BOOK_SUBJECT
FROM book
ORDER BY book_subject, book_year DESC, book_title;


-- Q9. Write a query to display the book
-- number, title, and cost for all
-- books that cost $59.95 sorted by
-- book number (See the figure for the
-- output)

SELECT BOOK_NUM, BOOK_TITLE, BOOK_COST
FROM book
WHERE book_cost = 59.95
ORDER BY book_num;


-- Q10. Write a query to display the book number, title, and replacement cost for all books in the
-- “Database” subject sorted by book number (See the figure below for the output).

SELECT BOOK_NUM, BOOK_TITLE, BOOK_COST
FROM book
WHERE book_subject = "Database"
AND  book_title is not null
ORDER BY book_num;

-- Q11. Write a query to display the checkout
-- number, book number, and checkout date
-- of all books checked out before April 5,
-- 2017 sorted by checkout number (See the
-- figure for the output).

SELECT 
CHECK_NUM, 
BOOK_NUM, 
DATE_FORMAT(checkout.CHECK_OUT_DATE, '%m/%d/%Y') As CHECK_OUT_DATE
FROM checkout
WHERE check_out_date < '2017-04-05'
ORDER BY check_num;

-- Q12. Write a query to display the book number, title, and year of all books published after 2015
-- and on the “Programming” subject sorted by book number (See the figure below for the
-- output).

SELECT BOOK_NUM, BOOK_TITLE, BOOK_YEAR
FROM book
WHERE book_year > 2015 AND book_subject = "Programming"
ORDER BY book_num;


-- Q13. Write a query to display the book number, title, subject, and cost for all books that are on
-- the subjects of “Middleware” or “Cloud,” and that cost more than $70 sorted by book
-- number (See the figure below for the output).

SELECT BOOK_NUM, BOOK_TITLE, BOOK_SUBJECT, BOOK_COST
FROM book
WHERE book_subject IN ('Middleware', 'Cloud') AND book_cost > 70
ORDER BY book_num;


-- Q14. Write a query to display the author ID, first name, last name, and year of birth for all authors
-- born in the decade of the 1980s sorted by author ID (See the figure below for the output).

SELECT AU_ID, AU_FNAME, AU_LNAME, AU_BIRTHYEAR
FROM author
WHERE au_birthyear BETWEEN 1980 AND 1989
ORDER BY au_id;


-- Q15. Write a query to display the book number, title, and subject for all books that contain the
-- word “Database” in the title, regardless of how it is capitalized. Sort the results by book
-- number (See the figure below for the output).

SELECT BOOK_NUM, BOOK_TITLE, BOOK_SUBJECT
FROM book
WHERE book_title LIKE '%Database%'
ORDER BY book_num;


-- Q16. Write a query to display the patron ID, first and last name of all patrons who are students,
-- sorted by patron ID (See the figure below for first part of the output. The actual result will
-- have 44 rows)

SELECT PAT_ID, PAT_FNAME, PAT_LNAME
FROM patron
WHERE pat_type = 'Student'
ORDER BY pat_id;


-- Q17. Write a query to display the patron ID, first and last name, and patron type for all patrons
-- whose last name begins with the letter “C”, sorted by patron ID (See the figure below for the
-- output).

SELECT PAT_ID, PAT_FNAME, PAT_LNAME, PAT_TYPE
FROM patron
WHERE pat_lname LIKE 'C%'
ORDER BY pat_id;


-- Q18. Write a query to display the author ID, first and last name of all authors whose year of birth
-- is unknown. Sort the results by author ID (See the figure below for the output).

SELECT AU_ID, AU_FNAME, AU_LNAME
FROM author
WHERE au_birthyear IS NULL
ORDER BY au_id;


-- Q19. Write a query to display the author ID, first and last name of all authors whose year of birth
-- is known. Ensure the results are sorted by author ID (See the figure below for the output).

SELECT AU_ID, AU_FNAME, AU_LNAME
FROM author
WHERE au_birthyear IS NOT NULL
ORDER BY au_id;


-- Q20. Write a query to display the checkout number, book number, patron ID, check out date, and
-- due date for all checkouts that have not yet been returned. Sort the results by book number
-- (See the figure below for the output).

SELECT 
CHECK_NUM, 
BOOK_NUM, PAT_ID, 
DATE_FORMAT(checkout.CHECK_OUT_DATE, '%m/%d/%Y') As CHECK_OUT_DATE,
DATE_FORMAT(checkout.CHECK_DUE_DATE, '%m/%d/%Y') As CHECK_DUE_DATE

FROM checkout
WHERE check_in_date IS NULL
ORDER BY book_num;

-- Q21. Write a query to display the author ID, first name, last name, and year of birth for all
-- authors. Sort the results in descending order by year of birth, and then in ascending order
-- by last name (See the figure below for the output). (Note that some DBMS sort NULLs as
-- being large and some DBMS sort NULLs as being small.)

SELECT AU_ID, AU_FNAME, AU_LNAME, AU_BIRTHYEAR
FROM author
ORDER BY au_birthyear DESC, au_lname;


-- Q22. Write a query to display the patron ID, book number, and
-- days kept for each checkout. “Days Kept” is the difference
-- from the date on which the book is returned to the date it
-- was checked out. Sort the results by days kept in descending
-- order, then by patron ID, and then by book number. (See the
-- figure below for the output. The actual result will have 68
-- rows) 


SELECT PAT_ID AS PATRON, BOOK_NUM AS
BOOK, datediff(CHECK_IN_DATE,
CHECK_OUT_DATE) AS 'Days Kept'
FROM CHECKOUT
ORDER BY datediff(CHECK_IN_DATE, CHECK_OUT_DATE) DESC, PAT_ID,
BOOK_NUM;


-- Q23. Write a query to display the patron ID, patron full name, and patron type for each patron,
-- sorted by patron ID (See the figure below for the output. The actual result will have 50 rows)

SELECT PAT_ID, CONCAT(PAT_FNAME, ' ', PAT_LNAME) AS `Patron
Name`, PAT_TYPE
FROM PATRON
ORDER BY PAT_ID;


-- Q24. Write a query to display the book number, title with year, and subject for each book. Sort the
-- results by the book number (See the figure below for the output. The actual result will have
-- 20 rows)

SELECT
  BOOK_NUM,
  CONCAT(BOOK_TITLE, '(', BOOK_YEAR, ')') AS BOOK,
  BOOK_SUBJECT
FROM book
ORDER BY book_num;


-- Q25. Write a query to display the patron ID, full name (first and last), and patron type for all patrons.
-- Sort the results by patron type and then by last name and first name. Ensure that all sorting
-- is case insensitive. (See the figure below for the output. The actual result will have 50 rows)


SELECT
  PAT_ID,
  CONCAT(pat_fname, ' ', pat_lname) AS NAME,
  PAT_TYPE
FROM patron
ORDER BY pat_type, pat_lname, pat_fname COLLATE utf8mb4_general_ci;
















