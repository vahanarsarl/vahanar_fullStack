// src/app/api/bookings/route.ts
import { NextRequest, NextResponse } from 'next/server';
import bookingService from '@/services/booking.service';

export async function POST(req: NextRequest) {
  try {
    // Get user ID from authenticated request
    const userId = req.headers.get('X-User-ID');
    
    if (!userId) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }
    
    const body = await req.json();
    
    // Add user ID to the booking data
    const bookingData = {
      ...body,
      userId
    };
    
    const booking = await bookingService.createBooking(bookingData);
    
    return NextResponse.json(booking, { status: 201 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to create booking' },
      { status: 400 }
    );
  }
}

// src/app/api/bookings/[id]/route.ts
import { NextRequest, NextResponse } from 'next/server';
import bookingService from '@/services/booking.service';

export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    // Get user ID from authenticated request
    const userId = req.headers.get('X-User-ID');
    
    if (!userId) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }
    
    const booking = await bookingService.getBookingById(params.id);
    
    // Check if the booking belongs to the user
    if (booking.userId !== userId) {
      return NextResponse.json(
        { error: 'Unauthorized to access this booking' },
        { status: 403 }
      );
    }
    
    return NextResponse.json(booking, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to fetch booking' },
      { status: 404 }
    );
  }
}

export async function PUT(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    // Get user ID from authenticated request
    const userId = req.headers.get('X-User-ID');
    
    if (!userId) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }
    
    const body = await req.json();
    const { status } = body;
    
    if (!status) {
      return NextResponse.json(
        { error: 'Status is required' },
        { status: 400 }
      );
    }
    
    const booking = await bookingService.updateBookingStatus(params.id, status, userId);
    
    return NextResponse.json(booking, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to update booking' },
      { status: 400 }
    );
  }
}

export async function DELETE(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    // Get user ID from authenticated request
    const userId = req.headers.get('X-User-ID');
    
    if (!userId) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }
    
    const booking = await bookingService.cancelBooking(params.id, userId);
    
    return NextResponse.json(booking, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to cancel booking' },
      { status: 400 }
    );
  }
}

// src/app/api/bookings/user/[userId]/route.ts
import { NextRequest, NextResponse } from 'next/server';
import bookingService from '@/services/booking.service';

export async function GET(
  req: NextRequest,
  { params }: { params: { userId: string } }
) {
  try {
    // Get user ID from authenticated request
    const authUserId = req.headers.get('X-User-ID');
    
    if (!authUserId) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }
    
    // Check if the user is requesting their own bookings
    if (params.userId !== authUserId) {
      return NextResponse.json(
        { error: 'Unauthorized to access these bookings' },
        { status: 403 }
      );
    }
    
    const bookings = await bookingService.getUserBookings(params.userId);
    
    return NextResponse.json(bookings, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to fetch bookings' },
      { status: 400 }
    );
  }
}