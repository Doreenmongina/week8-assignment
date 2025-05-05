-- Create ScholarTrack Database
CREATE DATABASE IF NOT EXISTS scholar_track;
USE scholar_track;

-- Create Students Table
CREATE TABLE students (
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  admission_number VARCHAR(20) UNIQUE NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  gender ENUM('Male', 'Female', 'Other') NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone_number VARCHAR(20),
  address VARCHAR(255),
  enrollment_date DATE NOT NULL,
  class_id INT,
  parent_guardian_name VARCHAR(100) NOT NULL,
  parent_contact VARCHAR(20) NOT NULL
);

-- Create Courses Table
CREATE TABLE courses (
  course_id INT PRIMARY KEY AUTO_INCREMENT,
  course_code VARCHAR(20) UNIQUE NOT NULL,
  course_name VARCHAR(100) NOT NULL,
  description TEXT,
  credit_hours INT NOT NULL,
  teacher_name VARCHAR(100) NOT NULL
);

-- Create Enrollments Table (Junction Table)
CREATE TABLE enrollments (
  enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  enrollment_date DATE NOT NULL,
  grade VARCHAR(5),
  status ENUM('Active', 'Completed', 'Dropped') NOT NULL DEFAULT 'Active',
  FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
  UNIQUE (student_id, course_id)
);

-- Insert Sample Data into Students Table
INSERT INTO students (admission_number, first_name, last_name, date_of_birth, gender, email, phone_number, address, enrollment_date, class_id, parent_guardian_name, parent_contact) VALUES
('ST2025001', 'John', 'Smith', '2007-05-15', 'Male', 'john.smith@example.com', '555-123-4567', '123 Main St, Anytown', '2023-09-01', 10, 'Mary Smith', '555-987-6543'),
('ST2025002', 'Emily', 'Johnson', '2007-08-22', 'Female', 'emily.johnson@example.com', '555-234-5678', '456 Oak Ave, Somewhere', '2023-09-01', 10, 'Robert Johnson', '555-876-5432'),
('ST2025003', 'Michael', 'Williams', '2006-11-30', 'Male', 'michael.williams@example.com', '555-345-6789', '789 Pine Rd, Nowhere', '2022-09-01', 11, 'Patricia Williams', '555-765-4321'),
('ST2025004', 'Sophia', 'Brown', '2006-04-12', 'Female', 'sophia.brown@example.com', '555-456-7890', '101 Elm St, Anytown', '2022-09-01', 11, 'James Brown', '555-654-3210'),
('ST2025005', 'David', 'Jones', '2007-07-08', 'Male', 'david.jones@example.com', '555-567-8901', '234 Maple Dr, Somewhere', '2023-09-01', 10, 'Jennifer Jones', '555-543-2109'),
('ST2025006', 'Olivia', 'Garcia', '2008-01-25', 'Female', 'olivia.garcia@example.com', '555-678-9012', '567 Birch Ln, Nowhere', '2024-01-10', 9, 'Carlos Garcia', '555-432-1098'),
('ST2025007', 'Ethan', 'Martinez', '2008-03-17', 'Male', 'ethan.martinez@example.com', '555-789-0123', '890 Cedar Blvd, Anytown', '2024-01-10', 9, 'Maria Martinez', '555-321-0987'),
('ST2025008', 'Ava', 'Robinson', '2006-09-05', 'Female', 'ava.robinson@example.com', '555-890-1234', '321 Spruce Way, Somewhere', '2022-09-01', 11, 'Thomas Robinson', '555-210-9876'),
('ST2025009', 'Daniel', 'Clark', '2007-12-11', 'Male', 'daniel.clark@example.com', '555-901-2345', '654 Aspen Ct, Nowhere', '2023-09-01', 10, 'Elizabeth Clark', '555-109-8765'),
('ST2025010', 'Isabella', 'Rodriguez', '2008-06-20', 'Female', 'isabella.rodriguez@example.com', '555-012-3456', '987 Walnut Pl, Anytown', '2024-01-10', 9, 'Miguel Rodriguez', '555-098-7654');

-- Insert Sample Data into Courses Table
INSERT INTO courses (course_code, course_name, description, credit_hours, teacher_name) VALUES
('MATH101', 'Algebra I', 'Introduction to algebraic concepts including equations, inequalities, and polynomials', 4, 'Dr. Robert Chen'),
('ENGL101', 'English Literature', 'Study of classical and contemporary literature with focus on critical analysis', 3, 'Ms. Sarah Johnson'),
('SCI102', 'Biology', 'Introduction to living organisms, cell structure, and basic biological principles', 4, 'Mr. James Wilson'),
('HIST103', 'World History', 'Survey of major historical events and civilizations around the world', 3, 'Dr. Patricia Brown'),
('COMP104', 'Computer Science Basics', 'Introduction to programming concepts and algorithms', 3, 'Mr. Thomas Anderson'),
('PHYS105', 'Physics I', 'Study of mechanics, energy, and motion with laboratory work', 4, 'Dr. Lisa Wong'),
('CHEM106', 'Chemistry I', 'Introduction to atomic structure, periodic table, and chemical reactions', 4, 'Mr. David Miller'),
('ART107', 'Visual Arts', 'Exploration of drawing, painting, and design principles', 2, 'Ms. Emily Davis'),
('MUSIC108', 'Music Appreciation', 'Introduction to musical elements, genres, and historical periods', 2, 'Mr. Michael Thompson'),
('PE109', 'Physical Education', 'Development of physical fitness and team sports skills', 1, 'Coach Amanda Harris');

-- Insert Sample Data into Enrollments Table
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade, status) VALUES
(1, 1, '2023-09-01', 'A-', 'Active'),
(1, 2, '2023-09-01', 'B+', 'Active'),
(1, 3, '2023-09-01', 'B', 'Active'),
(2, 1, '2023-09-01', 'A', 'Active'),
(2, 4, '2023-09-01', 'B-', 'Active'),
(2, 5, '2023-09-01', 'A', 'Active'),
(3, 3, '2022-09-01', 'B+', 'Active'),
(3, 6, '2022-09-01', 'A-', 'Active'),
(3, 7, '2022-09-01', 'B', 'Active'),
(4, 2, '2022-09-01', 'A', 'Active'),
(4, 6, '2022-09-01', 'B+', 'Active'),
(4, 8, '2022-09-01', 'A+', 'Active'),
(5, 1, '2023-09-01', 'C+', 'Active'),
(5, 3, '2023-09-01', 'B-', 'Active'),
(5, 5, '2023-09-01', 'B+', 'Active'),
(6, 1, '2024-01-10', NULL, 'Active'),
(6, 2, '2024-01-10', NULL, 'Active'),
(6, 9, '2024-01-10', NULL, 'Active'),
(7, 1, '2024-01-10', NULL, 'Active'),
(7, 3, '2024-01-10', NULL, 'Active'),
(7, 5, '2024-01-10', NULL, 'Active'),
(8, 4, '2022-09-01', 'A-', 'Active'),
(8, 7, '2022-09-01', 'B+', 'Active'),
(8, 10, '2022-09-01', 'A', 'Active'),
(9, 2, '2023-09-01', 'B', 'Active'),
(9, 5, '2023-09-01', 'A-', 'Active'),
(9, 8, '2023-09-01', 'A', 'Active'),
(10, 1, '2024-01-10', NULL, 'Active'),
(10, 9, '2024-01-10', NULL, 'Active'),
(10, 10, '2024-01-10', NULL, 'Active');