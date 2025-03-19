// src/app/api/products/route.ts
import { NextRequest, NextResponse } from 'next/server';
import productService from '@/services/product.service';
import { verifyAuthToken } from '@/lib/auth';

export async function GET(req: NextRequest) {
  try {
    const url = new URL(req.url);
    
    const page = parseInt(url.searchParams.get('page') || '1');
    const limit = parseInt(url.searchParams.get('limit') || '10');
    
    // Extract filters from query params
    const filters: any = {};
    
    if (url.searchParams.has('category')) {
      filters.category = url.searchParams.get('category');
    }
    
    if (url.searchParams.has('minPrice')) {
      filters.minPrice = parseFloat(url.searchParams.get('minPrice') || '0');
    }
    
    if (url.searchParams.has('maxPrice')) {
      filters.maxPrice = parseFloat(url.searchParams.get('maxPrice') || '0');
    }
    
    if (url.searchParams.has('location')) {
      filters.location = url.searchParams.get('location');
    }
    
    if (url.searchParams.has('availability')) {
      filters.availability = url.searchParams.get('availability') === 'true';
    }
    
    if (url.searchParams.has('query')) {
      filters.query = url.searchParams.get('query');
    }
    
    if (url.searchParams.has('tags')) {
      filters.tags = url.searchParams.get('tags')?.split(',');
    }
    
    const products = await productService.getProducts(page, limit, filters);
    
    return NextResponse.json(products, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to fetch products' },
      { status: 400 }
    );
  }
}

export async function POST(req: NextRequest) {
  try {
    // Verify authentication (handled by middleware)
    const authResult = await verifyAuthToken(req);
    if (!authResult.success) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }
    
    const body = await req.json();
    
    const product = await productService.createProduct(body);
    
    return NextResponse.json(product, { status: 201 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to create product' },
      { status: 400 }
    );
  }
}

// src/app/api/products/[id]/route.ts
import { NextRequest, NextResponse } from 'next/server';
import productService from '@/services/product.service';
import { verifyAuthToken } from '@/lib/auth';

export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const product = await productService.getProductById(params.id);
    
    return NextResponse.json(product, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to fetch product' },
      { status: 404 }
    );
  }
}

export async function PUT(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    // Verify authentication (handled by middleware)
    const authResult = await verifyAuthToken(req);
    if (!authResult.success) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }
    
    const body = await req.json();
    
    const product = await productService.updateProduct(params.id, body);
    
    return NextResponse.json(product, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to update product' },
      { status: 400 }
    );
  }
}

export async function DELETE(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    // Verify authentication (handled by middleware)
    const authResult = await verifyAuthToken(req);
    if (!authResult.success) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }
    
    await productService.deleteProduct(params.id);
    
    return NextResponse.json({ success: true }, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to delete product' },
      { status: 400 }
    );
  }
}

// src/app/api/products/search/route.ts
import { NextRequest, NextResponse } from 'next/server';
import productService from '@/services/product.service';

export async function GET(req: NextRequest) {
  try {
    const url = new URL(req.url);
    
    const query = url.searchParams.get('q') || '';
    const page = parseInt(url.searchParams.get('page') || '1');
    const limit = parseInt(url.searchParams.get('limit') || '10');
    
    const results = await productService.searchProducts(query, page, limit);
    
    return NextResponse.json(results, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Search failed' },
      { status: 400 }
    );
  }
}