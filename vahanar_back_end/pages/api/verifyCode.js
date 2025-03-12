import { User } from '../../models';
import db from '../../config/database';

export default async (req, res) => {
  const { phone, verificationCode } = req.body;

  if (req.method !== 'POST') {
    return res.status(405).json({ message: 'Method not allowed' });
  }

  try {
    await db.sync();

    const user = await User.findOne({
      where: {
        phone,
        verificationCode,
        verificationCodeExpiry: { $gt: new Date() }, // Ensure code is not expired
      },
    });

    if (!user) {
      return res.status(400).json({ message: 'Invalid or expired verification code' });
    }

    user.verificationCode = null; // Clear the verification code
    user.verificationCodeExpiry = null; // Clear the code expiry
    await user.save();

    res.status(200).json({ message: 'Phone number verified successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Internal server error', error });
  }
};