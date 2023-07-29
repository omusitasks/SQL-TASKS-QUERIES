--  DATABASE SCHEMA
-- CREATE DATABASE LIBRARY;

-- DROP DATABASE LIBRARY;
USE LIBRARY;

--  CREATE TABLES IN THE DATABASE

-- Create Catalog table
CREATE TABLE Catalog (
    Catalog_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Location VARCHAR(255)
);

-- Create Genre table
CREATE TABLE Genre (
    Genre_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description TEXT
);

-- Create Material table
CREATE TABLE Material (
    Material_ID INT PRIMARY KEY,
    Title VARCHAR(255),
    Publication_Date DATE,
    Catalog_ID INT,
    Genre_ID INT,
    FOREIGN KEY (Catalog_ID) REFERENCES Catalog(Catalog_ID),
    FOREIGN KEY (Genre_ID) REFERENCES Genre(Genre_ID)
);


-- Create Member table
CREATE TABLE Member (
    Member_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Contact_Info VARCHAR(255),
    Join_Date DATE
);

-- Create Staff table
CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(255),
    Contact_Info VARCHAR(255),
    Job_Title VARCHAR(255),
    Hire_Date DATE
);


-- Create Borrow table
CREATE TABLE Borrow (
    Borrow_ID INT PRIMARY KEY,
    Material_ID INT,
    Member_ID INT,
    Staff_ID INT,
    Borrow_Date DATE,
    Due_Date DATE,
    Return_Date DATE,
    FOREIGN KEY (Material_ID) REFERENCES Material(Material_ID),
    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);

-- Create Author table
CREATE TABLE Author (
    Author_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Birth_Date DATE,
    Nationality VARCHAR(255)
);

-- Create Authorship table
CREATE TABLE Authorship (
    Authorship_ID INT PRIMARY KEY,
    Author_ID INT,
    Material_ID INT,
    FOREIGN KEY (Author_ID) REFERENCES Author(Author_ID),
    FOREIGN KEY (Material_ID) REFERENCES Material(Material_ID)
);
