import { User } from '../../models';
import db from '../../config/database';

export default async (req, res) => {
  const { resetToken, newPassword } = req.body;

  if (req.method !== 'POST') {
    return res.status(405).json({ message: 'Method not allowed' });
  }

  try {
    await db.sync();

    const user = await User.findOne({
      where: {
        resetToken,
        resetTokenExpiry: { $gt: new Date() }, // Ensure token is not expired
      },
    });

    if (!user) {
      return res.status(400).json({ message: 'Invalid or expired reset token' });
    }

    // Update the password
    user.password = await User.hashPassword(newPassword); // Hash the new password
    user.resetToken = null; // Clear the resetToken
    user.resetTokenExpiry = null; // Clear the token expiry
    await user.save();

    res.status(200).json({ message: 'Password reset successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Internal server error', error });
  }
};
