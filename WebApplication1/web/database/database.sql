-- =========================================================
-- CAPACITY CONNECT - COMPLETE DATABASE SCHEMA & SEED DATA
-- Database Name: capacity_connect
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
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE ON UPDATE CASCADE
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
        FOREIGN KEY (teacher_id) REFERENCES teachers(id)
        ON DELETE SET NULL ON UPDATE CASCADE
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
        FOREIGN KEY (course_id) REFERENCES courses(id)
        ON DELETE CASCADE ON UPDATE CASCADE
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
        FOREIGN KEY (course_id) REFERENCES courses(id)
        ON DELETE CASCADE ON UPDATE CASCADE
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
        FOREIGN KEY (student_id) REFERENCES users(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id) REFERENCES courses(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
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
        FOREIGN KEY (course_id) REFERENCES courses(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_assignment_teacher
        FOREIGN KEY (teacher_id) REFERENCES teachers(id)
        ON DELETE CASCADE ON UPDATE CASCADE
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
        FOREIGN KEY (assignment_id) REFERENCES assignments(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_submission_student
        FOREIGN KEY (student_id) REFERENCES users(id)
        ON DELETE CASCADE ON UPDATE CASCADE
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
        FOREIGN KEY (student_id) REFERENCES users(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_attendance_course
        FOREIGN KEY (course_id) REFERENCES courses(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_attendance_teacher
        FOREIGN KEY (teacher_id) REFERENCES teachers(id)
        ON DELETE CASCADE ON UPDATE CASCADE
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
        FOREIGN KEY (student_id) REFERENCES users(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_certificate_course
        FOREIGN KEY (course_id) REFERENCES courses(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- =========================================================
-- 12. CONTACT MESSAGES TABLE
-- =========================================================
CREATE TABLE contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    subject VARCHAR(200),
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- SEED DATA INSERTION
-- =========================================================

-- Admin
INSERT INTO admin (username, password) VALUES
('admin', 'admin123');

-- Users
INSERT INTO users (id, name, email, password, role) VALUES
(1, 'Prasanjit Bhakta', 'prasanjitbhakta99@gmail.com', '12345', 'STUDENT'),
(2, 'Shubaranjan Basu', 'basu@gmail.com', '1212', 'TEACHER'),
(3, 'Sagen Murmu', 'sagen@gmail.com', '123456789', 'TEACHER'),
(4, 'Devkumer Das', 'dev99@gmail.com', '12345', 'TEACHER');

-- Teachers
INSERT INTO teachers (id, name, user_id, qualification, specialization, phone, bio) VALUES
(1, 'Shubaranjan Basu', 2, 'M.Tech, CSE', 'AI & Data Science', '9876753458', 'Senior Faculty specializing in Artificial Intelligence, Deep Learning, and Cloud Architectures.'),
(2, 'Sagen Murmu', 3, 'M.Tech, Software Systems', 'Full Stack & Web Architecture', '9123846351', 'Senior Instructor with 10+ years experience in modern web frameworks and reactive programming.'),
(3, 'Devkumer Das', 4, 'M.Tech, Distributed Computing', 'Java Enterprise & Spring', '9145678997', 'Specialist in Java enterprise systems, microservices, and database tuning.');

-- Courses
INSERT INTO courses (id, title, category, description, level, duration, price, thumbnail, teacher_id, status) VALUES
(1, 'Java Programming for Beginners', 'Programming', 'Master Java from syntax to OOP, collections, multithreading, and real-world system architecture.', 'Beginner', '12 Weeks', 0.00, 'images/course-java.jpg', 3, 'ACTIVE'),
(2, 'React JS & Modern Web Development', 'Web Development', 'Build high-performance client applications using React 18, Hooks, state management, and Tailwind CSS.', 'Intermediate', '8 Weeks', 0.00, 'images/course-web.jpg', 2, 'ACTIVE'),
(3, 'Python Basics & Algorithmic Thinking', 'Programming', 'Hands-on Python course covering data structures, algorithmic puzzles, APIs, and practical scripting.', 'Beginner', '6 Weeks', 0.00, 'images/course-python.jpg', 1, 'ACTIVE'),
(4, 'Artificial Intelligence & Machine Learning', 'AI & ML', 'Comprehensive machine learning curriculum from regression and classification to neural networks and LLMs.', 'Advanced', '14 Weeks', 0.00, 'images/course-ai.jpg', 1, 'ACTIVE'),
(5, 'Cloud Computing & DevOps Engineering', 'Cloud', 'Containerization with Docker, Kubernetes clustering, CI/CD pipelines, and AWS cloud deployment.', 'Intermediate', '10 Weeks', 0.00, 'images/course-cloud.jpg', 2, 'ACTIVE'),
(6, 'Full Stack Web Development Bootcamp', 'Full Stack', 'End-to-end full stack mastery covering Frontend, Backend REST APIs, SQL databases, and cloud hosting.', 'Intermediate', '16 Weeks', 0.00, 'images/full-stack.jpg', 2, 'ACTIVE'),
(7, 'Database Systems & SQL Optimization', 'Database', 'Relational database design, ACID compliance, query optimization, indexing, and enterprise schema tuning.', 'Beginner', '6 Weeks', 0.00, 'images/course-database.jpg', 3, 'ACTIVE'),
(8, 'Cyber Security & Ethical Defense', 'Cyber Security', 'Network security protocols, penetration testing fundamentals, defensive architecture, and cryptography.', 'Intermediate', '8 Weeks', 0.00, 'images/course-cyber.jpg', 1, 'ACTIVE');

-- Course Videos
INSERT INTO course_videos (course_id, title, video_url) VALUES
(1, 'Introduction to Java Virtual Machine (JVM)', 'vedios/learning.mp4'),
(1, 'Object Oriented Architecture & Encapsulation', 'vedios/learning.mp4'),
(2, 'Component Lifecycles & Reactive State', 'vedios/learning.mp4'),
(3, 'Control Flow & Memory Models in Python', 'vedios/learning.mp4'),
(4, 'Supervised Learning & Gradient Descent', 'vedios/learning.mp4');

-- Resources
INSERT INTO resources (course_id, title, resource_type, resource_url) VALUES
(1, 'Java Notes (PDF)', 'PDF', 'images/course-java.jpg'),
(2, 'Web Dev Guide (DOC)', 'DOC', 'images/course-web.jpg'),
(1, 'DS Notes (PDF)', 'PDF', 'images/course-java.jpg'),
(2, 'UI/UX Basics (DOC)', 'DOC', 'images/course-web.jpg');

-- Enrollments for Student 1 (Prasanjit Bhakta)
INSERT INTO enrollments (student_id, course_id, progress, status) VALUES
(1, 1, 70.00, 'ENROLLED'),
(1, 2, 45.00, 'ENROLLED'),
(1, 3, 60.00, 'ENROLLED');

-- Assignments
INSERT INTO assignments (id, course_id, teacher_id, title, description, due_date, total_marks) VALUES
(101, 1, 3, 'Java Project Assignment', 'Implement a multi-tier student record management application using JDBC and Servlets.', '2026-11-10 23:59:59', 50),
(102, 2, 2, 'Web Development Quiz', 'Interactive assessment testing modern JavaScript ES6+ comprehension and DOM manipulation.', '2026-11-15 23:59:59', 30);

-- Attendance
INSERT INTO attendance (student_id, course_id, teacher_id, attendance_date, status) VALUES
(1, 1, 3, '2026-11-16', 'PRESENT'),
(1, 1, 3, '2026-11-17', 'PRESENT'),
(1, 2, 2, '2026-11-18', 'PRESENT'),
(1, 3, 1, '2026-11-19', 'PRESENT');

-- Certificates
INSERT INTO certificates (student_id, course_id, certificate_number, issue_date) VALUES
(1, 1, 'CC-CERT-00101', '2026-09-12');
