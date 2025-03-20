import { prisma } from '@/lib/db/prisma';
import bcrypt from 'bcryptjs';
import { signJWT } from '@/lib/auth/jwt';

export class AuthService {
  static async register(data: {
    email: string;
    password: string;
    firstName?: string;
    lastName?: string;
    phoneNumber?: string;
  }) {
    // Check if user exists
    const existingUser = await prisma.user.findUnique({
      where: { email: data.email },
    });

    if (existingUser) {
      throw new Error('User already exists');
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(data.password, 10);

    // Create new user
    const user = await prisma.user.create({
      data: {
        email: data.email,
        password: hashedPassword,
        firstName: data.firstName,
        lastName: data.lastName,
        phoneNumber: data.phoneNumber,
      },
    });

    // Generate JWT token
    const token = await signJWT({ userId: user.id });

    // Return user without password
    const { password, ...userWithoutPassword } = user;
    return { user: userWithoutPassword, token };
  }

  static async login(data: { email: string; password: string }) {
    // Find user
    const user = await prisma.user.findUnique({
      where: { email: data.email },
    });

    if (!user) {
      throw new Error('Invalid credentials');
    }

    // Check password
    const isPasswordValid = await bcrypt.compare(data.password, user.password);
    if (!isPasswordValid) {
      throw new Error('Invalid credentials');
    }

    // Generate JWT token
    const token = await signJWT({ userId: user.id });

    // Return user without password
    const { password, ...userWithoutPassword } = user;
    return { user: userWithoutPassword, token };
  }

  static async forgotPassword(email: string) {
    // Find user
    const user = await prisma.user.findUnique({
      where: { email },
    });

    if (!user) {
      throw new Error('User not found');
    }

    // In a real app, you would:
    // 1. Generate a password reset token
    // 2. Save it to the database with an expiration
    // 3. Send an email with a reset link

    // For this example, we'll just return success
    return { success: true, message: 'Password reset email sent' };
  }

  static async resetPassword(token: string, newPassword: string) {
    // In a real app, you would:
    // 1. Verify the token
    // 2. Check if it's expired
    // 3. Update the user's password

    // For this example, we'll mock this
    const hashedPassword = await bcrypt.hash(newPassword, 10);
    
    // This is a placeholder. In a real app, you'd use the token to find the user
    const userId = "mock-user-id";

    await prisma.user.update({
      where: { id: userId },
      data: { password: hashedPassword },
    });

    return { success: true, message: 'Password reset successfully' };
  }

  static async verifyPhone(userId: string, code: string) {
    // In a real app, you would:
    // 1. Verify the code against what was sent
    // 2. Mark the phone as verified

    // For this example, we'll mock verification
    const user = await prisma.user.update({
      where: { id: userId },
      data: { isPhoneVerified: true },
    });

    const { password, ...userWithoutPassword } = user;
    return userWithoutPassword;
  }
}