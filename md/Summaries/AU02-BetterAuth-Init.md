• Initialize Better Auth v1.0+ server configuration with database adapter, email/password authentication, and social OAuth providers

• Establish authentication foundation for user registration, login, and session management with secure JWT handling

• Configure MySQL database adapter connecting to existing container from DB01-DB-Container-Setup.md

• Integrate email provider for verification and password reset flows

• Set up social OAuth providers: Google, GitHub, Discord for streamlined registration

• Implement email/password authentication with secure Argon2 password hashing

• Configure social login support with OAuth 2.0 flow handling and email verification workflow

• Manage JWT secrets using BETTER_AUTH_SECRET environment variable with secure cookie configuration

• Implement session handling with CSRF protection and rate limiting for authentication attempts

• Auto-generate authentication tables: users, sessions, accounts, verification_tokens with extensible schema

• Create `src/lib/auth.ts` or `src/auth.ts` file with Better Auth initialization and database adapter configuration

• Configure environment variables: BETTER_AUTH_SECRET, BETTER_AUTH_URL, email server settings, and OAuth credentials

• Set up OAuth providers with proper redirect URLs, scopes,