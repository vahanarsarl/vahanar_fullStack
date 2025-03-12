import { User } from '../../models';
import db from '../../config/database';
import twilio from 'twilio';

const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const client = twilio(accountSid, authToken);

export default async (req, res) => {
  const { phone } = req.body;

  if (req.method !== 'POST') {
    return res.status(405).json({ message: 'Method not allowed' });
  }

  try {
    await db.sync();

    const user = await User.findOne({ where: { phone } });
    if (!user) {
      return res.status(400).json({ message: 'User not found' });
    }

    const verificationCode = Math.floor(100000 + Math.random() * 900000).toString();

    user.verificationCode = verificationCode;
    user.verificationCodeExpiry = new Date(Date.now() + 300000); // 5 minutes expiry
    await user.save();

    await client.messages.create({
      body: `Your verification code is ${verificationCode}`,
      from: process.env.TWILIO_PHONE_NUMBER,
      to: phone,
    });

    res.status(200).json({ message: 'Verification code sent' });
  } catch (error) {
    res.status(500).json({ message: 'Internal server error', error });
  }
};