// src/services/booking.service.ts
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

class BookingService {
  /**
   * Create a new booking
   */
  async createBooking(data: any) {
    // Check if product is available
    const product = await prisma.product.findUnique({
      where: { id: data.productId }
    });
    
    if (!product || !product.availability) {
      throw new Error('Product is not available for booking');
    }
    
    // Check for date conflicts with existing bookings
    const conflictingBookings = await prisma.booking.findMany({
      where: {
        productId: data.productId,
        status: { in: ['pending', 'confirmed'] },
        OR: [
          {
            // New booking starts during an existing booking
            AND: [
              { startDate: { lte: new Date(data.startDate) } },
              { endDate: { gte: new Date(data.startDate) } }
            ]
          },
          {
            // New booking ends during an existing booking
            AND: [
              { startDate: { lte: new Date(data.endDate) } },
              { endDate: { gte: new Date(data.endDate) } }
            ]
          },
          {
            // New booking encompasses an existing booking
            AND: [
              { startDate: { gte: new Date(data.startDate) } },
              { endDate: { lte: new Date(data.endDate) } }
            ]
          }
        ]
      }
    });
    
    if (conflictingBookings.length > 0) {
      throw new Error('Selected dates are not available for booking');
    }
    
    // Create the booking
    const booking = await prisma.booking.create({
      data: {
        userId: data.userId,
        productId: data.productId,
        startDate: new Date(data.startDate),
        endDate: new Date(data.endDate),
        totalPrice: data.totalPrice,
        status: 'pending',
        notes: data.notes,
        paymentInfo: data.paymentInfo || {}
      }
    });
    
    return booking;
  }
  
  /**
   * Get a booking by ID
   */
  async getBookingById(id: string) {
    const booking = await prisma.booking.findUnique({
      where: { id },
      include: {
        product: true,
        user: {
          select: {
            id: true,
            email: true,
            firstName: true,
            lastName: true,
            phoneNumber: true,
            profileImage: true
          }
        }
      }
    });
    
    if (!booking) {
      throw new Error('Booking not found');
    }
    
    return booking;
  }
  
  /**
   * Get all bookings for a user
   */
  async getUserBookings(userId: string) {
    const bookings = await prisma.booking.findMany({
      where: { userId },
      include: {
        product: true
      },
      orderBy: {
        createdAt: 'desc'
      }
    });
    
    return bookings;
  }
  
  /**
   * Update booking status
   */
  async updateBookingStatus(id: string, status: string, userId: string) {
    // Check if booking exists and belongs to the user
    const booking = await prisma.booking.findUnique({
      where: { id }
    });
    
    if (!booking) {
      throw new Error('Booking not found');
    }
    
    if (booking.userId !== userId) {
      throw new Error('Unauthorized to update this booking');
    }
    
    // Update booking status
    const updatedBooking = await prisma.booking.update({
      where: { id },
      data: { status }
    });
    
    return updatedBooking;
  }
  
  /**
   * Cancel a booking
   */
  async cancelBooking(id: string, userId: string) {
    // Check if booking exists and belongs to the user
    const booking = await prisma.booking.findUnique({
      where: { id }
    });
    
    if (!booking) {
      throw new Error('Booking not found');
    }
    
    if (booking.userId !== userId) {
      throw new Error('Unauthorized to cancel this booking');
    }
    
    // Update booking status to cancelled
    const updatedBooking = await prisma.booking.update({
      where: { id },
      data: { status: 'cancelled' }
    });
    
    return updatedBooking;
  }
}

export default new BookingService();