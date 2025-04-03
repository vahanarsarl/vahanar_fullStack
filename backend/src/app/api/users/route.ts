import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '../../../lib/db/prisma';
import { updateUserSchema } from '../../../lib/utils/validators';

export async function GET(request: NextRequest) {
  try {
    // Fetch all users directly using Prisma
    const users = await prisma.user.findMany();

    if (!users.length) {
      return NextResponse.json({ error: 'No users found' }, { status: 404 });
    }

    // Exclude passwords from the response
    const usersWithoutPasswords = users.map(({ password, ...user }) => user);

    return NextResponse.json(usersWithoutPasswords);
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Something went wrong' },
      { status: 500 }
    );
  }
}

export async function PATCH(request: NextRequest) {
  try {
    const body = await request.json();

    // Use a hardcoded user ID for testing
    const userId = 'dummy-user-id'; // Replace with a hardcoded value or mock logic for testing

    // Validate request body
    const result = updateUserSchema.safeParse(body);
    if (!result.success) {
      return NextResponse.json(
        { error: 'Validation error', details: result.error.errors },
        { status: 400 }
      );
    }

    // Update user directly using Prisma
    const updatedUser = await prisma.user.update({
      where: { id: userId },
      data: result.data,
    });

    // Exclude password from the response
    const { password, ...userWithoutPassword } = updatedUser;

    return NextResponse.json(userWithoutPassword);
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Something went wrong' },
      { status: 500 }
    );
  }
}