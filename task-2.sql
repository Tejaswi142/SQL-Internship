-- Advanced SQL Analysis: Window Functions, Subqueries, and CTEs

-- Step 1: Create database and use it
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
('S4', 'Meera', 'IT'),
('S5', 'Nisha', 'ECE');

INSERT INTO Marks (USN, Subject, Marks) VALUES
('S1', 'DBMS', 85),
('S1', 'Java', 92),
('S2', 'Networks', 78),
('S2', 'DBMS', 88),
('S3', 'Java', 75),
('S3', 'Networks', 80),
('S4', 'DBMS', 65),
('S5', 'Java', 90);

-- Step 4: Use CTE to calculate total marks per student
WITH TotalMarks AS (
    SELECT S.USN, S.Name, S.Branch, SUM(M.Marks) AS Total_Marks
    FROM Student S
    JOIN Marks M ON S.USN = M.USN
    GROUP BY S.USN, S.Name, S.Branch
)
SELECT * FROM TotalMarks;
-- Expected Output:
-- | S1 | Rahul | CSE | 177 |
-- | S2 | Priya | ECE | 166 |
-- | S3 | Arjun | CSE | 155 |
-- | S4 | Meera | IT  | 65  |
-- | S5 | Nisha | ECE | 90  |

-- Step 5: Window function to rank students by total marks
SELECT USN, Name, Branch, Total_Marks,
       RANK() OVER (ORDER BY Total_Marks DESC) AS Rank_Overall
FROM (
    SELECT S.USN, S.Name, S.Branch, SUM(M.Marks) AS Total_Marks
    FROM Student S
    JOIN Marks M ON S.USN = M.USN
    GROUP BY S.USN, S.Name, S.Branch
) AS T;
-- Expected Output:
-- | S1 | Rahul | CSE | 177 | 1 |
-- | S2 | Priya | ECE | 166 | 2 |
-- | S3 | Arjun | CSE | 155 | 3 |
-- | S5 | Nisha | ECE | 90  | 4 |
-- | S4 | Meera | IT  | 65  | 5 |

-- Step 6: Subquery to find students who scored above average in any subject
SELECT S.USN, S.Name, M.Subject, M.Marks
FROM Student S
JOIN Marks M ON S.USN = M.USN
WHERE M.Marks > (
    SELECT AVG(Marks) FROM Marks WHERE Subject = M.Subject
);
-- Expected Output:
-- DBMS Average = (85+88+65)/3 = 79.33 -> Above avg: S1(85), S2(88)
-- Java Average = (92+75+90)/3 = 85.66 -> Above avg: S1(92), S5(90)
-- Networks Average = (78+80)/2 = 79 -> Above avg: S3(80)
-- | S1 | Rahul | DBMS     | 85 |
-- | S2 | Priya | DBMS     | 88 |
-- | S1 | Rahul | Java     | 92 |
-- | S5 | Nisha | Java     | 90 |
-- | S3 | Arjun | Networks | 80 |

-- Step 7: Window function to find running average per subject
SELECT USN, Name, Subject, Marks,
       AVG(Marks) OVER (PARTITION BY Subject ORDER BY Marks ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Avg
FROM Student S
JOIN Marks M ON S.USN = M.USN
ORDER BY Subject, Marks;
-- Expected Output:
-- DBMS: S4(65)=65, S1(85)=75, S2(88)=79.33
-- Java: S3(75)=75, S5(90)=82.5, S1(92)=85.66
-- Networks: S2(78)=78, S3(80)=79
-- Columns: USN | Name | Subject | Marks | Running_Avg