import { NextRequest, NextResponse } from 'next/server';
import { BookingService } from '../../../../services/bookingService';
import { z } from 'zod';

interface Params {
  params: {
    id: string;
  };
}

const updateBookingSchema = z.object({
  status: z.enum(['pending', 'confirmed', 'cancelled', 'completed']),
});

export async function GET(request: NextRequest, { params }: Params) {
  try {
    // Get user ID from request headers (set by middleware)
    const userId = request.headers.get('x-user-id');
    if (!userId) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }
    
    const booking = await BookingService.getById(params.id, userId);
    
    return NextResponse.json(booking);
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Something went wrong' },
      { status: error.message === 'Booking not found' ? 404 : 500 }
    );
  }
}

export async function PATCH(request: NextRequest, { params }: Params) {
  try {
    const body = await request.json();
    
    // Get user ID from request headers (set by middleware)
    const userId = request.headers.get('x-user-id');
    if (!userId) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }
    
    // Validate request body
    const result = updateBookingSchema.safeParse(body);
    if (!result.success) {
      return NextResponse.json(
        { error: 'Validation error', details: result.error.errors },
        { status: 400 }
      );
    }
    
    // Update booking status
    const booking = await BookingService.updateStatus(
      params.id,
      userId,
      result.data.status
    );
    
    return NextResponse.json(booking);
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Something went wrong' },
      { status: 500 }
    );
  }
}