const dotenv = require('dotenv');
const result = dotenv.config({ path: '.env.test' });

if (result.error) {
  throw new Error('Failed to load .env.test file');
}

const { Client } = require("pg");

beforeAll(async () => {
  global.pgClient = new Client({
    user: "Postgres",
    password: "vahanar",
    database: "test_db",
    host: "localhost",
    port: 5432,
  });

  await global.pgClient.connect();
});

afterAll(async () => {
  await global.pgClient.end();
});