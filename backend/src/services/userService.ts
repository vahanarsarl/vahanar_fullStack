import { prisma } from '@/lib/db/prisma';

export class UserService {
  static async getById(userId: string) {
    const user = await prisma.user.findUnique({
      where: { id: userId },
    });

    if (!user) {
      throw new Error('User not found');
    }

    const { password, ...userWithoutPassword } = user;
    return userWithoutPassword;
  }

  static async update(userId: string, data: {
    firstName?: string;
    lastName?: string;
    phoneNumber?: string;
  }) {
    const user = await prisma.user.update({
      where: { id: userId },
      data,
    });

    const { password, ...userWithoutPassword } = user;
    return userWithoutPassword;
  }

  static async getBookings(userId: string) {
    return prisma.booking.findMany({
      where: { userId },
      include: {
        product: true,
      },
      orderBy: {
        createdAt: 'desc',
      },
    });
  }
}