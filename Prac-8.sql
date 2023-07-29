-- Prac #8
-- SQL Practice II:
-- Writing/Executing advanced SQL queries in MySQL Workbench to extract
-- information from a database 

use fact2_db;

-- Q1. Write a query to display the number of books stored in the library database system (See the
-- figure below for the output).

SELECT COUNT(*) AS "Number of Books"
FROM book;

-- Q2. Write a query to display the number of different book subjects in this database system (See
-- the figure below for the output).

SELECT COUNT(DISTINCT BOOK_SUBJECT) AS "Number of Subjects"
FROM book;

-- Q3. Write a query to display the number of books that are available (not currently checked out)
-- (See the figure below for the output).

SELECT COUNT(*) AS "Available Books"
FROM book
WHERE PAT_ID IS NULL;

-- Q4. Write a query to display the highest book cost in the system (See the figure below for the
-- output).

SELECT MAX(BOOK_COST) AS "Most Expensive"
FROM book;


-- Q5. Write a query to display the lowest book cost in the system (See the figure below for the
-- output).

SELECT MIN(BOOK_COST) AS "Least Expensive"
FROM book;


-- Q6. Write a query to display the total value of all books in the library (See the figure below for
-- the output).

SELECT ROUND(SUM(BOOK_COST), 0) AS "Library Value"
FROM book;


-- Q7. Write a query to display the number of different patrons who have ever checked out a book
-- (See the figure below for the output).

SELECT COUNT(DISTINCT PAT_ID) AS "DIFFERENT PATRONS"
FROM checkout;

-- Q8. Write a query to display the subject and the number of books in each subject. Sort the
-- results by the number of books in descending order, then by subject name in ascending
-- order (See the figure below for the output).

SELECT BOOK_SUBJECT, COUNT(*) AS "Books In Subject"
FROM book
GROUP BY BOOK_SUBJECT
ORDER BY "Number of Books" DESC, BOOK_SUBJECT ASC;

-- Q9. Write a query to display the author ID and the number of
-- books written by that author. Sort the results in
-- descending order by number of books, then in ascending
-- order by author ID (See the figure for the output).

SELECT au_id, COUNT(*) AS "Number of Books"
FROM writes
GROUP BY au_id
ORDER BY COUNT(*) DESC, au_id;

-- Q10. Write a query to display the book number and the
-- number of times each book has been checked out. Do
-- not include books that have never been checked out. Sort
-- the results by the number of times checked out in
-- descending order and then by book number in
-- descending order (See the figure below for the output)

SELECT book_num, COUNT(check_num) AS "Times Checked Out"
FROM checkout
WHERE BOOK_NUM IS NOT NULL
GROUP BY BOOK_NUM
ORDER BY COUNT(check_num) DESC, BOOK_NUM;


-- Q11. Write a query to display the author last name, author
-- first name, and book number for each book written
-- by that author. Sort the results by author last name,
-- first name, and then book number (See the figure for
-- the output. The actual result will have 25 rows)


SELECT author.AU_LNAME, author.AU_FNAME, writes.BOOK_NUM
FROM author
INNER JOIN writes
ON author.au_id = writes.au_id
ORDER BY author.au_lname, author.au_fname, writes.book_num;


-- Q12. Write a query to display the author ID, book number, title, and subject for each book. Sort the
-- results by book number and then author ID (See the figure below for the output. The actual
-- result will have 25 rows)

SELECT author.AU_ID, book.BOOK_NUM, book.BOOK_TITLE, book.BOOK_SUBJECT
FROM author
INNER JOIN writes
ON author.au_id = writes.au_id
INNER JOIN book
ON writes.book_num = book.book_num
ORDER BY book.book_num, author.au_id;



-- SELECT COUNT(*) AS "Number of Rows"
-- FROM (
--   SELECT author.au_id, book.book_num, book.book_title, book.book_subject
--   FROM author
--   INNER JOIN writes
--   ON author.au_id = writes.au_id
--   INNER JOIN book
--   ON writes.book_num = book.book_num
--   ORDER BY book.book_num, author.au_id
-- ) AS t;


-- Q13. Write a query to display the author last name, first name, book title, and replacement cost for
-- each book. Sort the results by book number and then author ID (See the figure below for the
-- output. The actual result will have 25 rows)


SELECT author.AU_LNAME, author.AU_FNAME, book.BOOK_TITLE, book.BOOK_COST
FROM author
INNER JOIN writes
ON author.au_id = writes.au_id
INNER JOIN book
ON writes.book_num = book.book_num
ORDER BY book.book_num, author.au_id;


-- Q14. Write a query to display the patron ID, book number, patron first name and last name, and
-- book title for all currently checked out books. (Remember to use the redundant relationship
-- made between Patron and Book for current checkouts.) Sort the output by patron last name
-- and book title. (See the figure below for the output)

SELECT patron.PAT_ID, book.BOOK_NUM, patron.PAT_FNAME, patron.PAT_LNAME, book.BOOK_TITLE
FROM patron
INNER JOIN checkout
ON patron.pat_id = checkout.pat_id
INNER JOIN book
ON checkout.book_num = book.book_num
WHERE checkout.check_in_date IS NULL
ORDER BY patron.pat_lname, book.book_title;


-- Q15. Write a query to display the author ID, first and last name, book number, and book title of all
-- books in the subject “Cloud”. Sort the results by book title and then by author last name. (See
-- the figure below for the output)

