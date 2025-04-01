const dotenv = require('dotenv');
const result = dotenv.config({ path: '.env.test' });

if (result.error) {
  throw new Error('Failed to load .env.test file');
}

const request = require("supertest");
const { GET } = require("../src/app/api/health/route");
const { NextResponse } = require("next/server");

// Mock NextResponse.json
jest.mock("next/server", () => ({
  NextResponse: {
    json: jest.fn().mockImplementation((body, init) => {
      return {
        status: init?.status || 200,
        body,
        json: async () => body
      };
    })
  },
  NextRequest: jest.fn().mockImplementation(() => ({
    url: "http://localhost:3000/api/health"
  }))
}));

describe("API Tests", () => {
  test("GET /health should return 200", async () => {
    // Test the route handler directly
    const response = await GET();
    expect(response.status).toBe(200);
    
    const body = await response.json();
    expect(body.message).toBe("API is running");
  });
});