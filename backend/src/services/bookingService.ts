import { prisma } from '@/lib/db/prisma';
import { ProductService } from './productService';

export class BookingService {
  static async create(data: {
    userId: string;
    productId: string;
    startDate: Date;
    endDate: Date;
  }) {
    const { userId, productId, startDate, endDate } = data;
    
    // Check product availability
    const isAvailable = await ProductService.checkAvailability(
      productId,
      startDate,
      endDate
    );
    
    if (!isAvailable) {
      throw new Error('Product is not available for the selected dates');
    }
    
    // Get product details to calculate total price
    const product = await ProductService.getById(productId);
    
    // Calculate number of days
    const days = Math.ceil(
      (endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24)
    );
    
    // Calculate total price
    const totalPrice = product.price * days;
    
    // Create booking
    return prisma.booking.create({
      data: {
        userId,
        productId,
        startDate,
        endDate,
        totalPrice,
        status: 'pending',
      },
      include: {
        product: true,
      },
    });
  }
  
  static async getById(id: string, userId: string) {
    const booking = await prisma.booking.findUnique({
      where: { id },
      include: {
        product: true,
      },
    });
    
    if (!booking) {
      throw new Error('Booking not found');
    }
    
    // Ensure user owns this booking
    if (booking.userId !== userId) {
      throw new Error('Unauthorized');
    }
    
    return booking;
  }
  
  static async updateStatus(id: string, userId: string, status: string) {
    // First check if booking exists and belongs to user
    await this.getById(id, userId);
    
    return prisma.booking.update({
      where: { id },
      data: { status },
      include: {
        product: true,
      },
    });
  }
  
  static async getUserBookings(userId: string) {
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