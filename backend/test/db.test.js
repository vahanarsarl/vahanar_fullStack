// test/db.test.js
require('dotenv').config({ path: '.env.test' });
const { PrismaClient } = require('@prisma/client');

describe('Database Connection', () => {
  let prisma;
  
  beforeAll(() => {
    prisma = new PrismaClient();
  });
  
  afterAll(async () => {
    await prisma.$disconnect();
  });
  
  test('Should fetch data from the test DB', async () => {
    // Try a simple query that should work even on an empty database
    const result = await prisma.$queryRaw`SELECT 1 as number`;
    expect(result[0].number).toBe(1);
  });
});