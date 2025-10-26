# Better Auth Installation and Environment Setup

## Overview
Install Better Auth server and client packages for comprehensive authentication functionality in the SvelteKit SaaS application. Configure environment variables and prepare foundation for email/password authentication, social OAuth providers, and secure session management. This establishes the authentication foundation that will integrate with existing Paraglide i18n system, Strapi CMS, and Mautic user provisioning workflows.

## Requirements

### Functional Requirements
- Install Better Auth v1.0+ server and client packages with TypeScript support
- Configure environment variables for database connection, email providers, and OAuth credentials
- Establish secure JWT secret generation and session key management
- Prepare authentication foundation for email/password and social provider login flows
- Support user session persistence across browser refreshes and application restarts
- Enable future integration with existing MySQL database container from DB01-DB-Container-Setup.md
- Maintain compatibility with established environment variable patterns from EV01-Env-File-Setup.md

### User Stories
- As a developer, I want Better Auth installed so I can implement user authentication flows
- As a developer, I want secure environment variables configured so API keys and secrets are properly managed
- As a system administrator, I want authentication secrets properly configured so user sessions are secure

### Security Considerations
- Generate cryptographically secure JWT secrets with minimum 32 character length
- Store all authentication secrets in environment variables, never in source code
- Use separate secrets for development, testing, and production environments
- Implement proper secret rotation capability for production deployment
- Follow established secret management patterns from EV03-Secret-Management.md
- Protect OAuth client secrets and callback URLs from exposure

### Performance Requirements
- Package installation must complete within 2 minutes on standard development machine
- Environment variable validation must execute in under 100ms during application startup
- Authentication package imports should not increase bundle size by more than 200KB
- Support concurrent authentication requests without performance degradation

## Technical Specifications

### Dependencies
- Better Auth server package (`better-auth`) for authentication logic and database integration
- Better Auth client package (`better-auth/client`) for frontend authentication state management
- Better Auth SvelteKit adapter (`better-auth/svelte`) for framework-specific integration
- **Prisma ORM** (`@prisma/client` and `prisma`) as database adapter - see DB02-Prisma-Setup.md
- Email provider integration packages (nodemailer, resend, or similar)
- OAuth provider SDKs for social authentication (google, github, discord)
- Crypto utilities for secure secret generation and validation

### Database Integration
- Connect to `soloai_db` database via Prisma ORM (configured in DB02-Prisma-Setup.md)
- Use DATABASE_URL from established environment configuration
- Prepare for user authentication tables creation in subsequent initialization step
- Prisma handles connection pooling and transaction management for authentication operations
- Better Auth uses Prisma Client for type-safe database operations

### Environment Variables
Add to existing `.env` configuration established in EV01-Env-File-Setup.md:
- `BETTER_AUTH_SECRET`: Cryptographically secure secret for JWT signing and session encryption
- `BETTER_AUTH_URL`: Base URL for authentication callbacks and redirects
- `EMAIL_FROM`: Sender email address for password reset and verification emails
- `EMAIL_SERVER_HOST`: SMTP server hostname for email delivery
- `EMAIL_SERVER_PORT`: SMTP server port (typically 587 or 465)
- `EMAIL_SERVER_USER`: SMTP authentication username
- `EMAIL_SERVER_PASSWORD`: SMTP authentication password or app-specific password
- `GOOGLE_CLIENT_ID`: OAuth client ID for Google social authentication
- `GOOGLE_CLIENT_SECRET`: OAuth client secret for Google social authentication
- `GITHUB_CLIENT_ID`: OAuth client ID for GitHub social authentication
- `GITHUB_CLIENT_SECRET`: OAuth client secret for GitHub social authentication

### Integration Points
- Extend existing environment variable validation from EV02-Env-Validation.md to include authentication secrets
- Prepare integration points for Mautic user provisioning workflow in upcoming MA02-Mautic-API-Auth.md
- Maintain compatibility with Paraglide i18n system for authentication UI translations
- Support future integration with Stripe/LemonSqueezy for subscription-based authentication flows

### File Structure
Update existing project structure to include:
- Authentication configuration in `src/lib/auth/` directory
- Client-side authentication utilities in `src/lib/auth/client.ts`
- Server-side authentication configuration in `src/lib/auth/server.ts`
- Type definitions for authentication state and user objects
- Environment variable validation updates in existing validation system

## Additional Context for AI Assistant

### Prerequisites
This feature builds upon:
- DB01-DB-Container-Setup.md: MySQL database container for user data storage
- **DB02-Prisma-Setup.md: Prisma ORM configuration and soloai_db database setup**
- EV01-Env-File-Setup.md: Environment variable management system
- EV02-Env-Validation.md: Environment variable validation framework
- EV03-Secret-Management.md: Security best practices for credential management

### Next Steps
This installation prepares for:
- AU02-BetterAuth-Init.md: Initialize Better Auth with database adapter and provider configuration
- AU03-Mount-BetterAuth-Handler.md: Server handler setup for authentication endpoints
- AU04-Global-Client-Setup.md: Client-side authentication state management

### Development Workflow
1. Install Better Auth packages using package manager
2. Generate secure authentication secrets using crypto utilities
3. Update environment configuration files with authentication variables
4. Update environment validation schema to include authentication secrets
5. Verify package installation and environment configuration
6. Test basic package imports and configuration loading
7. Prepare project structure for authentication implementation

### Security Notes
- Never commit actual secret values to version control
- Use different secrets for each environment (development, testing, production)
- Implement proper secret rotation procedures for production deployment
- Follow established patterns from secret management documentation
- Validate all authentication environment variables during application startup