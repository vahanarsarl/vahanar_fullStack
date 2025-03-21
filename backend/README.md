backend/
├── .env                    # Environment variables
├── .env.example            # Example environment variables
├── .gitignore              # Git ignore file
├── package.json            # Node.js dependencies
├── tsconfig.json           # TypeScript configuration
├── next.config.js          # Next.js configuration
├── middleware.ts           # Global middleware
├── public/                 # Static files
├── src/
│   ├── app/                # App router
│   │   ├── api/            # API routes
│   │   │   ├── auth/       # Authentication endpoints
│   │   │   │   ├── login/
│   │   │   │   │   └── route.ts
│   │   │   │   ├── register/
│   │   │   │   │   └── route.ts
│   │   │   │   ├── verify/
│   │   │   │   │   └── route.ts
│   │   │   │   └── forgot-password/
│   │   │   │       └── route.ts
│   │   │   ├── users/
│   │   │   │   └── route.ts
│   │   │   ├── products/
│   │   │   │   └── route.ts
│   │   │   └── bookings/
│   │   │       └── route.ts
│   │   └── dashboard/      # Admin dashboard (if needed)
│   ├── lib/                # Shared libraries
│   │   ├── db/             # Database connection
│   │   │   └── prisma.ts
│   │   ├── auth/           # Authentication utilities
│   │   │   └── jwt.ts
│   │   └── utils/          # Utility functions
│   │       └── validators.ts
│   ├── models/             # Data models
│   │   ├── User.ts
│   │   ├── Product.ts
│   │   └── Booking.ts
│   └── services/           # Business logic
│       ├── authService.ts
│       ├── userService.ts
│       ├── productService.ts
│       └── bookingService.ts
└── prisma/                 # Database schema
    └── schema.prisma