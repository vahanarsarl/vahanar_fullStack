// src/app/api/users/[id]/route.ts
import { NextRequest, NextResponse } from 'next/server';
import userService from '@/services/user.service';

export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
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
    
    // Check if the user is requesting their own profile
    if (params.id !== authUserId) {
      return NextResponse.json(
        { error: 'Unauthorized to access this profile' },
        { status: 403 }
      );
    }
    
    const user = await userService.getUserById(params.id);
    
    return NextResponse.json(user, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to fetch user' },
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
    const authUserId = req.headers.get('X-User-ID');
    
    if (!authUserId) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }
    
    // Check if the user is updating their own profile
    if (params.id !== authUserId) {
      return NextResponse.json(
        { error: 'Unauthorized to update this profile' },
        { status: 403 }
      );
    }
    
    const body = await req.json();
    
    const user = await userService.updateUser(params.id, body);
    
    return NextResponse.json(user, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to update user' },
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
    const authUserId = req.headers.get('X-User-ID');
    
    if (!authUserId) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }
    
    // Check if the user is deleting their own account
    if (params.id !== authUserId) {
      return NextResponse.json(
        { error: 'Unauthorized to delete this account' },
        { status: 403 }
      );
    }
    
    const result = await userService.deleteUser(params.id);
    
    return NextResponse.json(result, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to delete user' },
      { status: 400 }
    );
  }
}

// src/app/api/users/route.ts
import { NextRequest, NextResponse } from 'next/server';

export async function GET(req: NextRequest) {
  // This route is purposely not implemented to prevent listing all users
  return NextResponse.json(
    { error: 'Not implemented' },
    { status: 501 }
  );
}

// src/app/api/users/[id]/change-password/route.ts
import { NextRequest, NextResponse } from 'next/server';
import userService from '@/services/user.service';

export async function POST(
  req: NextRequest,
  { params }: { params: { id: string } }
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
    
    // Check if the user is changing their own password
    if (params.id !== authUserId) {
      return NextResponse.json(
        { error: 'Unauthorized to change this password' },
        { status: 403 }
      );
    }
    
    const body = await req.json();
    const { currentPassword, newPassword } = body;
    
    if (!currentPassword || !newPassword) {
      return NextResponse.json(
        { error: 'Current password and new password are required' },
        { status: 400 }
      );
    }
    
    const result = await userService.changePassword(
      params.id,
      currentPassword,
      newPassword
    );
    
    return NextResponse.json(result, { status: 200 });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to change password' },
      { status: 400 }
    );
  }
}