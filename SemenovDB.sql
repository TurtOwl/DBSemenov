USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'GraphDB')
    DROP DATABASE GraphDB;
GO

CREATE DATABASE GraphDB;
GO

USE GraphDB;
GO

IF OBJECT_ID('graph', 'SCHEMA') IS NOT NULL
    DROP SCHEMA graph;
GO

CREATE SCHEMA graph;
GO

IF OBJECT_ID('graph.Students', 'U') IS NOT NULL
    DROP TABLE graph.Students;
GO

CREATE TABLE graph.Students (
    StudentID INT PRIMARY KEY,
    LastName NVARCHAR(50),
    FirstName NVARCHAR(50),
    Gender NVARCHAR(10),
    BirthDate DATE
);
GO

IF OBJECT_ID('graph.Courses', 'U') IS NOT NULL
    DROP TABLE graph.Courses;
GO

CREATE TABLE graph.Courses (
    CourseID INT PRIMARY KEY,
    CourseName NVARCHAR(100)
);
GO

IF OBJECT_ID('graph.Books', 'U') IS NOT NULL
    DROP TABLE graph.Books;
GO

CREATE TABLE graph.Books (
    BookID INT PRIMARY KEY,
    Title NVARCHAR(100),
    Genre NVARCHAR(50)
);
GO

IF OBJECT_ID('graph.Movies', 'U') IS NOT NULL
    DROP TABLE graph.Movies;
GO

CREATE TABLE graph.Movies (
    MovieID INT PRIMARY KEY,
    Title NVARCHAR(100),
    Genre NVARCHAR(50)
);
GO

IF OBJECT_ID('graph.Cities', 'U') IS NOT NULL
    DROP TABLE graph.Cities;
GO

CREATE TABLE graph.Cities (
    CityID INT PRIMARY KEY,
    CityName NVARCHAR(100),
    Country NVARCHAR(100)
);
GO

IF OBJECT_ID('graph.Friends', 'U') IS NOT NULL
    DROP TABLE graph.Friends;
GO

CREATE TABLE graph.Friends (
    FromStudentID INT,
    ToStudentID INT,
    PRIMARY KEY (FromStudentID, ToStudentID),
    FOREIGN KEY (FromStudentID) REFERENCES graph.Students(StudentID),
    FOREIGN KEY (ToStudentID) REFERENCES graph.Students(StudentID)
);
GO

IF OBJECT_ID('graph.Enrollments', 'U') IS NOT NULL
    DROP TABLE graph.Enrollments;
GO

CREATE TABLE graph.Enrollments (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES graph.Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES graph.Courses(CourseID)
);
GO

IF OBJECT_ID('graph.Recommends', 'U') IS NOT NULL
    DROP TABLE graph.Recommends;
GO

CREATE TABLE graph.Recommends (
    StudentID INT,
    BookID INT,
    PRIMARY KEY (StudentID, BookID),
    FOREIGN KEY (StudentID) REFERENCES graph.Students(StudentID),
    FOREIGN KEY (BookID) REFERENCES graph.Books(BookID)
);
GO

IF OBJECT_ID('graph.Watches', 'U') IS NOT NULL
    DROP TABLE graph.Watches;
GO

CREATE TABLE graph.Watches (
    StudentID INT,
    MovieID INT,
    PRIMARY KEY (StudentID, MovieID),
    FOREIGN KEY (StudentID) REFERENCES graph.Students(StudentID),
    FOREIGN KEY (MovieID) REFERENCES graph.Movies(MovieID)
);
GO

IF OBJECT_ID('graph.LivesIn', 'U') IS NOT NULL
    DROP TABLE graph.LivesIn;
GO

CREATE TABLE graph.LivesIn (
    StudentID INT,
    CityID INT,
    PRIMARY KEY (StudentID, CityID),
    FOREIGN KEY (StudentID) REFERENCES graph.Students(StudentID),
    FOREIGN KEY (CityID) REFERENCES graph.Cities(CityID)
);
GO


