• Create comprehensive billing and subscription management interface within `/account` dashboard for both Stripe and LemonSqueezy integrations

• Display current subscription tier, billing status, next billing date, and payment method summary with color-coded status badges

• Provide billing history with chronological payment list, invoice downloads, and pagination for extensive records

• Enable payment method management through secure update flows and customer portal integration

• Support subscription management actions including cancellation, upgrade/downgrade, and reactivation with confirmation dialogs

• Implement responsive design with single column mobile layout and two-column desktop layout using DaisyUI components

• Add loading states with skeleton components and error states with retry options for failed requests

• Create new API endpoints: `GET /api/billing/subscription`, `POST /api/billing/cancel`, `POST /api/billing/portal`

• Utilize existing database fields from webhook implementations without requiring new tables

• Require Better Auth session authentication and validate user ownership of subscription data

• Implement CSRF protection and rate limiting for billing API endpoints with audit logging

• Redirect sensitive operations to official payment processor customer portals for security

• Ensure dashboard loads within 2 seconds on 3G