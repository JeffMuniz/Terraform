const mysql = require('mysql');

// Create a database connection
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'username',
  password: 'password',
  database: 'mydatabase'
});

// Connect to the database
connection.connect();

// Example of a vulnerable query without parameterization
function vulnerableQuery(username, callback) {
  const query = `SELECT * FROM users WHERE username = '${username}'`;
  connection.query(query, (error, results) => {
    if (error) throw error;
    callback(results[0]);
  });
}

// Example of a safe query using parameterization
function safeQuery(username, callback) {
  const query = 'SELECT * FROM users WHERE username = ?';
  connection.query(query, [username], (error, results) => {
    if (error) throw error;
    callback(results[0]);
  });
}

// Close the database connection
connection.end();
