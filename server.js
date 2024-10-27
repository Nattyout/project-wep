const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');
const path = require('path');
const bcrypt = require('bcrypt');
const session = require('express-session');

const app = express();

// Setup PostgreSQL connection
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'project',
    password: '0957102316z',
    port: 5432
});

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Setup session middleware
app.use(session({
    secret: 'your_secret_key',
    resave: false,
    saveUninitialized: true
}));

// Serve static files from public and views folders
app.use(express.static('public'));
app.use(express.static('views'));

// Route for Home page
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'index.html'));
});


// API to handle login
app.post('/api/login', async (req, res) => {
    const { username, password } = req.body;

    try {
        // Fetch user along with subject_id
        const query = 'SELECT id, password, subject_id FROM users WHERE username = $1';
        const result = await pool.query(query, [username]);

        if (result.rows.length === 0) {
            return res.status(401).json({ message: 'Invalid username' });
        }

        const user = result.rows[0];
        const isPasswordCorrect = await bcrypt.compare(password, user.password);

        if (!isPasswordCorrect) {
            return res.status(401).json({ message: 'Invalid password' });
        }

        // Successful login: store user ID and subject_id in the session
        req.session.userId = user.id;
        req.session.subjectId = user.subject_id;

        res.json({ message: 'Login successful', redirect: '/attendance.html' });
    } catch (err) {
        res.status(500).json({ message: 'Error logging in' });
    }
});


// API to get students based on subject ID
app.get('/api/get-students', async (req, res) => {
    const subjectId = req.session.subjectId;
    try {
        const query = `
            SELECT s.id, sdsj.number, p.prefix, s.first_name, s.last_name, st.section, sj.subject
            FROM student s
            INNER JOIN prefix p ON s.prefix_id = p.id
            INNER JOIN student_subject sdsj ON s.id = sdsj.student_id
            INNER JOIN section st ON sdsj.section_id = st.id
            INNER JOIN subject sj ON sdsj.subject_id = sj.id
            WHERE sj.id = $1
            ORDER BY sdsj.number`;
        const result = await pool.query(query, [subjectId]);
        res.json({ students: result.rows });
    } catch (err) {
        res.status(500).send("Error retrieving students");
    }
});

// API to insert attendance data
app.post('/api/insert-attendance', async (req, res) => {
    const { students } = req.body;
    try {
        for (const student of students) {
            const idResult = await pool.query(`
                SELECT MIN(s1.id + 1) AS lowest_available_id
                FROM student_list s1
                LEFT JOIN student_list s2 ON s1.id + 1 = s2.id
                WHERE s2.id IS NULL
            `);
            const lowestAvailableId = idResult.rows[0].lowest_available_id || 1;

            const subjectResult = await pool.query(`
                SELECT sdsj.subject_id
                FROM student_subject sdsj
                WHERE sdsj.student_id = $1
                LIMIT 1
            `, [student.student_id]);

            if (subjectResult.rows.length === 0) {
                return res.status(400).json({ message: `No subject found for student ID ${student.student_id}.` });
            }

            const subjectId = subjectResult.rows[0].subject_id;
            const nowInThailand = new Date().toLocaleString('en-US', { timeZone: 'Asia/Bangkok' });
            const activeDate = new Date(nowInThailand);

            await pool.query(
                `INSERT INTO student_list(id, subject_id, student_id, active_date, status)
                VALUES ($1, $2, $3, $4, $5)`,
                [lowestAvailableId, subjectId, student.student_id, activeDate, student.status]
            );
        }
        res.json({ message: "Attendance data inserted successfully." });
    } catch (err) {
        res.status(500).send("Error inserting attendance data");
    }
});

// API to search for a student based on student ID
app.get('/api/search-student', async (req, res) => {
    const { student_id } = req.query;

    if (!student_id || isNaN(student_id)) {
        return res.status(400).json({ message: 'Invalid or missing student ID.' });
    }

    try {
        const query = `
            SELECT sl.id, sl.student_id, sdsj.number, p.prefix, s.first_name, s.last_name, sj.subject, sl.active_date, sl.status
            FROM student_list sl
            INNER JOIN student s ON sl.student_id = s.id
            INNER JOIN student_subject sdsj ON s.id = sdsj.student_id
            INNER JOIN prefix p ON s.prefix_id = p.id
            INNER JOIN subject sj ON sdsj.subject_id = sj.id
            WHERE sl.student_id = $1
            order by sl.active_date`;
        const result = await pool.query(query, [student_id]);

        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'Student not found.' });
        }

        res.json(result.rows);
    } catch (err) {
        res.status(500).send("Error retrieving student information");
    }
});

// Edit student API
app.put('/api/edit-student', async (req, res) => {
    const { id, status } = req.body;  // Use the specific row's ID
    if (!id || !status) {
        return res.status(400).json({ message: 'Row ID and new status are required.' });
    }
    try {
        await pool.query(
            `UPDATE student_list SET status = $1 WHERE id = $2`,  // Target only the specific row by ID
            [status, id]
        );
        res.json({ message: 'Student status updated successfully.' });
    } catch (err) {
        res.status(500).json({ message: 'Error updating student status' });
    }
});


// Delete student API
app.delete('/api/delete-student', async (req, res) => {
    const { id } = req.query;  // Use the specific row's ID
    if (!id) {
        return res.status(400).json({ message: 'Row ID is required.' });
    }
    try {
        await pool.query(`DELETE FROM student_list WHERE id = $1`, [id]);  // Delete only the row by ID
        res.json({ message: 'Student deleted successfully.' });
    } catch (err) {
        res.status(500).json({ message: 'Error deleting student' });
    }
});


// API to get attendance data for a student based on student ID
app.get('/api/get-attendance', async (req, res) => {
    const { student_id } = req.query;

    if (!student_id || isNaN(student_id)) {
        return res.status(400).json({ message: 'Invalid or missing student ID.' });
    }

    try {
        const query = `
            SELECT sl.active_date, sl.status
            FROM student_list sl
            WHERE sl.student_id = $1`;
        const result = await pool.query(query, [student_id]);

        res.json(result.rows);
    } catch (err) {
        res.status(500).send("Error retrieving attendance data");
    }
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
