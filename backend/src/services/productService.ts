import { prisma } from '../lib/db/prisma';

export class ProductService {
  static async getAll(params: {
    category?: string;
    search?: string;
    page?: number;
    limit?: number;
  }) {
    const { category, search, page = 1, limit = 10 } = params;
    
    const skip = (page - 1) * limit;
    
    const where: any = {};
    
    if (category) {
      where.category = category;
    }
    
    if (search) {
      where.OR = [
        { name: { contains: search, mode: 'insensitive' } },
        { description: { contains: search, mode: 'insensitive' } },
      ];
    }
    
    const [products, total] = await Promise.all([
      prisma.product.findMany({
        where,
        skip,
        take: limit,
        orderBy: {
          createdAt: 'desc',
        },
      }),
      prisma.product.count({ where }),
    ]);
    
    return {
      products,
      meta: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    };
  }
  
  static async getById(id: string) {
    const product = await prisma.product.findUnique({
      where: { id },
    });
    
    if (!product) {
      throw new Error('Product not found');
    }
    
    return product;
  }
  
  static async create(data: {
    name: string;
    description: string;
    price: number;
    images?: string[];
    category: string;
    location?: string;
  }) {
    return prisma.product.create({
      data,
    });
  }
  
  static async checkAvailability(productId: string, startDate: Date, endDate: Date) {
    // Check if there are any bookings that overlap with the requested dates
    const overlappingBookings = await prisma.booking.findFirst({
      where: {
        productId,
        status: { not: 'cancelled' },
        OR: [
          {
            // Booking starts during the requested period
            startDate: {
              gte: startDate,
              lte: endDate,
            },
          },
          {
            // Booking ends during the requested period
            endDate: {
              gte: startDate,
              lte: endDate,
            },
          },
          {
            // Booking encompasses the requested period
            AND: [
              { startDate: { lte: startDate } },
              { endDate: { gte: endDate } },
            ],
          },
        ],
      },
    });
    
    return !overlappingBookings;
  }
}