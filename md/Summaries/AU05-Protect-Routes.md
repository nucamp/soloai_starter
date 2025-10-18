• Implement comprehensive route protection system for authenticated areas using Better Auth session management
• Create middleware to guard `/account`, `/dashboard`, and other protected routes with proper redirects and loading states
• Automatically redirect guest users to `/login` when accessing protected routes
• Provide seamless access for authenticated users without unnecessary redirects
• Preserve intended destination URL using `?redirect` parameter for post-login redirect
• Require valid authentication for all routes under `/account/*` and `/dashboard/*`
• Verify Better Auth session validity on each protected route access
• Show loading indicators during authentication checks to prevent UI flash
• Handle session expiration, network errors, and authentication failures gracefully
• Implement reactive authentication checks that update when session state changes
• Ensure protected routes return 401/403 status codes for unauthenticated requests
• Protect all child routes under protected parent routes automatically
• Validate session on both client and server side for security
• Validate redirect URLs to prevent open redirect vulnerabilities
• Complete authentication checks within 100ms performance requirement
• Create `+layout.server.ts` files for protected route groups with Better Auth server methods
• Create `+layout.ts`