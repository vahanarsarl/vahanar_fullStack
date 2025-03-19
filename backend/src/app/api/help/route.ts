// src/app/api/help/route.ts
import { NextRequest, NextResponse } from 'next/server';
import helpCenterService from '@/services/help-center.service';

export async function GET(req: NextRequest) {
  try {
    const url = new URL(req.url);
    
    // Handle query parameter for searching
    if (url.searchParams.has('q')) {
      const query = url.searchParams.get('q') || '';
      const results = await helpCenterService.searchArticles(query);
      return NextResponse.json(results, { status: 200 });
    }
    
    // Handle category parameter
    if (url.searchParams.has('category')) {
      const category = url.searchParams.get('category') || '';
      const results = await helpCenterService.getArticlesByCategory(category);
      return NextResponse.json(results, { status: 200 });
    }
    
    // Get all articles if no parameters
    const articles = await helpCenterService.getAllArticles();
    
    return NextResponse.json(articles, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to fetch help center articles' },
      { status: 400 }
    );
  }
}

// src/app/api/help/[id]/route.ts
import { NextRequest, NextResponse } from 'next/server';
import helpCenterService from '@/services/help-center.service';

export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const article = await helpCenterService.getArticleById(params.id);
    
    return NextResponse.json(article, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to fetch article' },
      { status: 404 }
    );
  }
}