-- Student Grading System
-- Created by: Prince
-- Date: May 2025

CREATE DATABASE IF NOT EXISTS student_db;
USE student_db;

-- Drop tables if already exist
DROP TABLE IF EXISTS marks;
DROP TABLE IF EXISTS students;

-- Table 1: Students
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    roll_no VARCHAR(10) UNIQUE,
    class_name VARCHAR(10),
    gender VARCHAR(10)
);

-- Table 2: Marks
CREATE TABLE marks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(30),
    marks INT,
    FOREIGN KEY (student_id) REFERENCES students(id)
);

-- Insert Students
INSERT INTO students (name, roll_no, class_name, gender) VALUES
('Rahul Sharma', '101', '10th', 'Male'),
('Priya Mehta', '102', '10th', 'Female'),
('Aman Verma', '103', '10th', 'Male'),
('Sneha Patel', '104', '10th', 'Female'),
('Rohan Das', '105', '10th', 'Male'),
('Kavya Iyer', '106', '10th', 'Female'),
('Arjun Nair', '107', '10th', 'Male'),
('Divya Singh', '108', '10th', 'Female');

-- Insert Marks
INSERT INTO marks (student_id, subject, marks) VALUES
(1, 'Maths', 78),
(1, 'Science', 82),
(1, 'English', 74),

(2, 'Maths', 92),
(2, 'Science', 88),
(2, 'English', 95),

(3, 'Maths', 55),
(3, 'Science', 60),
(3, 'English', 50),

(4, 'Maths', 85),
(4, 'Science', 79),
(4, 'English', 88),

(5, 'Maths', 40),
(5, 'Science', 45),
(5, 'English', 38),

(6, 'Maths', 91),
(6, 'Science', 94),
(6, 'English', 89),

(7, 'Maths', 67),
(7, 'Science', 72),
(7, 'English', 65),

(8, 'Maths', 88),
(8, 'Science', 85),
(8, 'English', 90);

-- Query 1: Student Report Card
SELECT
    s.name,
    s.roll_no,
    SUM(m.marks) AS total_marks,
    ROUND(AVG(m.marks),1) AS avg_marks,
    CASE
        WHEN AVG(m.marks) >= 80 THEN 'A'
        WHEN AVG(m.marks) >= 60 THEN 'B'
        WHEN AVG(m.marks) >= 40 THEN 'C'
        ELSE 'Fail'
    END AS grade
FROM students s
JOIN marks m
ON s.id = m.student_id
GROUP BY s.id, s.name, s.roll_no
ORDER BY avg_marks DESC;

-- Query 2: Subject-wise Statistics
SELECT
    subject,
    ROUND(AVG(marks),1) AS average_marks,
    MAX(marks) AS highest_marks,
    MIN(marks) AS lowest_marks
FROM marks
GROUP BY subject;

-- Query 3: Failed Students
SELECT
    s.name,
    s.roll_no,
    ROUND(AVG(m.marks),1) AS average_marks
FROM students s
JOIN marks m
ON s.id = m.student_id
GROUP BY s.id, s.name, s.roll_no
HAVING AVG(m.marks) < 40;

-- Query 4: Top 3 Students
SELECT
    s.name,
    ROUND(AVG(m.marks),1) AS average_marks
FROM students s
JOIN marks m
ON s.id = m.student_id
GROUP BY s.id, s.name
ORDER BY average_marks DESC
LIMIT 3;
