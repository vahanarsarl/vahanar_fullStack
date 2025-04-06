const dotenv = require('dotenv');
const result = dotenv.config({ path: '.env.test' });

if (result.error) {
  throw new Error('Failed to load .env.test file');
}

describe("Sample Unit Test", () => {
    test("Basic Addition", () => {
      expect(2 + 2).toBe(4);
    });
  });