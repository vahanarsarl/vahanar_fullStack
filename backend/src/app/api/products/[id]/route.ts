import { NextRequest, NextResponse } from 'next/server';
import { ProductService } from '../../../../services/productService';

interface Params {
  params: {
    id: string;
  };
}

export async function GET(request: NextRequest, { params }: Params) {
  try {
    const product = await ProductService.getById(params.id);
    
    return NextResponse.json(product);
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Something went wrong' },
      { status: error.message === 'Product not found' ? 404 : 500 }
    );
  }
}