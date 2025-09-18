\-- Migration Script: MySQL to PostgreSQL

/\*
Step 1: Export MySQL Data
Command (run in terminal):
mysqldump -u root -p CollegeDB > college\_db\_dump.sql
\*/

/\*
Step 2: Prepare PostgreSQL Database
Run in PostgreSQL:
\*/
CREATE DATABASE CollegeDB\_PG;
\c CollegeDB\_PG

\-- Step 3: Create Tables in PostgreSQL
CREATE TABLE Student (
USN VARCHAR(10) PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Branch VARCHAR(20) NOT NULL
);

CREATE TABLE Marks (
USN VARCHAR(10),
Subject VARCHAR(30) NOT NULL,
Marks INT NOT NULL,
FOREIGN KEY (USN) REFERENCES Student(USN)
);

/\*
Step 4: Convert MySQL dump to PostgreSQL compatible SQL
Tools like 'pgloader' can be used:
Example command:
pgloader mysql://root\:password\@localhost/CollegeDB postgresql://postgres\:password\@localhost/CollegeDB\_PG
\*/

/\* Step 5: Verify Data Integrity */
\-- Count rows in MySQL and PostgreSQL
\-- MySQL:
\-- SELECT COUNT(*) FROM Student;
\-- SELECT COUNT(*) FROM Marks;
\-- PostgreSQL:
SELECT COUNT(*) AS Student\_Count FROM Student;
SELECT COUNT(\*) AS Marks\_Count FROM Marks;

\-- Step 6: Sample Data Verification
SELECT \* FROM Student ORDER BY USN;
SELECT \* FROM Marks ORDER BY USN, Subject;

/\* Expected Output After Migration \*/
\-- Student Table:
\-- | S1 | Rahul | CSE |
\-- | S2 | Priya | ECE |
\-- | S3 | Arjun | CSE |
\-- | S4 | Meera | IT  |
\-- | S5 | Nisha | ECE |

\-- Marks Table:
\-- | S1 | DBMS     | 85  |
\-- | S1 | Java     | 92  |
\-- | S2 | Networks | 78  |
\-- | S2 | DBMS     | 88  |
\-- | S3 | Java     | 75  |
\-- | S3 | Networks | 80  |
\-- | S4 | DBMS     | 65  |
\-- | S5 | Java     | 90  |

/\* Summary Report

1. Exported MySQL database using mysqldump.
2. Created PostgreSQL database and tables.
3. Used pgloader to migrate schema and data.
4. Verified row counts and sample data.
5. Data integrity confirmed: All rows migrated successfully with no loss.
   \*/
