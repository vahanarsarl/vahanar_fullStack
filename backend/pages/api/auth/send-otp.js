import twilio from "twilio";

const client = twilio(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_AUTH_TOKEN);

export default async function handler(req, res) {
  if (req.method !== "POST") {
    return res.status(405).json({ message: "Method not allowed" });
  }

  const { phone } = req.body;

  try {
    const otp = Math.floor(100000 + Math.random() * 900000); // 6-digit OTP

    await client.messages.create({
      body: `Your Vahanar OTP is: ${otp}`,
      from: process.env.TWILIO_PHONE_NUMBER,
      to: phone,
    });

    res.status(200).json({ message: "OTP sent", otp }); // For development only
  } catch (error) {
    res.status(500).json({ error: "Failed to send OTP" });
  }
}