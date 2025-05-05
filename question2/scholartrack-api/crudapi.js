const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');

// Create an Express application
const app = express();
const port = 3000; //

// Database connection configuration
const db = mysql.createConnection({
  host: 'locahost',  
  user: 'root',  
  password: '20142014', 
  database: 'scholar_track', 
});

// Connect to the database
db.connect((err) => {
  if (err) {
    console.error('Database connection failed:', err);
    return;
  }
  console.log('Connected to the database');
});

// Middleware to parse JSON request bodies
app.use(bodyParser.json());


// API Endpoints for Students


/**
 * Create a new student.
 * POST /students
 * Request body: { admission_number, first_name, last_name, date_of_birth, gender, email, phone_number, address, enrollment_date, class_id, parent_guardian_name, parent_contact }
 */
app.post('/students', (req, res) => {
  const { admission_number, first_name, last_name, date_of_birth, gender, email, phone_number, address, enrollment_date, class_id, parent_guardian_name, parent_contact } = req.body;
  const sql = 'INSERT INTO students (admission_number, first_name, last_name, date_of_birth, gender, email, phone_number, address, enrollment_date, class_id, parent_guardian_name, parent_contact) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
  db.query(sql, [admission_number, first_name, last_name, date_of_birth, gender, email, phone_number, address, enrollment_date, class_id, parent_guardian_name, parent_contact], (err, result) => {
    if (err) {
      console.error('Error creating student:', err);
      res.status(500).json({ error: 'Failed to create student' });
      return;
    }
    res.status(201).json({ message: 'Student created successfully', student_id: result.insertId });
  });
});

/**
 * Get all students.
 * GET /students
 */
app.get('/students', (req, res) => {
  const sql = 'SELECT * FROM students';
  db.query(sql, (err, results) => {
    if (err) {
      console.error('Error fetching students:', err);
      res.status(500).json({ error: 'Failed to fetch students' });
      return;
    }
    res.status(200).json(results);
  });
});

/**
 * Get a single student by ID.
 * GET /students/:id
 */
app.get('/students/:id', (req, res) => {
  const id = req.params.id;
  const sql = 'SELECT * FROM students WHERE student_id = ?';
  db.query(sql, [id], (err, results) => {
    if (err) {
      console.error('Error fetching student:', err);
      res.status(500).json({ error: 'Failed to fetch student' });
      return;
    }
    if (results.length === 0) {
      res.status(404).json({ error: 'Student not found' });
      return;
    }
    res.status(200).json(results[0]);
  });
});

/**
 * Update a student by ID.
 * PUT /students/:id
 * Request body: { admission_number, first_name, last_name, date_of_birth, gender, email, phone_number, address, enrollment_date, class_id, parent_guardian_name, parent_contact } (all fields optional)
 */
app.put('/students/:id', (req, res) => {
  const id = req.params.id;
  const { admission_number, first_name, last_name, date_of_birth, gender, email, phone_number, address, enrollment_date, class_id, parent_guardian_name, parent_contact } = req.body;
  let sql = 'UPDATE students SET ';
  const updates = [];
  const values = [];

  if (admission_number) {
    updates.push('admission_number = ?');
    values.push(admission_number);
  }
  if (first_name) {
    updates.push('first_name = ?');
    values.push(first_name);
  }
  if (last_name) {
    updates.push('last_name = ?');
    values.push(last_name);
  }
  if (date_of_birth) {
    updates.push('date_of_birth = ?');
    values.push(date_of_birth);
  }
  if (gender) {
    updates.push('gender = ?');
    values.push(gender);
  }
  if (email) {
    updates.push('email = ?');
    values.push(email);
  }
  if (phone_number) {
    updates.push('phone_number = ?');
    values.push(phone_number);
  }
  if (address) {
    updates.push('address = ?');
    values.push(address);
  }
  if (enrollment_date) {
    updates.push('enrollment_date = ?');
    values.push(enrollment_date);
  }
  if (class_id) {
    updates.push('class_id = ?');
    values.push(class_id);
  }
  if (parent_guardian_name) {
    updates.push('parent_guardian_name = ?');
    values.push(parent_guardian_name);
  }
  if (parent_contact) {
    updates.push('parent_contact = ?');
    values.push(parent_contact);
  }

  if (updates.length === 0) {
    res.status(400).json({ error: 'No fields to update' });
    return;
  }

  sql += updates.join(', ');
  sql += ' WHERE student_id = ?';
  values.push(id);

  db.query(sql, values, (err, result) => {
    if (err) {
      console.error('Error updating student:', err);
      res.status(500).json({ error: 'Failed to update student' });
      return;
    }
    if (result.affectedRows === 0) {
      res.status(404).json({ error: 'Student not found' });
      return;
    }
    res.status(200).json({ message: 'Student updated successfully' });
  });
});

