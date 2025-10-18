• Create `/login` route using SvelteKit file-based routing at `src/routes/login/+page.svelte`
• Route must be publicly accessible without authentication requirements and support direct URL navigation
• Integrate with main layout component from A02-Create-Layout-Component.md
• Check user authentication status using Better Auth client from AU04-Global-Client-Setup.md
• Redirect authenticated users to `/account` route to prevent unnecessary login attempts
• Preserve intended destination URL for post-login redirect functionality using `?redirect` query parameter
• Support internationalization for English, Spanish, and French using Paraglide from PG02-Paraglide-Configure-Langs.md
• Localize page title, meta descriptions, form labels, buttons, and error messages with translation keys
• Use center-aligned login form with mobile-first responsive design using Tailwind CSS and DaisyUI
• Implement WCAG 2.1 AA accessibility compliance with proper focus management and heading hierarchy
• Include content areas for page title, login form area, signup link, and forgot password link
• Handle URL parameters including redirect URLs and authentication error states with proper validation