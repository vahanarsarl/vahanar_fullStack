// src/services/user.service.ts
import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

class UserService {
  /**
   * Get user by ID
   */
  async getUserById(id: string) {
    const user = await prisma.user.findUnique({
      where: { id },
      select: {
        id: true,
        email: true,
        firstName: true,
        lastName: true,
        phoneNumber: true,
        isPhoneVerified: true,
        profileImage: true,
        createdAt: true,
        updatedAt: true
      }
    });
    
    if (!user) {
      throw new Error('User not found');
    }
    
    return user;
  }
  
  /**
   * Update user profile
   */
  async updateUser(id: string, data: any) {
    // Check if user exists
    const user = await prisma.user.findUnique({
      where: { id }
    });
    
    if (!user) {
      throw new Error('User not found');
    }
    
    // Remove sensitive fields that shouldn't be updated directly
    const { password, email, isPhoneVerified, ...updateData } = data;
    
    // Update user
    const updatedUser = await prisma.user.update({
      where: { id },
      data: updateData,
      select: {
        id: true,
        email: true,
        firstName: true,
        lastName: true,
        phoneNumber: true,
        isPhoneVerified: true,
        profileImage: true,
        createdAt: true,
        updatedAt: true
      }
    });
    
    return updatedUser;
  }
  
  /**
   * Change user password
   */
  async changePassword(id: string, currentPassword: string, newPassword: string) {
    // Check if user exists
    const user = await prisma.user.findUnique({
      where: { id }
    });
    
    if (!user) {
      throw new Error('User not found');
    }
    
    // Verify current password
    const isPasswordValid = await bcrypt.compare(currentPassword, user.password);
    if (!isPasswordValid) {
      throw new Error('Current password is incorrect');
    }
    
    // Hash new password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(newPassword, salt);
    
    // Update password
    await prisma.user.update({
      where: { id },
      data: { password: hashedPassword }
    });
    
    return { message: 'Password changed successfully' };
  }
  
  /**
   * Delete user account
   */
  async deleteUser(id: string) {
    // Check if user exists
    const user = await prisma.user.findUnique({
      where: { id }
    });
    
    if (!user) {
      throw new Error('User not found');
    }
    
    // Delete user
    await prisma.user.delete({
      where: { id }
    });
    
    return { message: 'User account deleted successfully' };
  }
}

export default new UserService();