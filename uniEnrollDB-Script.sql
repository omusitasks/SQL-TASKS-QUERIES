use uniEnrolDB;

-- QUERIES
-- 1)List the First name, Last name, city, current salary and decreased salary (decrease the salary by 5 percent) of faculty hired before 1998. 
-- Note: HireDate must display the faculty’s hire date in the form shown. 

SELECT
  FacFirstName As FirstName,
  FacLastName As LastName,
  FacCity As City,
  Facsalary As facsalary,
  ROUND(Facsalary * 0.95, 0) AS DecreasedSalary,
  DATE_FORMAT(FacHireDate, '%m/%d/%Y') As HireDate
FROM
  faculty
WHERE
  FacHireDate < '1998-01-01';

-- 2)Write a query to display the SSN and names of faculty members, 
-- and the course number and offering-year for which the faculty member teaches the same course number as his or her supervisor in the same year.

SELECT
  faculty.FacSSN As facssn,
  CONCAT(faculty.FacFirstName, ' ', faculty.FacLastName) AS 'Faculty Name',
  offering.Offyear,
  offering.CourseNo
FROM
  faculty
INNER JOIN
  offering
ON
  faculty.FacSSN = offering.FacSSN
INNER JOIN
  offering AS supervisor
ON
  faculty.FacSupervisor = supervisor.FacSSN
WHERE
  offering.CourseNo = supervisor.CourseNo
  AND offering.Offyear = supervisor.Offyear;


-- 3)List the offer number, course number, and full name of the instructor (faculty) of all FINANCE courses (the course number’s prefix is ‘FIN’) 
-- offered in winter 2006 taught by professor. Note: professor’s rank is “PROF” in the database. 

SELECT
  offering.OfferNo,
  offering.CourseNo,
  CONCAT(faculty.FacFirstName, ' ', faculty.FacLastName) AS 'Instructor Name'
FROM
  faculty
INNER JOIN
  offering
ON
  faculty.FacSSN = offering.FacSSN
WHERE
  offering.CourseNo LIKE 'FIN%'
  AND offering.OffTerm = 'Winter'
  AND offering.OffYear = 2006
  AND faculty.FacRank = 'PROF';
  
-- 4)Write a query to summarize the average GPA of upper-division (junior (JR) or senior (SR)) students by major.
--  Only list the majors with average GPA greater than 2. 
  
  
SELECT
  StdMajor,
  ROUND(AVG(StdGPA), 1) AS AvgGPA
FROM
  student
WHERE
  StdClass IN ('JR', 'SR')
GROUP BY
  StdMajor
HAVING
  AvgGPA > 2
ORDER BY
  AvgGPA ASC;


-- 5)Summarize the number of offerings run in 2006 by offering location.

SELECT
  OffLocation,
  COUNT(*) AS 2006OfferCount
FROM
  offering
WHERE
  OffYear = 2006
GROUP BY
  OffLocation;

-- 6)List the offering number, course number, days, location, time, and instructor’s last name, for student Tess Dodge’s course schedule in 2006.

SELECT
  offering.OfferNo,
  offering.CourseNo,
  offering.OffDays,
  offering.OffLocation,
  offering.OffTime,
  faculty.FacLastName
FROM
  offering
INNER JOIN
  faculty
ON
  faculty.FacSSN = offering.FacSSN

WHERE
  offering.OffYear = 2006;



-- 7)List the course description, the course number, the number of offerings, and the average enrollment across offerings.

SELECT
  course.CrsDesc,
  course.CourseNo,
  COUNT(DISTINCT offering.offerNo) AS NumOfferings,
  -- COUNT(*) AS NumOfferings,
  AVG(offering.OffNumEnrolled) AS AvgEnroll
FROM
  course
INNER JOIN
  offering
ON
  course.CourseNo = offering.CourseNo
GROUP BY course.courseNo, course.crsDesc;


-- 8)For offerings beginning with IS in the associated course number, retrieve the offer number, the course number, the faculty number, and the faculty name. Include an offering in the result even if the faculty is not assigned. 
-- (Hint: Use lpad fundtion to fill ‘0’ at the start of FacSSN value if necessary)

SELECT
  offering.OfferNo,
  offering.CourseNo,
  faculty.FacSSN,
  faculty.FacFirstName,
  faculty.FacLastName
FROM
  offering
LEFT JOIN
  faculty ON
  offering.FacSSN  = faculty.FacSSN 
WHERE
  CourseNo LIKE 'IS%'
ORDER BY
  FacSSN ASC;

-- 9)List the Social Security Number (SSN), name and city of faculty who teach in winter terms. 
  
  SELECT
  faculty.FacSSN,
  CONCAT(faculty.FacFirstName, ' ', faculty.FacLastName) AS 'Instructor Name',
  faculty.FacCity
FROM
  faculty
INNER JOIN
  offering
ON
  faculty.FacSSN = offering.FacSSN
WHERE
  offering.OffTerm = 'Winter'
GROUP BY
  faculty.FacSSN,
  faculty.FacCity;


-- 10)List the name and rank of faculty who teach at least one offering of all of the 2006 
-- information systems (IS) courses and his/her supervisor’s name. 


SELECT
  faculty.FacFirstName,
  faculty.FacLastName,
  faculty.FacRank,
  faculty.FacSupervisor
FROM
  faculty
INNER JOIN
  offering
ON
  faculty.FacSSN = offering.FacSSN
WHERE
  offering.CourseNo LIKE 'IS%'
  AND offering.OffYear = 2006
GROUP BY
  faculty.FacSSN
HAVING
  faculty.FacSupervisor IS NOT NULL;
  