INSERT INTO graph.Students (StudentID, LastName, FirstName, Gender, BirthDate) VALUES 
    (1, 'Ivanov', 'Ivan', 'Male', '2000-05-15'),
    (2, 'Petrova', 'Olga', 'Female', '2001-09-20'),
    (3, 'Sidorov', 'Dmitry', 'Male', '2000-03-10'),
    (4, 'Fedorova', 'Elena', 'Female', '2001-07-05'),
    (5, 'Pavlov', 'Igor', 'Male', '2000-12-01'),
    (6, 'Kuznetsova', 'Elena', 'Female', '2001-02-14'),
    (7, 'Alexeev', 'Dmitry', 'Male', '2000-06-05'),
    (8, 'Smirnova', 'Maria', 'Female', '2001-08-20'),
    (9, 'Mikhailov', 'Vladimir', 'Male', '2000-10-15'),
    (10, 'Sergeeva', 'Elena', 'Female', '2001-12-30');

INSERT INTO graph.Courses (CourseID, CourseName) VALUES 
    (1, 'Mathematics'),
    (2, 'Physics'),
    (3, 'Computer Science'),
    (4, 'Chemistry'),
    (5, 'Biology'),
    (6, 'History'),
    (7, 'Literature'),
    (8, 'Art'),
    (9, 'Economics'),
    (10, 'Philosophy');

INSERT INTO graph.Books (BookID, Title, Genre) VALUES 
    (1, 'The Great Gatsby', 'Fiction'),
    (2, 'War and Peace', 'Historical Fiction'),
    (3, '1984', 'Dystopian'),
    (4, 'Pride and Prejudice', 'Romance'),
    (5, 'To Kill a Mockingbird', 'Fiction'),
    (6, 'Moby-Dick', 'Adventure'),
    (7, 'The Odyssey', 'Epic'),
    (8, 'Ulysses', 'Modernist'),
    (9, 'Hamlet', 'Tragedy'),
    (10, 'The Catcher in the Rye', 'Fiction');

INSERT INTO graph.Movies (MovieID, Title, Genre) VALUES 
    (1, 'The Shawshank Redemption', 'Drama'),
    (2, 'The Godfather', 'Crime'),
    (3, 'The Dark Knight', 'Action'),
    (4, 'Forrest Gump', 'Drama'),
    (5, 'Inception', 'Science Fiction'),
    (6, 'Pulp Fiction', 'Crime'),
    (7, 'Fight Club', 'Drama'),
    (8, 'The Matrix', 'Science Fiction'),
    (9, 'Goodfellas', 'Crime'),
    (10, 'The Lord of the Rings: The Return of the King', 'Fantasy');

INSERT INTO graph.Cities (CityID, CityName, Country) VALUES 
    (1, 'New York', 'USA'),
    (2, 'London', 'UK'),
    (3, 'Paris', 'France'),
    (4, 'Tokyo', 'Japan'),
    (5, 'Moscow', 'Russia'),
    (6, 'Berlin', 'Germany'),
    (7, 'Sydney', 'Australia'),
    (8, 'Toronto', 'Canada'),
    (9, 'Rome', 'Italy'),
    (10, 'Rio de Janeiro', 'Brazil');

INSERT INTO graph.Friends (FromStudentID, ToStudentID) VALUES 
    (1, 2), (2, 3), (3, 4), (4, 5), (5, 6), (6, 7), (7, 8), (8, 9), (9, 10), (10, 1);

INSERT INTO graph.Enrollments (StudentID, CourseID) VALUES
(1, 1), (1, 2), (2, 1), (2, 3), (3, 4), (3, 5), (4, 6), (4, 7), (5, 8), (5, 9),
(6, 1), (6, 10), (7, 2), (7, 3), (8, 4), (8, 5), (9, 6), (9, 7), (10, 8), (10, 9);

INSERT INTO graph.Recommends (StudentID, BookID) VALUES
(1, 1), (1, 2), (2, 3), (2, 4), (3, 5), (3, 6), (4, 7), (4, 8), (5, 9), (5, 10),
(6, 1), (6, 3), (7, 2), (7, 4), (8, 5), (8, 7), (9, 6), (9, 8), (10, 9), (10, 10);

