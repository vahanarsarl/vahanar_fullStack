import { NextRequest, NextResponse } from 'next/server';
import { BookingService } from '@/services/bookingService';
import { createBookingSchema } from '@/lib/utils/validators';

export async function GET(request: NextRequest) {
  try {
    // Get user ID from request headers (set by middleware)
    const userId = request.headers.get('x-user-id');
    if (!userId) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }
    
    const bookings = await BookingService.getUserBookings(userId);
    
    return NextResponse.json(bookings);
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
    
    // Get user ID from request headers (set by middleware)
    const userId = request.headers.get('x-user-id');
    if (!userId) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }
    
    // Validate request body
    const result = createBookingSchema.safeParse(body);
    if (!result.success) {
      return NextResponse.json(
        { error: 'Validation error', details: result.error.errors },
        { status: 400 }
      );
    }
    
    // Create booking
    const booking = await BookingService.create({
      userId,
      productId: result.data.productId,
      startDate: new Date(result.data.startDate),
      endDate: new Date(result.data.endDate),
    });
    
    return NextResponse.json(booking, { status: 201 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Something went wrong' },
      { status: 500 }
    );
  }
}