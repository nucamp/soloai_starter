• Install Stripe JavaScript SDK v3.0+ for client-side operations and Stripe Node.js SDK v14.0+ for server-side API operations

• Configure API Version 2023-10-16 or later for consistent behavior across Stripe Elements, Payment Intents, and Subscriptions APIs

• Use API keys from ST01-Stripe-Account-Setup.md: STRIPE_PUBLISHABLE_KEY for client-side, STRIPE_SECRET_KEY for server-side, STRIPE_WEBHOOK_SECRET for verification

• Integrate with existing Better Auth user system for customer identification and pricing tiers from P02-Pricing-Tiers.md

• Implement client-side Stripe.js integration with asynchronous loading, error handling, and fallback mechanisms

• Initialize server-side Stripe API client with secret key configuration for all server operations

• Add full TypeScript support with type definitions for Stripe objects, methods, and webhook events

• Extend EV02-Env-Validation.md patterns to validate Stripe API keys during application startup

• Implement comprehensive error handling for network failures, invalid keys, API rate limits with retry logic