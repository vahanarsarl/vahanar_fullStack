import { PrismaClient } from "@prisma/client";
import bcrypt from "bcryptjs";

const prisma = new PrismaClient();

export default async function handler(req, res) {
  if (req.method !== "POST") {
    return res.status(405).json({ message: "Method not allowed" });
  }

  const { fullName, phone, email, password } = req.body;

  try {
    const hashedPassword = await bcrypt.hash(password, 12);

    const user = await prisma.user.create({
      data: {
        fullName,
        phone,
        email,
        password: hashedPassword,
      },
    });

    res.status(201).json({ message: "User created", user });
  } catch (error) {
    res.status(500).json({ error: "User registration failed" });
  }
}