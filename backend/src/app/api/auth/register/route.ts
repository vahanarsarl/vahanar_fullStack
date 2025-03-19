// src/app/api/auth/register/route.ts
import { NextRequest, NextResponse } from 'next/server';
import authService from '@/services/auth.service';

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { email, password, firstName, lastName, phoneNumber } = body;
    
    if (!email || !password) {
      return NextResponse.json(
        { error: 'Email and password are required' },
        { status: 400 }
      );
    }
    
    const user = await authService.register({
      email,
      password,
      firstName,
      lastName,
      phoneNumber,
    });
    
    return NextResponse.json(user, { status: 201 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Registration failed' },
      { status: 400 }
    );
  }
}

// src/app/api/auth/login/route.ts
import { NextRequest, NextResponse } from 'next/server';
import authService from '@/services/auth.service';

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { email, password } = body;
    
    if (!email || !password) {
      return NextResponse.json(
        { error: 'Email and password are required' },
        { status: 400 }
      );
    }
    
    const result = await authService.login({ email, password });
    
    return NextResponse.json(result, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Login failed' },
      { status: 401 }
    );
  }
}

// src/app/api/auth/verify-phone/route.ts
import { NextRequest, NextResponse } from 'next/server';
import authService from '@/services/auth.service';
import { verifyAuthToken } from '@/lib/auth';

export async function POST(req: NextRequest) {
  try {
    // Verify auth token
    const authResult = await verifyAuthToken(req);
    if (!authResult.success) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    const body = await req.json();
    const { verificationCode } = body;
    
    if (!verificationCode) {
      return NextResponse.json(
        { error: 'Verification code is required' },
        { status: 400 }
      );
    }
    
    const result = await authService.verifyPhone(
      authResult.userId as string,
      verificationCode
    );
    
    return NextResponse.json(result, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Phone verification failed' },
      { status: 400 }
    );
  }
}

// src/app/api/auth/forgot-password/route.ts
import { NextRequest, NextResponse } from 'next/server';
import authService from '@/services/auth.service';

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { email } = body;
    
    if (!email) {
      return NextResponse.json(
        { error: 'Email is required' },
        { status: 400 }
      );
    }
    
    const result = await authService.forgotPassword(email);
    
    return NextResponse.json(result, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to process request' },
      { status: 400 }
    );
  }
}

// src/app/api/auth/reset-password/route.ts
import { NextRequest, NextResponse } from 'next/server';
import authService from '@/services/auth.service';

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { token, newPassword } = body;
    
    if (!token || !newPassword) {
      return NextResponse.json(
        { error: 'Token and new password are required' },
        { status: 400 }
      );
    }
    
    const result = await authService.resetPassword(token, newPassword);
    
    return NextResponse.json(result, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Password reset failed' },
      { status: 400 }
    );
  }
}