import { NextRequest, NextResponse } from 'next/server';
import { AuthService } from '../../../../services/authService';
import { prisma } from '../../../../lib/db/prisma'; // Import Prisma client
import { registerUserSchema } from '../../../../lib/utils/validators';

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();

    // Validate request body
    const result = registerUserSchema.safeParse(body);
    if (!result.success) {
      return NextResponse.json(
        { error: 'Validation error', details: result.error.errors },
        { status: 400 }
      );
    }

    // Check if phone number already exists
    const existingUser = await prisma.user.findUnique({
      where: { phoneNumber: result.data.phoneNumber },
    });

    if (existingUser) {
      return NextResponse.json(
        { error: 'Phone number already in use' },
        { status: 400 }
      );
    }

    // Register user
    const { user, token } = await AuthService.register(result.data);

    return NextResponse.json({ user, token }, { status: 201 });
  } catch (error: any) {
    const statusCode = error.message === 'User already exists' ? 409 : 500;
    return NextResponse.json(
      { error: error.message || 'Something went wrong' },
      { status: statusCode }
    );
  }
}