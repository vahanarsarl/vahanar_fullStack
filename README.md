# vahanar_fullStack
backend/
│── src/
│   ├── app/
│   │   ├── api/
│   │   │   ├── auth/
│   │   │   │   ├── login/
│   │   │   │   │   └── route.ts
│   │   │   │   ├── register/
│   │   │   │   │   └── route.ts
│   │   │   │   ├── verify-phone/
│   │   │   │   │   └── route.ts
│   │   │   │   ├── forgot-password/
│   │   │   │   │   └── route.ts
│   │   │   │   └── reset-password/
│   │   │   │       └── route.ts
│   │   │   ├── users/
│   │   │   │   ├── [id]/
│   │   │   │   │   └── route.ts
│   │   │   │   └── route.ts
│   │   │   ├── products/
│   │   │   │   ├── [id]/
│   │   │   │   │   └── route.ts
│   │   │   │   ├── search/
│   │   │   │   │   └── route.ts
│   │   │   │   └── route.ts
│   │   │   ├── bookings/
│   │   │   │   ├── [id]/
│   │   │   │   │   └── route.ts
│   │   │   │   ├── user/[userId]/
│   │   │   │   │   └── route.ts
│   │   │   │   └── route.ts
│   │   │   └── help/
│   │   │       └── route.ts
│   │   └── route.ts
│   ├── lib/
│   │   ├── prisma.ts
│   │   ├── auth.ts
│   │   ├── jwt.ts
│   │   └── utils.ts
│   ├── middleware.ts
│   ├── models/
│   │   ├── user.ts
│   │   ├── product.ts
│   │   └── booking.ts
│   ├── services/
│   │   ├── auth.service.ts
│   │   ├── user.service.ts
│   │   ├── product.service.ts
│   │   ├── booking.service.ts
│   │   └── notification.service.ts
│   ├── config/
│   │   ├── database.ts
│   │   └── constants.ts
│   └── types/
│       ├── user.types.ts
│       ├── product.types.ts
│       └── booking.types.ts
├── prisma/
│   ├── schema.prisma
│   └── migrations/
├── public/
│   └── assets/
├── scripts/
│   └── seed.ts
├── .env
├── .env.example
├── package.json
├── tsconfig.json
└── README.md