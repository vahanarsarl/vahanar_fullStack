// src/services/product.service.ts
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

interface ProductFilters {
  category?: string;
  minPrice?: number;
  maxPrice?: number;
  location?: string;
  availability?: boolean;
  query?: string;
  tags?: string[];
}

class ProductService {
  /**
   * Get all products with pagination and filtering
   */
  async getProducts(
    page: number = 1,
    limit: number = 10,
    filters: ProductFilters = {}
  ) {
    const skip = (page - 1) * limit;
    
    // Build filter conditions
    const where: any = {};
    
    if (filters.category) {
      where.category = filters.category;
    }
    
    if (filters.minPrice || filters.maxPrice) {
      where.price = {};
      if (filters.minPrice) where.price.gte = filters.minPrice;
      if (filters.maxPrice) where.price.lte = filters.maxPrice;
    }
    
    if (filters.location) {
      where.location = {
        contains: filters.location,
        mode: 'insensitive'
      };
    }
    
    if (filters.availability !== undefined) {
      where.availability = filters.availability;
    }
    
    if (filters.query) {
      where.OR = [
        { name: { contains: filters.query, mode: 'insensitive' } },
        { description: { contains: filters.query, mode: 'insensitive' } }
      ];
    }
    
    if (filters.tags && filters.tags.length > 0) {
      where.tags = {
        hasEvery: filters.tags
      };
    }
    
    // Get products with pagination
    const products = await prisma.product.findMany({
      where,
      skip,
      take: limit,
      orderBy: {
        createdAt: 'desc'
      }
    });
    
    // Get total count for pagination
    const totalCount = await prisma.product.count({ where });
    
    return {
      data: products,
      meta: {
        page,
        limit,
        totalCount,
        totalPages: Math.ceil(totalCount / limit)
      }
    };
  }
  
  /**
   * Get a product by ID
   */
  async getProductById(id: string) {
    const product = await prisma.product.findUnique({
      where: { id }
    });
    
    if (!product) {
      throw new Error('Product not found');
    }
    
    return product;
  }
  
  /**
   * Create a new product
   */
  async createProduct(data: any) {
    const product = await prisma.product.create({
      data
    });
    
    return product;
  }
  
  /**
   * Update a product
   */
  async updateProduct(id: string, data: any) {
    const product = await prisma.product.update({
      where: { id },
      data
    });
    
    return product;
  }
  
  /**
   * Delete a product
   */
  async deleteProduct(id: string) {
    await prisma.product.delete({
      where: { id }
    });
    
    return { success: true };
  }
  
  /**
   * Search products
   */
  async searchProducts(query: string, page: number = 1, limit: number = 10) {
    const skip = (page - 1) * limit;
    
    const products = await prisma.product.findMany({
      where: {
        OR: [
          { name: { contains: query, mode: 'insensitive' } },
          { description: { contains: query, mode: 'insensitive' } },
          { category: { contains: query, mode: 'insensitive' } },
          { tags: { has: query } }
        ]
      },
      skip,
      take: limit,
      orderBy: {
        createdAt: 'desc'
      }
    });
    
    const totalCount = await prisma.product.count({
      where: {
        OR: [
          { name: { contains: query, mode: 'insensitive' } },
          { description: { contains: query, mode: 'insensitive' } },
          { category: { contains: query, mode: 'insensitive' } },
          { tags: { has: query } }
        ]
      }
    });
    
    return {
      data: products,
      meta: {
        page,
        limit,
        totalCount,
        totalPages: Math.ceil(totalCount / limit)
      }
    };
  }
}

export default new ProductService();