# ST03-Stripe-Checkout-Sessions.md

## Overview
Create server-side API endpoint to generate Stripe Checkout sessions that redirect users to Stripe-hosted payment pages for subscription purchases. This approach provides a secure, PCI-compliant payment flow without handling sensitive card data directly.

**Feature Type**: Technical Integration

## Requirements

### Technical Integration Details
- **Service**: Stripe Checkout Sessions API v2025-06-30.basil+
- **Checkout Mode**: Stripe-hosted pages (not embedded)
- **Authentication**: Requires STRIPE_SECRET_KEY from ST01-Stripe-Account-Setup.md
- **Integration Points**: 
  - Better Auth user system for customer identification
  - Pricing tier data from P02-Pricing-Tiers.md
  - Existing SvelteKit API route structure

### Functional Requirements
- **Checkout Session Creation**: Generate secure Stripe Checkout sessions that redirect to Stripe-hosted payment pages
- **User Authentication**: Verify Better Auth session before creating checkout sessions
- **Customer Management**: Create or retrieve Stripe customers linked to authenticated users
- **Subscription Mode**: Configure sessions for subscription billing with recurring payments
- **Success/Cancel URLs**: Configure return URLs for post-payment redirects
- **Metadata Tracking**: Attach user and tier information to sessions for webhook processing

### Data Requirements
- **Session Configuration**: 
  - Payment mode: subscription
  - Line items: pricing tier products from Stripe Dashboard
  - Customer email: from authenticated user
  - Success URL: application account page
  - Cancel URL: application pricing page
- **Customer Mapping**: Link Better Auth users to Stripe customers
- **Session Metadata**: Store user_id, tier_name, and session_type

### Security Considerations
- **Authentication Required**: All checkout requests must include valid Better Auth session
- **Server-Side Only**: Checkout sessions created exclusively on server to protect API keys
- **URL Validation**: Validate success and cancel URLs to prevent open redirects
- **Rate Limiting**: Maximum 10 checkout sessions per user per hour
- **HTTPS Only**: Enforce HTTPS for all production checkout flows

### Performance Requirements
- **Session Creation**: Complete within 2 seconds
- **Redirect Time**: Navigate to Stripe page within 1 second
- **Concurrent Sessions**: Support 100+ simultaneous checkouts
- **Error Recovery**: Retry failed session creation with exponential backoff

## Technical Specifications

### Dependencies
- Stripe Node.js SDK v14.0+ from ST02-Install-Stripe-SDK.md
- Better Auth server methods for session validation
- Environment variables: STRIPE_SECRET_KEY, STRIPE_SUCCESS_URL, STRIPE_CANCEL_URL
- Pricing configuration from ST06-Configure-Stripe-Products.md

### API Endpoint
```typescript
// POST /api/stripe/checkout
interface CheckoutRequest {
  priceId: string;           // Stripe price ID from configured products
  tier: 'pro' | 'enterprise'; // Subscription tier
}

interface CheckoutResponse {
  url: string;    // Stripe Checkout URL for redirect
  sessionId: string; // Session ID for tracking
}
```

### Implementation Example
```typescript
// src/routes/api/stripe/checkout/+server.ts
import { json, redirect } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import Stripe from 'stripe';
import { env } from '$env/dynamic/private';

const stripe = new Stripe(env.STRIPE_SECRET_KEY, {
  apiVersion: '2025-06-30.basil'
});

export const POST: RequestHandler = async ({ request, locals, url }) => {
  // Verify authentication
  const session = await locals.auth();
  if (!session?.user) {
    return json({ error: 'Authentication required' }, { status: 401 });
  }

  const { priceId, tier } = await request.json();

  try {
    // Create or retrieve Stripe customer
    let customer;
    if (session.user.stripeCustomerId) {
      customer = await stripe.customers.retrieve(session.user.stripeCustomerId);
    } else {
      customer = await stripe.customers.create({
        email: session.user.email,
        metadata: {
          userId: session.user.id
        }
      });
      // Update user with Stripe customer ID
      await updateUserStripeId(session.user.id, customer.id);
    }

    // Create Checkout session
    const checkoutSession = await stripe.checkout.sessions.create({
      customer: customer.id,
      payment_method_types: ['card'],
      mode: 'subscription',
      line_items: [{
        price: priceId,
        quantity: 1
      }],
      success_url: `${url.origin}/account?success=true&session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${url.origin}/pricing?canceled=true`,
      metadata: {
        userId: session.user.id,
        tier: tier
      },
      subscription_data: {
        metadata: {
          userId: session.user.id,
          tier: tier
        }
      },
      // Enable customer portal for subscription management
      customer_update: {
        address: 'auto',
        name: 'auto'
      },
      // Collect tax automatically
      automatic_tax: {
        enabled: true
      }
    });

    return json({
      url: checkoutSession.url,
      sessionId: checkoutSession.id
    });

  } catch (error) {
    console.error('Checkout session creation failed:', error);
    return json(
      { error: 'Failed to create checkout session' },
      { status: 500 }
    );
  }
};
```

