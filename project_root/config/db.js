const mysql = require('mysql2');
require('dotenv').config();

const pool = mysql.createPool({
    host: process.env.IP_ADDRESS,
    user: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
    timezone: '+08:00'
});

// 每个新连接设置 MySQL 会话时区为东八区，确保 NOW()/CURRENT_TIMESTAMP 返回北京时间
pool.on('connection', (conn) => {
    conn.query("SET time_zone = '+08:00'");
});

module.exports = pool.promise();