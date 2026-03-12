-- Create Database
CREATE DATABASE library_db;
USE library_db;

-- Create Books Table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    category VARCHAR(50)
);

-- Create Members Table
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    name VARCHAR(100),
    join_date DATE
);

-- Create Issued Books Table
CREATE TABLE Issued_Books (
    issue_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    issue_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- Insert Books
INSERT INTO Books VALUES
(1,'Python Basics','John Smith','Programming'),
(2,'AI Introduction','David Lee','AI'),
(3,'Data Science Guide','Sarah Kim','Data Science'),
(4,'Machine Learning','Andrew Ng','AI'),
(5,'C Programming','Dennis Ritchie','Programming');

-- Insert Members
INSERT INTO Members VALUES
(1,'Rahul','2023-01-10'),
(2,'Anita','2023-03-15'),
(3,'Kiran','2023-05-20');

-- Insert Issued Books
INSERT INTO Issued_Books VALUES
(1,1,1,'2024-01-01','2024-01-10'),
(2,3,2,'2024-01-05','2024-01-15'),
(3,2,3,'2024-01-08',NULL);

-- View all books
SELECT * FROM Books;

-- View members
SELECT * FROM Members;

-- Books issued to members
SELECT Members.name, Books.title, Issued_Books.issue_date
FROM Issued_Books
JOIN Members ON Issued_Books.member_id = Members.member_id
JOIN Books ON Issued_Books.book_id = Books.book_id;

-- Find books not returned
SELECT title
FROM Books
JOIN Issued_Books ON Books.book_id = Issued_Books.book_id
WHERE return_date IS NULL;

-- Count books by category
SELECT category, COUNT(*) AS total_books
FROM Books
GROUP BY category;

-- Most borrowed books
SELECT Books.title, COUNT(*) AS times_borrowed
FROM Issued_Books
JOIN Books ON Issued_Books.book_id = Books.book_id
GROUP BY Books.title
ORDER BY times_borrowed DESC;