/**
 * Delete a student by ID.
 * DELETE /students/:id
 */
app.delete('/students/:id', (req, res) => {
  const id = req.params.id;
  const sql = 'DELETE FROM students WHERE student_id = ?';
  db.query(sql, [id], (err, result) => {
    if (err) {
      console.error('Error deleting student:', err);
      res.status(500).json({ error: 'Failed to delete student' });
      return;
    }
    if (result.affectedRows === 0) {
      res.status(404).json({ error: 'Student not found' });
      return;
    }
    res.status(200).json({ message: 'Student deleted successfully' });
  });
});


// API Endpoints for Courses


/**
 * Create a new course.
 * POST /courses
 * Request body: { course_code, course_name, description, credit_hours, teacher_name }
 */
app.post('/courses', (req, res) => {
  const { course_code, course_name, description, credit_hours, teacher_name } = req.body;
  const sql = 'INSERT INTO courses (course_code, course_name, description, credit_hours, teacher_name) VALUES (?, ?, ?, ?, ?)';
  db.query(sql, [course_code, course_name, description, credit_hours, teacher_name], (err, result) => {
    if (err) {
      console.error('Error creating course:', err);
      res.status(500).json({ error: 'Failed to create course' });
      return;
    }
    res.status(201).json({ message: 'Course created successfully', course_id: result.insertId });
  });
});

/**
 * Get all courses.
 * GET /courses
 */
app.get('/courses', (req, res) => {
  const sql = 'SELECT * FROM courses';
  db.query(sql, (err, results) => {
    if (err) {
      console.error('Error fetching courses:', err);
      res.status(500).json({ error: 'Failed to fetch courses' });
      return;
    }
    res.status(200).json(results);
  });
});

/**
 * Get a single course by ID.
 * GET /courses/:id
 */
app.get('/courses/:id', (req, res) => {
  const id = req.params.id;
  const sql = 'SELECT * FROM courses WHERE course_id = ?';
  db.query(sql, [id], (err, results) => {
    if (err) {
      console.error('Error fetching course:', err);
      res.status(500).json({ error: 'Failed to fetch course' });
      return;
    }
    if (results.length === 0) {
      res.status(404).json({ error: 'Course not found' });
      return;
    }
    res.status(200).json(results[0]);
  });
});

/**
 * Update a course by ID.
 * PUT /courses/:id
 * Request body: { course_code, course_name, description, credit_hours, teacher_name } (all fields optional)
 */
app.put('/courses/:id', (req, res) => {
  const id = req.params.id;
  const { course_code, course_name, description, credit_hours, teacher_name } = req.body;
  let sql = 'UPDATE courses SET ';
  const updates = [];
  const values = [];

  if (course_code) {
    updates.push('course_code = ?');
    values.push(course_code);
  }
  if (course_name) {
    updates.push('course_name = ?');
    values.push(course_name);
  }
  if (description) {
    updates.push('description = ?');
    values.push(description);
  }
  if (credit_hours) {
    updates.push('credit_hours = ?');
    values.push(credit_hours);
  }
  if (teacher_name) {
    updates.push('teacher_name = ?');
    values.push(teacher_name);
  }

  if (updates.length === 0) {
    res.status(400).json({ error: 'No fields to update' });
    return;
  }

  sql += updates.join(', ');
  sql += ' WHERE course_id = ?';
  values.push(id);

  db.query(sql, values, (err, result) => {
    if (err) {
      console.error('Error updating course:', err);
      res.status(500).json({ error: 'Failed to update course' });
      return;
    }
    if (result.affectedRows === 0) {
      res.status(404).json({ error: 'Course not found' });
      return;
    }
    res.status(200).json({ message: 'Course updated successfully' });
  });
});

/**
 * Delete a course by ID.
 * DELETE /courses/:id
 */
