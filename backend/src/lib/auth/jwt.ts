import { SignJWT, jwtVerify } from 'jose';

export async function signJWT(payload: any) {
  const secret = new TextEncoder().encode(process.env.JWT_SECRET);
  const alg = 'HS256';

  return new SignJWT(payload)
    .setProtectedHeader({ alg })
    .setIssuedAt()
    .setExpirationTime('7d')
    .sign(secret);
}

export async function verifyJWT(token: string) {
  const secret = new TextEncoder().encode(process.env.JWT_SECRET);
  
  try {
    const { payload } = await jwtVerify(token, secret);
    return payload;
  } catch (error) {
    return null;
  }
}