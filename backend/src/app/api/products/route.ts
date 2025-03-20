import { NextRequest, NextResponse } from 'next/server';
import { ProductService } from '@/services/productService';
import { createProductSchema } from '@/lib/utils/validators';

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    
    const params = {
      category: searchParams.get('category') || undefined,
      search: searchParams.get('search') || undefined,
      page: searchParams.has('page') ? Number(searchParams.get('page')) : 1,
      limit: searchParams.has('limit') ? Number(searchParams.get('limit')) : 10,
    };
    
    const result = await ProductService.getAll(params);
    
    return NextResponse.json(result);
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Something went wrong' },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    
    // Only admins should be able to create products
    // This is a simplified example - in a real app, you'd check admin roles
    
    // Validate request body
    const result = createProductSchema.safeParse(body);
    if (!result.success) {
      return NextResponse.json(
        { error: 'Validation error', details: result.error.errors },
        { status: 400 }
      );
    }
    
    // Create product
    const product = await ProductService.create(result.data);
    
    return NextResponse.json(product, { status: 201 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Something went wrong' },
      { status: 500 }
    );
  }
}