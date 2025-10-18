• Create a dedicated `/forgot-password` route in SvelteKit using file-based routing at `src/routes/forgot-password/+page.svelte`

• Implement authentication check on page load using Better Auth client to verify user session status

• Redirect authenticated users to `/account` route with 302 status code to prevent unnecessary actions

• Display clean, centered form layout using DaisyUI components matching existing login/signup page design

• Integrate with main layout component for consistent header/footer branding across the site

• Include navigation link back to `/login` route for users who remember their password

• Prepare form structure with email input field ready for password reset implementation in next feature

• Support internationalization for English, Spanish, and French locales using Paraglide i18n system

• Ensure mobile-first responsive design with proper touch targets and viewport optimization

• Implement WCAG 2.1 AA accessibility compliance with proper heading hierarchy and form labels

• Apply CSRF protection preparation and validate redirect destinations to prevent security vulnerabilities

• Maintain page load time under 2 seconds on 3G connection with authentication check under 100ms

• Create translation keys for