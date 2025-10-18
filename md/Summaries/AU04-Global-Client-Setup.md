• Set up Better Auth client-side configuration with createAuthClient and integrate with global SvelteKit context for authentication state management

• Create Better Auth client instance using createAuthClient with proper configuration connecting to `/api/auth/[...all]` endpoint

• Integrate client with SvelteKit's global context system for app-wide authentication state access

• Provide reactive authentication state accessible from any component or page throughout the application

• Handle automatic session initialization and persistence across page reloads and browser tabs

• Support authentication actions (login, signup, logout) through client methods with real-time state updates

• Maintain consistent authentication state between server and client without page refresh requirements

• Create `src/lib/auth-client.ts` for Better Auth client configuration and setup

• Integrate with SvelteKit's `+layout.svelte` for global context provision using setContext/getContext APIs

• Configure base URL pointing to mounted Better Auth handler with automatic session refresh and token management

• Support OAuth provider integration (Google, GitHub, Discord) matching existing server configuration

• Implement secure token storage using httpOnly cookies with CSRF protection and automatic token refresh

• Ensure authentication client initialization within 100ms