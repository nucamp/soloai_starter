• Create comprehensive account overview dashboard displaying user profile information, account status, and subscription details for authenticated users

• Clean, card-based dashboard layout using DaisyUI components with mobile-first responsive design supporting 320px+ viewports

• Display user profile card with avatar placeholder, display name, email address, and account creation date

• Show account status indicators including email verification status, subscription tier, and last login timestamp

• Include quick action buttons for Edit Profile, Manage Billing, Update Password, and Logout

• Implement loading states with skeleton components and error states with retry options

• Display email address with verification status badge (verified/unverified) and current subscription tier with visual badges

• Show account type indicators (Trial, Active, Suspended, Cancelled) and next billing date for paid subscriptions

• Support internationalization with English, Spanish, and French locales using Paraglide i18n system

• Require valid Better Auth session with server-side validation and redirect unauthenticated users to login

• Fetch user profile data from Better Auth session including id, email, name, emailVerified, createdAt, lastLogin

• Cache user profile data for 5 minutes with