### Frontend Integration
```svelte
<!-- src/routes/pricing/+page.svelte -->
<script lang="ts">
  async function handleCheckout(priceId: string, tier: string) {
    try {
      const response = await fetch('/api/stripe/checkout', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ priceId, tier })
      });

      if (!response.ok) {
        throw new Error('Checkout failed');
      }

      const { url } = await response.json();
      
      // Redirect to Stripe-hosted checkout page
      window.location.href = url;
    } catch (error) {
      console.error('Checkout error:', error);
      // Handle error with user feedback
    }
  }
</script>

<button on:click={() => handleCheckout('price_xxx', 'pro')}>
  Subscribe to Pro
</button>
```

### Checkout Session Configuration

#### Required Fields
- `customer`: Stripe customer ID or email
- `mode`: 'subscription' for recurring billing
- `line_items`: Array of price IDs and quantities
- `success_url`: Return URL after successful payment
- `cancel_url`: Return URL if user cancels

#### Recommended Fields
- `metadata`: Custom data for webhook processing
- `subscription_data`: Additional subscription configuration
- `automatic_tax`: Enable tax calculation
- `customer_update`: Allow address/name updates
- `billing_address_collection`: Collect billing address

### Error Handling
- **Invalid Price ID**: Return 400 with clear error message
- **Authentication Failed**: Return 401 unauthorized
- **Stripe API Error**: Log details and return 500
- **Rate Limit Exceeded**: Return 429 with retry-after header
- **Network Timeout**: Implement retry with exponential backoff

### Testing
Use Stripe test card numbers:
- Success: 4242 4242 4242 4242
- Decline: 4000 0000 0000 0002
- Authentication Required: 4000 0025 0000 3155

### Environment Variables
```bash
STRIPE_SECRET_KEY=sk_test_...
STRIPE_SUCCESS_URL=http://localhost:5173/account
STRIPE_CANCEL_URL=http://localhost:5173/pricing
```

## Webhook Integration

After successful payment, Stripe sends webhook events:
- `checkout.session.completed`: Payment successful
- `customer.subscription.created`: Subscription active
- `invoice.payment_succeeded`: Recurring payment processed

These events are handled in ST04-Stripe-Webhooks.md to update user subscription status.

## Customer Portal

Enable users to manage subscriptions through Stripe's Customer Portal:
```typescript
// Create portal session
const portalSession = await stripe.billingPortal.sessions.create({
  customer: customerId,
  return_url: `${url.origin}/account`
});

// Redirect to portal
return redirect(303, portalSession.url);
```

## Additional Context

### Migration from Embedded Checkout
If migrating from embedded checkout:
1. Remove client-side Stripe.js initialization
2. Replace embedded form with redirect flow
3. Update success/cancel URL handling
4. Simplify PCI compliance requirements

### Advantages of Stripe-Hosted Checkout
- **Security**: No sensitive card data touches your servers
- **Compliance**: Simplified PCI compliance (SAQ-A)
- **Conversion**: Optimized checkout flow by Stripe
- **Localization**: Automatic language detection
- **Payment Methods**: Access to 40+ payment methods
- **Mobile Optimized**: Responsive design for all devices

### Future Enhancements
- Support for one-time payments
- Coupon and discount code support
- Trial period configuration
- Multiple currency support
- Subscription quantity adjustments