SELECT author.AU_ID, author.AU_FNAME, author.AU_LNAME, book.BOOK_NUM, book.BOOK_TITLE
FROM author
INNER JOIN writes
ON author.au_id = writes.au_id
INNER JOIN book
ON writes.book_num = book.book_num
WHERE book.book_subject = 'Cloud'
ORDER BY book.book_title, author.au_lname;


-- Q16. Write a query to display the book number, title, author last name, author first name, patron
-- ID, last name, and patron type for all books currently checked out to a patron. Sort the results
-- by book title. (See the figure below for the output)

SELECT book.BOOK_NUM, book.BOOK_TITLE, author.AU_LNAME, author.AU_FNAME, patron.PAT_ID, patron.PAT_LNAME, patron.PAT_TYPE
FROM book
INNER JOIN writes
ON book.book_num = writes.book_num
INNER JOIN author
ON writes.au_id = author.au_id
INNER JOIN checkout
ON book.book_num = checkout.book_num
INNER JOIN patron
ON checkout.pat_id = patron.pat_id
WHERE checkout.check_in_date IS NULL
ORDER BY book.book_title;

-- Q17. Write a query to display the book number, title, and number of times each book has been
-- checked out. Include books that have never been checked out. Sort the results in descending
-- order by the number of times checked out and then by title. (See the figure below for the
-- output)

SELECT book.BOOK_NUM, book.BOOK_TITLE, COUNT(checkout.book_num) AS "Time Checked Out"
FROM book
LEFT JOIN checkout
ON book.book_num = checkout.book_num
GROUP BY book.book_num, book.book_title
ORDER BY COUNT(checkout.book_num) DESC, book.book_title;


-- Q18. Write a query to display the author ID, author last name, book title, checkout date, and patron
-- last name for all the books written by authors with the last name “Bruer” that have ever been
-- checked out by patrons with the last name “Miles”. Sort the results by check out date (See
-- the figure below for the output)

SELECT author.AU_ID, author.AU_LNAME, book.BOOK_TITLE, checkout.CHECK_OUT_DATE, patron.PAT_LNAME
FROM author
INNER JOIN writes
ON author.au_id = writes.au_id
INNER JOIN book
ON writes.book_num = book.book_num
INNER JOIN checkout
ON book.book_num = checkout.book_num
INNER JOIN patron
ON checkout.pat_id = patron.pat_id
WHERE author.au_lname = 'Bruer'
AND patron.pat_lname = 'Miles'
ORDER BY checkout.check_out_date;


-- Q19. Write a query to display the patron ID, first and last name
-- of all patrons that have never checked out any book. Sort
-- the result by patron last name and then first name. (See
-- the figure below for the output) 

SELECT patron.PAT_ID, patron.PAT_FNAME, patron.PAT_LNAME
FROM patron
LEFT JOIN checkout
ON patron.pat_id = checkout.pat_id
WHERE checkout.check_out_date IS NULL
ORDER BY patron.pat_lname, patron.pat_fname;


-- Q20. Write a query to display the book number, title, and number of times each book has been
-- checked out. Limit the results to books that have been checked out more than 5 times. Sort
-- the results in descending order by the number of times checked out and then by title. (See the figure
-- below for the output)


SELECT book.BOOK_NUM, book.BOOK_TITLE, COUNT(checkout.book_num) AS "Time Checked Out"
FROM book
LEFT JOIN checkout
ON book.book_num = checkout.book_num
GROUP BY book.book_num, book.book_title
HAVING COUNT(checkout.book_num) > 5
ORDER BY COUNT(checkout.book_num) DESC, book.book_title;


-- Q21. Write a query to display the patron ID, last name, number of times that patron has ever
-- checked out a book, and the number of different books the patron has ever checked out. For
-- example, if a given patron has checked out the same book twice, that would count as two
-- checkouts but only one book. Limit the results to only patrons that have made at
-- least three checkouts. Sort the results in descending order by number of books, then in
-- descending order by number of checkouts, and then in ascending order by patron ID.
-- (See the figure below for the output)


SELECT patron.PAT_ID, patron.PAT_LNAME, COUNT(checkout.BOOK_NUM) AS "NUM CHECKOUTS", COUNT(DISTINCT book.book_num) AS "NUM DIFFERENT BOOKS"
FROM patron
LEFT JOIN checkout
ON patron.pat_id = checkout.pat_id
LEFT JOIN book
ON checkout.book_num = book.book_num
WHERE checkout.check_out_date IS NOT NULL
GROUP BY patron.pat_id, patron.pat_lname
HAVING COUNT(checkout.book_num) >= 3
ORDER BY COUNT(DISTINCT book.book_num) DESC, COUNT(checkout.BOOK_NUM) DESC, patron.pat_id;


-- Q22. Write a query to display the average number of days a book is kept
-- during a checkout. (See the figure below for the output)


SELECT Round(Avg(datediff(CHECK_IN_DATE, CHECK_OUT_DATE)), 2)
AS "Average Days Kept"
FROM CHECKOUT;


-- Q23. Write a query to display the patron ID and the average number
-- of days that patron keeps books during a checkout. Limit the
-- results to only patrons who have at least three checkouts. Sort
-- the results in descending order by the average days the book is
-- kept. (See the figure below for the output)

SELECT patron.PAT_ID, ROUND(AVG(DATEDIFF(checkout.check_in_date,checkout.check_out_date)), 2) AS "Average Days Kept"
FROM patron
INNER JOIN checkout
ON patron.pat_id = checkout.pat_id
GROUP BY patron.pat_id
HAVING COUNT(checkout.pat_id) >= 3
ORDER BY AVG(DATEDIFF(checkout.check_in_date,checkout.check_out_date)) DESC;



















