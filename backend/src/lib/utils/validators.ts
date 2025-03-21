import { z } from 'zod';

// User validation schemas
export const registerUserSchema = z.object({
  email: z.string().email('Invalid email address'),
  password: z.string().min(8, 'Password must be at least 8 characters'),
  firstName: z.string().optional(),
  lastName: z.string().optional(),
  phoneNumber: z.string().optional(),
});

export const loginUserSchema = z.object({
  email: z.string().email('Invalid email address'),
  password: z.string().min(1, 'Password is required'),
});

export const updateUserSchema = z.object({
  firstName: z.string().optional(),
  lastName: z.string().optional(),
  phoneNumber: z.string().optional(),
});

// Product validation schemas
export const createProductSchema = z.object({
  name: z.string().min(1, 'Name is required'),
  description: z.string().min(1, 'Description is required'),
  price: z.number().positive('Price must be positive'),
  images: z.array(z.string()).optional(),
  category: z.string().min(1, 'Category is required'),
  location: z.string().optional(),
});

// Booking validation schemas
export const createBookingSchema = z.object({
  productId: z.string().uuid('Invalid product ID'),
  startDate: z.string().refine(
    (val) => !isNaN(Date.parse(val)),
    { message: 'Invalid start date' }
  ),
  endDate: z.string().refine(
    (val) => !isNaN(Date.parse(val)),
    { message: 'Invalid end date' }
  ),
});