// src/lib/auth.ts
import jwt from 'jsonwebtoken';
import { NextRequest } from 'next/server';

interface JwtPayload {
  userId: string;
  email: string;
}

interface AuthResult {
  success: boolean;
  userId?: string;
  email?: string;
  error?: string;
}

export async function verifyAuthToken(req: NextRequest): Promise<AuthResult> {
  try {
    // Get token from Authorization header
    const authHeader = req.headers.get('Authorization');
    
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return { success: false, error: 'No token provided' };
    }
    
    const token = authHeader.split(' ')[1];
    
    // Verify token
    const decoded = jwt.verify(
      token,
      process.env.JWT_SECRET || 'fallback-secret'
    ) as JwtPayload;
    
    return {
      success: true,
      userId: decoded.userId,
      email: decoded.email,
    };
  } catch (error) {
    return { success: false, error: 'Invalid token' };
  }
}

// src/middleware.ts
import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';
import { verifyAuthToken } from './lib/auth';

// Paths that don't require authentication
const publicPaths = [
  '/api/auth/login',
  '/api/auth/register',
  '/api/auth/forgot-password',
  '/api/auth/reset-password',
  '/api/products', // Allow public product listing
  '/api/products/search', // Allow public product search
];

export async function middleware(request: NextRequest) {
  const path = request.nextUrl.pathname;
  
  // Check if the path is public
  if (publicPaths.some(p => path.startsWith(p)) && request.method === 'GET' || 
      publicPaths.some(p => path === p)) {
    return NextResponse.next();
  }
  
  // For product details, only GET requests are public
  if (path.match(/^\/api\/products\/[^\/]+$/) && request.method === 'GET') {
    return NextResponse.next();
  }
  
  // For all other paths, verify authentication
  const authResult = await verifyAuthToken(request);
  
  if (!authResult.success) {
    return NextResponse.json(
      { error: 'Unauthorized' },
      { status: 401 }
    );
  }
  
  // Add user info to request headers for route handlers
  const requestHeaders = new Headers(request.headers);
  requestHeaders.set('X-User-ID', authResult.userId as string);
  requestHeaders.set('X-User-Email', authResult.email as string);
  
  return NextResponse.next({
    request: {
      headers: requestHeaders,
    },
  });
}

export const config = {
  matcher: '/api/:path*',
};