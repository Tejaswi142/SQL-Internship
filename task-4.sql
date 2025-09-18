\-- Database Backup and Restore Script and Documentation

/\*
Step 1: Backup MySQL Database using mysqldump
\*/
\-- Command to run in terminal:
\-- mysqldump -u root -p CollegeDB > CollegeDB\_backup.sql

/\*
Step 2: Verify Backup
\*/
\-- Check the SQL file size or view contents
\-- Example (Linux/Mac):
\-- head CollegeDB\_backup.sql

/\*
Step 3: Restore Database in case of failure
\*/
\-- Option 1: Restore to the same database (overwrite)
mysql -u root -p CollegeDB < CollegeDB\_backup.sql

\-- Option 2: Restore to a new database
CREATE DATABASE CollegeDB\_Restore;
mysql -u root -p CollegeDB\_Restore < CollegeDB\_backup.sql

/\*
Step 4: Verification of Restore
*/
\-- Check table counts
SELECT COUNT(*) AS Student\_Count FROM Student;
SELECT COUNT(\*) AS Marks\_Count FROM Marks;

\-- Check sample data
SELECT \* FROM Student ORDER BY USN;
SELECT \* FROM Marks ORDER BY USN, Subject;

/\* Expected Output After Restore
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

Summary Report:

1. Used mysqldump to back up the database.
2. Verified backup by checking SQL file.
3. Restored backup to same or new database.
4. Verified row counts and sample data.
5. Data integrity confirmed: all tables and records successfully restored.
   \*/
