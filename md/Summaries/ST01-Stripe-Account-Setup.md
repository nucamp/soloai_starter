• Set up Stripe test environment and obtain API credentials for payment processing and subscription management across Free, Pro, and Enterprise tiers

• Use Stripe API Version 2023-10-16 or later with test mode enabled for development and staging environments

• Generate publishable key for client-side operations and secret key for server-side API operations, ensuring proper test environment scoping

• Create Stripe test account with business information, verify email, and enable test mode for all payment operations

• Access Stripe Dashboard for product configuration, webhook setup, and payment method management

• Store API keys as environment variables: STRIPE_PUBLISHABLE_KEY, STRIPE_SECRET_KEY, and STRIPE_WEBHOOK_SECRET

• Never expose secret keys to client-side code and implement proper key rotation procedures for production

• Configure webhook endpoints to support subscription lifecycle events with delivery within 30 seconds

• Support credit/debit cards (Visa, Mastercard, American Express) and prepare for digital wallets (Apple Pay, Google Pay)

• Integrate with existing pricing tiers from P02-Pricing-Tiers.md and Better Auth user system from AU02-BetterAuth-Init.