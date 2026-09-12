-- =========================================================
-- CAPACITY CONNECT - COMPLETE DATABASE
-- =========================================================

DROP DATABASE IF EXISTS capacity_connect;

CREATE DATABASE capacity_connect;

USE capacity_connect;


-- =========================================================
-- 1. ADMIN TABLE
-- =========================================================

CREATE TABLE admin (
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255) NOT NULL
);


-- =========================================================
-- 2. USERS TABLE
-- =========================================================

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('STUDENT', 'TEACHER', 'ADMIN') NOT NULL
);


-- =========================================================
-- 3. TEACHERS TABLE
-- =========================================================

CREATE TABLE teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    user_id INT NOT NULL UNIQUE,
    qualification VARCHAR(100),
    specialization VARCHAR(100),
    phone VARCHAR(20),
    bio TEXT,

    CONSTRAINT fk_teacher_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================================
-- 4. COURSES TABLE
-- =========================================================

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    category VARCHAR(100),
    description TEXT,
    level VARCHAR(50),
    duration VARCHAR(50),
    price DECIMAL(10,2) DEFAULT 0.00,
    thumbnail VARCHAR(500),
    teacher_id INT,
    status VARCHAR(30) DEFAULT 'ACTIVE',

    CONSTRAINT fk_course_teacher
        FOREIGN KEY (teacher_id)
        REFERENCES teachers(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


-- =========================================================
-- 5. COURSE VIDEOS TABLE
-- =========================================================

CREATE TABLE course_videos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    video_url VARCHAR(500),

    CONSTRAINT fk_video_course
        FOREIGN KEY (course_id)
        REFERENCES courses(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================================
-- 6. RESOURCES TABLE
-- =========================================================

CREATE TABLE resources (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    resource_type VARCHAR(50),
    resource_url VARCHAR(500),

    CONSTRAINT fk_resource_course
        FOREIGN KEY (course_id)
        REFERENCES courses(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================================
-- 7. ENROLLMENTS TABLE
-- =========================================================

CREATE TABLE enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    progress DECIMAL(5,2) DEFAULT 0.00,
    status VARCHAR(30) DEFAULT 'ENROLLED',

    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id)
        REFERENCES courses(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT unique_enrollment
        UNIQUE (student_id, course_id)
);


-- =========================================================
-- 8. ASSIGNMENTS TABLE
-- =========================================================

CREATE TABLE assignments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    teacher_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    due_date DATETIME,
    total_marks INT DEFAULT 100,

    CONSTRAINT fk_assignment_course
        FOREIGN KEY (course_id)
        REFERENCES courses(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_assignment_teacher
        FOREIGN KEY (teacher_id)
        REFERENCES teachers(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================================
-- 9. SUBMISSIONS TABLE
-- =========================================================

CREATE TABLE submissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    assignment_id INT NOT NULL,
    student_id INT NOT NULL,
    submission_file VARCHAR(500),
    submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    marks INT,
    feedback TEXT,

    CONSTRAINT fk_submission_assignment
        FOREIGN KEY (assignment_id)
        REFERENCES assignments(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_submission_student
        FOREIGN KEY (student_id)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================================
-- 10. ATTENDANCE TABLE
-- =========================================================

CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    teacher_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,

    CONSTRAINT fk_attendance_student
        FOREIGN KEY (student_id)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_attendance_course
        FOREIGN KEY (course_id)
        REFERENCES courses(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_attendance_teacher
        FOREIGN KEY (teacher_id)
        REFERENCES teachers(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================================
-- 11. CERTIFICATES TABLE
-- =========================================================

CREATE TABLE certificates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    certificate_number VARCHAR(100) NOT NULL UNIQUE,
    issue_date DATE NOT NULL,

    CONSTRAINT fk_certificate_student
        FOREIGN KEY (student_id)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_certificate_course
        FOREIGN KEY (course_id)
        REFERENCES courses(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================================
-- SAMPLE DATA
-- =========================================================


-- =========================================================
-- ADMIN DATA
-- =========================================================

INSERT INTO admin (username, password)
VALUES
('admin', 'admin123');


-- =========================================================
-- USERS DATA
-- =========================================================

INSERT INTO users
(id, name, email, password, role)
VALUES
(1, 'Prasanjit Bhakta',
 'prasanjitbhakta99@gmail.com',
 '12345',
 'STUDENT'),

(2, 'shubaranjan basu',
 'basu@gmail.com',
 '1212',
 'TEACHER'),

(3, 'Sagen Murmu',
 'sagen@gmail.com',
 '123456789',
 'TEACHER'),

(5, 'Devkumer das',
 'dev99@gmail.com',
 '12345',
 'TEACHER');


-- =========================================================
-- TEACHERS DATA
-- =========================================================

INSERT INTO teachers
(name, user_id, qualification, specialization, phone, bio)
VALUES
(
    'shubaranjan basu',
    2,
    'M.Tech',
    'AI',
    '9876753458',
    'Keep Learning and Grow'
),
(
    'Sagen Murmu',
    3,
    'M.Tech',
    'AI',
    '9123846351',
    'syntax errors are just proof that you are trying'
),
(
    'Devkumer das',
    5,
    'M.Tech',
    'JAVA',
    '9145678997',
    'keep learning'
);


-- =========================================================
-- CHECK TABLES
-- =========================================================

SHOW TABLES;


-- =========================================================
-- CHECK STRUCTURES
-- =========================================================

DESC admin;
DESC users;
DESC teachers;
DESC courses;
DESC course_videos;
DESC enrollments;
DESC resources;
DESC assignments;
DESC submissions;
DESC attendance;
DESC certificates;


-- =========================================================
-- VIEW DATA
-- =========================================================

SELECT * FROM admin;

SELECT * FROM users;

SELECT * FROM teachers;

SELECT * FROM courses;

SELECT * FROM course_videos;

SELECT * FROM enrollments;

SELECT * FROM resources;

SELECT * FROM assignments;

SELECT * FROM submissions;

SELECT * FROM attendance;

SELECT * FROM certificates;