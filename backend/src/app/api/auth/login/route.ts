import { NextRequest, NextResponse } from 'next/server';
import { AuthService } from '../../../../services/authService';
import { loginUserSchema } from '../../../../lib/utils/validators';

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    
    // Validate request body
    const result = loginUserSchema.safeParse(body);
    if (!result.success) {
      return NextResponse.json(
        { error: 'Validation error', details: result.error.errors },
        { status: 400 }
      );
    }
    
    // Login user
    if (!result.data.email || !result.data.password) {
      return NextResponse.json(
        { error: 'Email and password are required' },
        { status: 400 }
      );
    }
    const { user, token } = await AuthService.login(result.data as { email: string; password: string });
    
    return NextResponse.json({ user, token });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Something went wrong' },
      { status: error.message === 'Invalid credentials' ? 401 : 500 }
    );
  }
}