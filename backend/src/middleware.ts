import { NextRequest, NextResponse } from 'next/server';

export async function middleware(request: NextRequest) {
  // Skip authentication for public routes
  const publicPaths = [
    '/api/auth/login',
    '/api/auth/register',
    '/api/auth/forgot-password',
    '/api/products'
  ];

  const path = request.nextUrl.pathname;

  // Allow all requests to proceed without authentication
  return NextResponse.next();
}

export const config = {
  matcher: ['/api/:path*'],
};