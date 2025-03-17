import NextAuth from "next-auth";
import Providers from "next-auth/providers";
import { Pool } from 'pg';

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

export default NextAuth({
  providers: [
    Providers.Credentials({
      name: 'Credentials',
      credentials: {
        email: { label: "Email", type: "email" },
        password: { label: "Password", type: "password" }
      },
      async authorize(credentials) {
        const { rows } = await pool.query(
          'SELECT * FROM users WHERE email = $1 AND password = $2',
          [credentials.email, credentials.password]
        );
        if (rows.length > 0) {
          return { id: rows[0].id, email: rows[0].email };
        } else {
          return null;
        }
      }
    })
  ],
  session: {
    jwt: true,
  },
  callbacks: {
    async jwt(token, user) {
      if (user) {
        token.id = user.id;
      }
      return token;
    },
    async session(session, token) {
      session.userId = token.id;
      return session;
    }
  }
});