INSERT INTO graph.Watches (StudentID, MovieID) VALUES
(1, 1), (1, 2), (2, 3), (2, 4), (3, 5), (3, 6), (4, 7), (4, 8), (5, 9), (5, 10),
(6, 1), (6, 3), (7, 2), (7, 4), (8, 5), (8, 7), (9, 6), (9, 8), (10, 9), (10, 10);

INSERT INTO graph.LivesIn (StudentID, CityID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

WITH FriendCTE AS (
SELECT FromStudentID, ToStudentID, 1 AS Level, CAST(FromStudentID AS NVARCHAR(MAX)) AS Path
FROM graph.Friends
WHERE FromStudentID = 1

UNION ALL

SELECT f.FromStudentID, f.ToStudentID, cte.Level + 1, CAST(cte.Path + '->' + CAST(f.ToStudentID AS NVARCHAR(MAX)) AS NVARCHAR(MAX))
FROM graph.Friends f
INNER JOIN FriendCTE cte ON f.FromStudentID = cte.ToStudentID
WHERE CHARINDEX('->' + CAST(f.ToStudentID AS NVARCHAR(MAX)) + '->', '->' + cte.Path + '->') = 0 AND cte.Level < 10)
SELECT s.*
FROM graph.Students s
INNER JOIN FriendCTE cte ON s.StudentID = cte.ToStudentID
OPTION (MAXRECURSION 10);

SELECT s.*
FROM graph.Students s
JOIN graph.Enrollments e ON s.StudentID = e.StudentID
JOIN graph.Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Mathematics';

SELECT s.*
FROM graph.Students s
JOIN graph.Recommends r ON s.StudentID = r.StudentID
JOIN graph.Books b ON r.BookID = b.BookID
WHERE b.Title = '1984';

SELECT c.*
FROM graph.Courses c
JOIN graph.Enrollments e ON c.CourseID = e.CourseID
JOIN graph.Students s ON e.StudentID = s.StudentID
WHERE s.StudentID = 2;

SELECT DISTINCT s1.*
FROM graph.Students s1
JOIN graph.Friends f ON s1.StudentID = f.FromStudentID
JOIN graph.Students s2 ON f.ToStudentID = s2.StudentID
JOIN graph.Enrollments e ON s2.StudentID = e.StudentID
JOIN graph.Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Physics';

WITH ShortestPathCTE AS (
SELECT FromStudentID, ToStudentID, 1 AS Level, CAST(FromStudentID AS NVARCHAR(MAX)) AS Path
FROM graph.Friends
WHERE FromStudentID = 1
UNION ALL

SELECT f.FromStudentID, f.ToStudentID, cte.Level + 1, CAST(cte.Path + '->' + CAST(f.ToStudentID AS NVARCHAR(MAX)) AS NVARCHAR(MAX))
FROM graph.Friends f
INNER JOIN ShortestPathCTE cte ON f.FromStudentID = cte.ToStudentID
WHERE CHARINDEX('->' + CAST(f.ToStudentID AS NVARCHAR(MAX)) + '->', '->' + cte.Path + '->') = 0 AND cte.Level < 10)
SELECT *
FROM ShortestPathCTE
WHERE ToStudentID = 10
ORDER BY Level
OPTION (MAXRECURSION 10);

WITH ShortestPathCTE AS (
SELECT StudentID, BookID, 1 AS Level, CAST(StudentID AS NVARCHAR(MAX)) AS Path
FROM graph.Recommends
WHERE StudentID = 1
UNION ALL

SELECT r.StudentID, r.BookID, cte.Level + 1, CAST(cte.Path + '->' + CAST(r.BookID AS NVARCHAR(MAX)) AS NVARCHAR(MAX))
FROM graph.Recommends r
INNER JOIN ShortestPathCTE cte ON r.StudentID = cte.StudentID
WHERE CHARINDEX('->' + CAST(r.BookID AS NVARCHAR(MAX)) + '->', '->' + cte.Path + '->') = 0 AND cte.Level < 10)
SELECT *
FROM ShortestPathCTE
WHERE StudentID = 5
ORDER BY Level
OPTION (MAXRECURSION 10);




