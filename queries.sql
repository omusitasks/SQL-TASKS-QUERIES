-- 1. Which materials are currently available in the library?
SELECT Material.Title, Catalog.Name
FROM Material
INNER JOIN Catalog ON Material.Catalog_ID = Catalog.Catalog_ID
WHERE Material.Material_ID NOT IN (SELECT Material_ID FROM Borrow WHERE Return_Date IS NULL);



-- 2. Which materials are currently overdue?
SELECT Material.Title, Borrow.Borrow_Date, Borrow.Due_Date
FROM Borrow
JOIN Material ON Borrow.Material_ID = Material.Material_ID
WHERE Borrow.Return_Date IS NULL AND Borrow.Due_Date > '2023-04-01';



-- 3. What are the top 10 most borrowed materials in the library?
SELECT Material.Title, COUNT(*) AS Borrow_Count
FROM Borrow
JOIN Material ON Borrow.Material_ID = Material.Material_ID
GROUP BY Borrow.Material_ID
ORDER BY Borrow_Count DESC
LIMIT 10;



-- 4. How many books has the author Lucas Piki written?
SELECT COUNT(*)
FROM Authorship
JOIN Author ON Authorship.Author_ID = Author.Author_ID
JOIN Material ON Authorship.Material_ID = Material.Material_ID
WHERE Author.Name = 'Lucas Piki' AND Material.Genre_ID = 1;


-- 5. How many books were written by two or more authors?
SELECT COUNT(DISTINCT Material_ID)
FROM Authorship
GROUP BY Material_ID
HAVING COUNT(*) > 1;

-- 6. What are the most popular genres in the library?
SELECT Genre.Name, COUNT(*) AS Borrow_Count
FROM Borrow
JOIN Material ON Borrow.Material_ID = Material.Material_ID
JOIN Genre ON Material.Genre_ID = Genre.Genre_ID
GROUP BY Genre.Genre_ID
ORDER BY Borrow_Count DESC;


-- 7. How many materials have been borrowed from 09/2020-10/2020?
SELECT COUNT(DISTINCT Material_ID)
FROM Borrow
WHERE Borrow_Date BETWEEN '2020-09-01' AND '2020-10-31';


-- 8. How do you update the “Harry Potter and the Philosopher's Stone” when it is returned on
-- 04/01/2023?
UPDATE Borrow
SET Return_Date = '2023-04-01'
WHERE Material_ID = (
SELECT Material_ID
FROM Material
WHERE Title = 'Harry Potter and the Philosopher''s Stone'
) AND Return_Date IS NULL;


-- 9. How do you delete the member Emily Miller and all her related records from the database?
DELETE FROM Borrow
WHERE Member_ID = (
SELECT Member_ID
FROM Member
WHERE Name = 'Emily Miller'
);
DELETE FROM Member
WHERE Name = 'Emily Miller';

-- 10. How do you add the following material to the database?

INSERT INTO Catalog (Catalog_ID, Name, Location)
VALUES (1, 'New Arrivals', 'Shelf A1');

INSERT INTO Genre (Genre_ID, Name, Description)
VALUES (7, 'Biography', 'Books about people''s lives');

INSERT INTO Material (Material_ID, Title, Publication_Date, Catalog_ID, Genre_ID)
VALUES (101, 'Becoming', '2018-11-13', 1, 7);

INSERT INTO Author (Author_ID, Name, Birth_Date, Nationality)
VALUES (23, 'Michelle Obama', '1964-01-17', 'American');

INSERT INTO Authorship (Authorship_ID, Author_ID, Material_ID)
VALUES (201, 23, 101);
