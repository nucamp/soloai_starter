• Create `/signup` route using SvelteKit file-based routing at `src/routes/signup/+page.svelte`
• Enable new user registration with Better Auth integration for user acquisition
• Implement authentication status check on page load using Better Auth client
• Redirect authenticated users to `/account` route to prevent duplicate registration
• Display signup form for non-authenticated users with email/password fields and social options
• Use clean, centered form layout with DaisyUI components and mobile-first responsive design
• Maintain consistent branding and visual hierarchy matching login page design
• Support internationalization for English, Spanish, and French languages
• Handle `?redirect` query parameter for post-signup navigation with URL validation
• Implement proper accessibility with WCAG 2.1 AA compliance, heading hierarchy, and keyboard navigation
• Include navigation link to `/login` for existing users who need to access their accounts
• Use main layout component for consistent header/footer across the application
• Implement loading states and visual feedback during form interactions
• Ensure page load time under 2 seconds on 3G connection with authentication check under 100ms
• Apply input validation for redirect URLs to prevent open