const { Pool } = require('pg');
const bcrypt = require('bcrypt');

// ตั้งค่าการเชื่อมต่อ PostgreSQL
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'project',
    password: '0957102316z',
    port: 5432
});

async function hashPasswords() {
    try {
        // ดึงข้อมูลผู้ใช้ทั้งหมดจากตาราง users
        const result = await pool.query('SELECT id, password FROM users');
        const users = result.rows;

        for (let user of users) {
            // เช็คว่ารหัสผ่านยังไม่ได้ถูกแฮช
            if (!user.password.startsWith('$2b$')) {
                // แฮชรหัสผ่านใหม่
                const hashedPassword = await bcrypt.hash(user.password, 10);

                // อัปเดตรหัสผ่านใหม่ที่แฮชแล้วกลับเข้าไปในฐานข้อมูล
                await pool.query('UPDATE users SET password = $1 WHERE id = $2', [hashedPassword, user.id]);
                console.log(`Password for user ID ${user.id} has been hashed and updated.`);
            } else {
                console.log(`Password for user ID ${user.id} is already hashed.`);
            }
        }

        console.log('All passwords have been processed.');
    } catch (err) {
        console.error('Error hashing passwords:', err);
    } finally {
        // ปิดการเชื่อมต่อฐานข้อมูล
        await pool.end();
    }
}

// เรียกใช้ฟังก์ชันแฮชรหัสผ่าน
hashPasswords();
