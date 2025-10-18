• Create "Subscribe" or "Choose Plan" buttons for each pricing tier to prepare for future Stripe and LemonSqueezy payment integration

• Use DaisyUI `btn-primary` class for paid plans and `btn-outline` for free tier with minimum 44px height for mobile touch targets

• Implement different button text variations: "Get Started Free" for free tier, "Choose [Plan Name]" for paid tiers, and "Current Plan" for existing subscriptions

• Check authentication status using Better Auth client to determine user flow and button behavior

• Redirect guest users to `/signup?plan=[tier-id]&redirect=/checkout` and authenticated users to `/checkout?plan=[tier-id]`

• Show loading states with spinner and disabled appearance during processing, with interactions responding within 100ms

• Create reusable `PricingButton.svelte` component that integrates with existing `PricingTierCard.svelte` from P02-Pricing-Tiers.md

• Implement full-width buttons on mobile (<768px) and fixed-width buttons on tablet/desktop with hover effects

• Connect to existing Strapi "Pricing