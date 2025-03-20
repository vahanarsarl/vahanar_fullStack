import { NextRequest, NextResponse } from 'next/server';
import { AuthService } from '../../../../services/authService';
import { z } from 'zod';

const verifyPhoneSchema = z.object({
  code: z.string().min(4, 'Verification code is required'),
});

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    
    // Validate request body
    const result = verifyPhoneSchema.safeParse(body);
    if (!result.success) {
      return NextResponse.json(
        { error: 'Validation error', details: result.error.errors },
        { status: 400 }
      );
    }
    
    // Get user ID from request headers (set by middleware)
    const userId = request.headers.get('x-user-id');
    if (!userId) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }
    
    // Verify phone
    const user = await AuthService.verifyPhone(userId, result.data.code);
    
    return NextResponse.json({ user });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Something went wrong' },
      { status: 500 }
    );
  }
}