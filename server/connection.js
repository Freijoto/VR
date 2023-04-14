const { Pool } = require('pg');

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'schooldb',
  password: '20senh@23',
  port: '5432',
});

module.exports = {
  query: (text, params) => pool.query(text, params),
};