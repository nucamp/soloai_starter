# Better Auth Global Client Setup

## Overview
Set up Better Auth client-side configuration with createAuthClient and integrate with global SvelteKit context for authentication state management across the application. This establishes the foundation for client-side authentication flows including login, signup, session persistence, and route protection.

**Feature Type**: Technical Integration

## Requirements

### Technical Integration Requirements
- **Service Details**: Better Auth v1.0+ client package with SvelteKit adapter integration
- **Authentication**: Client connects to mounted Better Auth server handler at `/api/auth/[...all]`
- **Integration Points**: Global context provider, session management, authentication state reactivity

### Functional Requirements
- Create Better Auth client instance using `createAuthClient` with proper configuration
- Integrate client with SvelteKit's global context system for app-wide authentication state
- Provide reactive authentication state accessible from any component or page
- Handle automatic session initialization and persistence across page reloads
- Support authentication actions (login, signup, logout) through client methods
- Maintain consistent authentication state between server and client
- Enable real-time authentication state updates without page refresh

**Acceptance Criteria**:
- Authentication client accessible globally through SvelteKit context
- Session state automatically loads on application initialization
- Authentication state reactive updates trigger component re-renders
- Client methods available for all authentication operations
- Session persistence works across browser tabs and page reloads

### Data Requirements
- Authentication state includes user data, session status, loading states
- Client maintains session tokens, user profile data, and authentication status
- Support for user metadata including email, name, OAuth provider information
- Session expiry handling with automatic token refresh when possible

### Security Considerations
- Secure token storage using httpOnly cookies for session management
- CSRF protection through Better Auth's built-in security measures
- Automatic token refresh handling for session continuity
- Client-side session validation with server-side verification

### Performance Requirements
- Authentication client initialization within 100ms of app startup
- Session state changes propagate to components within 50ms
- Client methods respond within 200ms for local operations
- Memory usage under 5MB for authentication state management

## Technical Specifications

### Dependencies
- `better-auth/client` - Client-side authentication library
- `better-auth/svelte` - SvelteKit-specific authentication adapter
- Existing Better Auth server configuration from AU02-BetterAuth-Init.md
- Mounted Better Auth handler from AU03-Mount-BetterAuth-Handler.md

### Integration Architecture
- Create `src/lib/auth-client.ts` for Better Auth client configuration
- Integrate with SvelteKit's `+layout.svelte` for global context provision
- Use SvelteKit's context API (`setContext`/`getContext`) for state sharing
- Connect to Better Auth server endpoints at `/api/auth/*` routes

### Client Configuration
- Configure base URL pointing to mounted Better Auth handler
- Set up automatic session refresh and token management  
- Enable reactive state updates for authentication changes
- Configure OAuth provider support matching server configuration

### Context Integration
- Provide authentication context through SvelteKit's context system
- Export authentication utilities and state accessors
- Create typed context interface for TypeScript support
- Enable component-level authentication state subscription

### Environment Variables
- Use existing `BETTER_AUTH_URL` from server configuration
- Support `PUBLIC_BETTER_AUTH_URL` for client-side API calls
- No additional environment variables required

## Additional Context for AI Assistant

This feature builds directly on the Better Auth server setup from AU02-BetterAuth-Init.md and mounted handler from AU03-Mount-BetterAuth-Handler.md. The client must connect to the existing `/api/auth/[...all]` endpoint structure.

The implementation should establish the global authentication context that will be consumed by:
- Login forms (L02-Login-Form.md)
- Signup forms (S02-Signup-Form.md) 
- Route guards (AU05-Protect-Routes.md)
- Session persistence (AU06-Session-Persistence.md)
- Account management pages (D01-Account-Route.md)

Create reusable authentication utilities that can be imported throughout the application without coupling components directly to Better Auth implementation details.

The client setup must support the social OAuth providers (Google, GitHub, Discord) configured in the server initialization while maintaining security best practices for client-side authentication state management.