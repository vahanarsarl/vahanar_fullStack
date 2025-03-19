// src/services/help-center.service.ts
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

class HelpCenterService {
  /**
   * Get all help center articles
   */
  async getAllArticles() {
    const articles = await prisma.helpCenter.findMany({
      orderBy: {
        createdAt: 'desc'
      }
    });
    
    return articles;
  }
  
  /**
   * Get help center articles by category
   */
  async getArticlesByCategory(category: string) {
    const articles = await prisma.helpCenter.findMany({
      where: {
        category
      },
      orderBy: {
        createdAt: 'desc'
      }
    });
    
    return articles;
  }
  
  /**
   * Get a help center article by ID
   */
  async getArticleById(id: string) {
    const article = await prisma.helpCenter.findUnique({
      where: { id }
    });
    
    if (!article) {
      throw new Error('Article not found');
    }
    
    return article;
  }
  
  /**
   * Search help center articles
   */
  async searchArticles(query: string) {
    const articles = await prisma.helpCenter.findMany({
      where: {
        OR: [
          { title: { contains: query, mode: 'insensitive' } },
          { content: { contains: query, mode: 'insensitive' } },
          { category: { contains: query, mode: 'insensitive' } }
        ]
      },
      orderBy: {
        createdAt: 'desc'
      }
    });
    
    return articles;
  }
}

export default new HelpCenterService();