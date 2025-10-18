• Create server-side Stripe Checkout session endpoint to handle subscription purchases for Free, Pro, and Enterprise tiers
• Integrate with existing pricing tiers and Better Auth user system for secure payment processing
• Use Stripe Checkout Sessions API v2023-10-16+ with STRIPE_SECRET_KEY from ST01-Stripe-Account-Setup.md
• Create secure Stripe Checkout sessions with customer identification, pricing tier selection, and success/cancel URL handling
• Verify Better Auth session before creating checkout sessions to ensure only authenticated users can purchase
• Validate pricing tier selection against configured Stripe products to prevent unauthorized price manipulation
• Store user ID, pricing tier, and subscription type in Stripe session metadata for webhook processing
• Link Better Auth user accounts to Stripe customer records for subscription management
• All checkout session requests must include valid Better Auth session authentication
• Implement rate limiting of maximum 10 sessions per user per hour to prevent abuse
• Checkout session creation must complete within 3 seconds under normal conditions
• Support 50+ simultaneous checkout session creations without performance degradation
• POST /api/stripe/checkout endpoint with request body: { priceTier: string