app.delete('/courses/:id', (req, res) => {
  const id = req.params.id;
  const sql = 'DELETE FROM courses WHERE course_id = ?';
  db.query(sql, [id], (err, result) => {
    if (err) {
      console.error('Error deleting course:', err);
      res.status(500).json({ error: 'Failed to delete course' });
      return;
    }
    if (result.affectedRows === 0) {
      res.status(404).json({ error: 'Course not found' });
      return;
    }
    res.status(200).json({ message: 'Course deleted successfully' });
  });
});


// API Endpoints for Enrollments


/**
 * Create a new enrollment.
 * POST /enrollments
 * Request body: { student_id, course_id, enrollment_date, grade, status }
 */
app.post('/enrollments', (req, res) => {
  const { student_id, course_id, enrollment_date, grade, status } = req.body;
  const sql = 'INSERT INTO enrollments (student_id, course_id, enrollment_date, grade, status) VALUES (?, ?, ?, ?, ?)';
  db.query(sql, [student_id, course_id, enrollment_date, grade, status], (err, result) => {
    if (err) {
      console.error('Error creating enrollment:', err);
      res.status(500).json({ error: 'Failed to create enrollment' });
      return;
    }
    res.status(201).json({ message: 'Enrollment created successfully', enrollment_id: result.insertId });
  });
});

/**
 * Get all enrollments.
 * GET /enrollments
 */
app.get('/enrollments', (req, res) => {
  const sql = 'SELECT * FROM enrollments';
  db.query(sql, (err, results) => {
    if (err) {
      console.error('Error fetching enrollments:', err);
      res.status(500).json({ error: 'Failed to fetch enrollments' });
      return;
    }
    res.status(200).json(results);
  });
});

/**
 * Get a single enrollment by ID.
 * GET /enrollments/:id
 */
app.get('/enrollments/:id', (req, res) => {
  const id = req.params.id;
  const sql = 'SELECT * FROM enrollments WHERE enrollment_id = ?';
  db.query(sql, [id], (err, results) => {
    if (err) {
      console.error('Error fetching enrollment:', err);
      res.status(500).json({ error: 'Failed to fetch enrollment' });
      return;
    }
    if (results.length === 0) {
      res.status(404).json({ error: 'Enrollment not found' });
      return;
    }
    res.status(200).json(results[0]);
  });
});

/**
 * Update an enrollment by ID.
 * PUT /enrollments/:id
 * Request body: { student_id, course_id, enrollment_date, grade, status } (all fields optional)
 */
app.put('/enrollments/:id', (req, res) => {
  const id = req.params.id;
  const { student_id, course_id, enrollment_date, grade, status } = req.body;
  let sql = 'UPDATE enrollments SET ';
  const updates = [];
  const values = [];

  if (student_id) {
    updates.push('student_id = ?');
    values.push(student_id);
  }
  if (course_id) {
    updates.push('course_id = ?');
    values.push(course_id);
  }
  if (enrollment_date) {
    updates.push('enrollment_date = ?');
    values.push(enrollment_date);
  }
  if (grade) {
    updates.push('grade = ?');
    values.push(grade);
  }
  if (status) {
    updates.push('status = ?');
    values.push(status);
  }

  if (updates.length === 0) {
    res.status(400).json({ error: 'No fields to update' });
    return;
  }

  sql += updates.join(', ');
  sql += ' WHERE enrollment_id = ?';
  values.push(id);

  db.query(sql, values, (err, result) => {
    if (err) {
      console.error('Error updating enrollment:', err);
      res.status(500).json({ error: 'Failed to update enrollment' });
      return;
    }
    if (result.affectedRows === 0) {
      res.status(404).json({ error: 'Enrollment not found' });
      return;
    }
    res.status(200).json({ message: 'Enrollment updated successfully' });
  });
});

/**
 * Delete an enrollment by ID.
 * DELETE /enrollments/:id
 */
app.delete('/enrollments/:id', (req, res) => {
  const id = req.params.id;
  const sql = 'DELETE FROM enrollments WHERE enrollment_id = ?';
  db.query(sql, [id], (err, result) => {
    if (err) {
      console.error('Error deleting enrollment:', err);
      res.status(500).json({ error: 'Failed to delete enrollment' });
      return;
    }
    if (result.affectedRows === 0) {
      res.status(404).json({ error: 'Enrollment not found' });
      return;
    }
    res.status(200).json({ message: 'Enrollment deleted successfully' });
  });
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

