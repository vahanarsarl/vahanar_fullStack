import { User } from '../../models';
import db from '../../config/database';

export default async (req, res) => {
  const { fullName, phone, email, password } = req.body;

  if (req.method !== 'POST') {
    return res.status(405).json({ message: 'Method not allowed' });
  }

  try {
    await db.sync();
    
    const existingUser = await User.findOne({ where: { email } });
    if (existingUser) {
      return res.status(400).json({ message: 'Email already exists' });
    }

    const user = await User.create({ fullName, phone, email, password });
    res.status(201).json(user);
  } catch (error) {
    res.status(500).json({ message: 'Internal server error', error });
  }
};
