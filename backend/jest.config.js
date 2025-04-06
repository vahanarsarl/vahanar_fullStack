module.exports = {
    testEnvironment: "node", // Ensures compatibility with backend APIs
    setupFilesAfterEnv: ["./test/setup.js"], // Runs setup scripts before tests
    testTimeout: 10000, // Prevents premature test failure on slow queries
  };