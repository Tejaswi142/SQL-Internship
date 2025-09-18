-- Executable SQL file for JOIN demonstration with full outputs

-- Step 1: Create database
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

-- Step 2: Create tables
CREATE TABLE IF NOT EXISTS Student (
    USN VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Branch VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Marks (
    USN VARCHAR(10),
    Subject VARCHAR(30) NOT NULL,
    Marks INT NOT NULL,
    FOREIGN KEY (USN) REFERENCES Student(USN)
);

-- Step 3: Insert sample data
INSERT INTO Student (USN, Name, Branch) VALUES
('S1', 'Rahul', 'CSE'),
('S2', 'Priya', 'ECE'),
('S3', 'Arjun', 'CSE'),
('S4', 'Meera', 'IT');

INSERT INTO Marks (USN, Subject, Marks) VALUES
('S1', 'DBMS', 85),
('S2', 'Networks', 78),
('S5', 'Java', 88);

-- Step 4: INNER JOIN
SELECT Student.USN, Student.Name, Marks.Subject, Marks.Marks
FROM Student
INNER JOIN Marks ON Student.USN = Marks.USN;
-- Expected Output:
-- | S1 | Rahul | DBMS     | 85 |
-- | S2 | Priya | Networks | 78 |

-- Step 5: LEFT JOIN
SELECT Student.USN, Student.Name, Marks.Subject, Marks.Marks
FROM Student
LEFT JOIN Marks ON Student.USN = Marks.USN;
-- Expected Output:
-- | S1 | Rahul | DBMS     | 85 |
-- | S2 | Priya | Networks | 78 |
-- | S3 | Arjun | NULL     | NULL |
-- | S4 | Meera | NULL     | NULL |

-- Step 6: RIGHT JOIN
SELECT Student.USN, Student.Name, Marks.Subject, Marks.Marks
FROM Student
RIGHT JOIN Marks ON Student.USN = Marks.USN;
-- Expected Output:
-- | S1 | Rahul | DBMS     | 85 |
-- | S2 | Priya | Networks | 78 |
-- | S5 | NULL  | Java     | 88 |

-- Step 7: FULL OUTER JOIN (MySQL workaround using UNION)
SELECT Student.USN, Student.Name, Marks.Subject, Marks.Marks
FROM Student
LEFT JOIN Marks ON Student.USN = Marks.USN
UNION
SELECT Student.USN, Student.Name, Marks.Subject, Marks.Marks
FROM Student
RIGHT JOIN Marks ON Student.USN = Marks.USN;
-- Expected Output:
-- | S1 | Rahul | DBMS     | 85 |
-- | S2 | Priya | Networks | 78 |
-- | S3 | Arjun | NULL     | NULL |
-- | S4 | Meera | NULL     | NULL |
-- | S5 | NULL  | Java     | 88 |