import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '../../../lib/db/prisma';
import { updateUserSchema } from '../../../lib/utils/validators';

export async function GET(request: NextRequest) {

  const startTime = Date.now(); // Capture start time

  const users = await prisma.user.findMany(); // Fetch data

  const endTime = Date.now(); // Capture end time
  console.log(`API Execution Time: ${endTime - startTime} ms`); // Log execution

  return NextResponse.json(users);

  try {
    const { searchParams } = request.nextUrl;
    const userId = searchParams.get('id'); // Get the user ID from query parameters

    if (userId) {
      // Fetch a specific user by ID
      const user = await prisma.user.findUnique({
        where: { id: userId },
      });

      if (!user) {
        return NextResponse.json({ error: 'User not found' }, { status: 404 });
      }

      // Exclude the password from the response
      const { password, ...userWithoutPassword } = user;
      return NextResponse.json(userWithoutPassword);
    }

    // If no ID is provided, fetch all users
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
    const { id: userId, ...data } = body; // Extract user ID from the request body

    if (!userId) {
      return NextResponse.json({ error: 'User ID is required' }, { status: 400 });
    }

    // Validate request body
    const result = updateUserSchema.safeParse(data);
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