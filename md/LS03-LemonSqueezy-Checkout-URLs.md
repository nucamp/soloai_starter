# LS03-LemonSqueezy-Checkout-URLs.md

## Overview
Create server-side API endpoint to generate LemonSqueezy checkout URLs that redirect users to LemonSqueezy-hosted payment pages. LemonSqueezy acts as merchant of record, handling all payment processing, tax calculation, and compliance requirements through their optimized checkout experience.

**Feature Type**: Technical Integration

## Requirements

### User Stories
- As a potential customer, I want to purchase subscriptions through LemonSqueezy's secure checkout
- As an international user, I want automatic tax calculation in my local currency
- As a user, I want a seamless redirect to LemonSqueezy's optimized checkout page

### Integration Points
- Connect with pricing tier cards from P02-Pricing-Tiers.md
- Integrate with Better Auth user system for customer identification
- Build upon SDK installation from LS02-Install-LemonSqueezy-SDK.md
- Utilize existing pricing page structure from P03-Pricing-Checkout-Link.md

### Functional Requirements
- **Checkout URL Generation**: Server-side endpoint creates checkout URLs with user and product data
- **Authentication**: Verify Better Auth session before creating checkout URLs
- **Product Validation**: Validate selected variant ID against configured products
- **Customer Data**: Pass user email and ID for customer record creation
- **Success/Cancel URLs**: Configure return URLs for post-payment redirects
- **Metadata**: Include user ID and tier information for webhook processing

### Security Considerations
- API keys stored securely in environment variables
- Authentication required for checkout URL creation
- Rate limiting: 10 checkout URLs per user per hour
- URL validation to prevent open redirects
- HTTPS-only for production checkouts

### Performance Requirements
- Checkout URL generation within 2 seconds
- Support 100+ concurrent checkout creations
- Immediate redirect to LemonSqueezy checkout
- Graceful error handling with user feedback

## Technical Specifications

### Dependencies
- LemonSqueezy Node.js SDK from LS02-Install-LemonSqueezy-SDK.md
- Better Auth session validation
- Environment variables: LEMONSQUEEZY_API_KEY, LEMONSQUEEZY_STORE_ID
- Product variant IDs from LS05-Configure-LemonSqueezy-Products.md

### API Endpoint
```typescript
// POST /api/lemonsqueezy/checkout
interface CheckoutRequest {
  variantId: string;        // LemonSqueezy product variant ID
  tier: 'pro' | 'enterprise'; // Subscription tier
}

interface CheckoutResponse {
  url: string;      // LemonSqueezy checkout URL
  checkoutId: string; // Checkout ID for tracking
}
```

### Implementation Example
```typescript
// src/routes/api/lemonsqueezy/checkout/+server.ts
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { createCheckout } from '@lemonsqueezy/lemonsqueezy.js';
import { env } from '$env/dynamic/private';

export const POST: RequestHandler = async ({ request, locals, url }) => {
  // Verify authentication
  const session = await locals.auth();
  if (!session?.user) {
    return json({ error: 'Authentication required' }, { status: 401 });
  }

  const { variantId, tier } = await request.json();

  try {
    // Create checkout URL
    const checkout = await createCheckout(
      env.LEMONSQUEEZY_STORE_ID,
      variantId,
      {
        checkoutData: {
          email: session.user.email,
          name: session.user.name,
          custom: {
            user_id: session.user.id,
            tier: tier
          }
        },
        checkoutOptions: {
          embed: false, // Use hosted checkout
          media: false, // Hide product images for cleaner checkout
          logo: true,   // Show store logo
          success_url: `${url.origin}/account?success=true&checkout_id={CHECKOUT_ID}`,
          cancel_url: `${url.origin}/pricing?canceled=true`
        },
        productOptions: {
          redirect_url: `${url.origin}/account`,
          receipt_thank_you_note: "Thank you for your subscription!"
        }
      }
    );

    if (checkout.error) {
      console.error('Checkout creation failed:', checkout.error);
      return json(
        { error: 'Failed to create checkout' },
        { status: 500 }
      );
    }

    return json({
      url: checkout.data?.attributes.url,
      checkoutId: checkout.data?.id
    });

  } catch (error) {
    console.error('Checkout error:', error);
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
  async function handleLemonSqueezyCheckout(variantId: string, tier: string) {
    try {
      const response = await fetch('/api/lemonsqueezy/checkout', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ variantId, tier })
      });

      if (!response.ok) {
        throw new Error('Checkout failed');
      }

      const { url } = await response.json();
      
      // Redirect to LemonSqueezy-hosted checkout
      window.location.href = url;
    } catch (error) {
      console.error('Checkout error:', error);
      // Show error message to user
    }
  }
</script>

<button on:click={() => handleLemonSqueezyCheckout('variant_xxx', 'pro')}>
  Subscribe with LemonSqueezy
</button>
```

### Checkout Configuration

#### Required Parameters
- `storeId`: Your LemonSqueezy store ID
- `variantId`: Product variant to purchase
- `email`: Customer email address

#### Optional Customization
- `name`: Customer full name
- `custom`: Metadata for webhook processing
- `success_url`: Return URL after successful payment
- `cancel_url`: Return URL if checkout canceled
- `receipt_thank_you_note`: Custom message on receipt

### Success/Cancel Handling
```typescript
// src/routes/account/+page.ts
export async function load({ url }) {
  const success = url.searchParams.get('success');
  const checkoutId = url.searchParams.get('checkout_id');
  
  if (success === 'true' && checkoutId) {
    // Payment successful, wait for webhook confirmation
    return {
      message: 'Payment successful! Your subscription will be activated shortly.',
      checkoutId
    };
  }
}
```

### Error Handling
- **Invalid Variant**: Return 400 with error message
- **Authentication Failed**: Return 401 unauthorized
- **API Error**: Log details and return 500
- **Rate Limit**: Return 429 with retry-after
- **Network Issues**: Implement retry logic

### Testing
- Use test mode for development
- Test with various product variants
- Verify success/cancel redirects
- Check webhook event delivery
- Validate customer portal access

## Customer Portal

LemonSqueezy provides a built-in customer portal where users can:
- Update payment methods
- Cancel subscriptions
- Download invoices
- Change plans
- Update billing information

Generate portal URL:
```typescript
// Generate customer portal URL
async function getCustomerPortalUrl(customerId: string) {
  const customer = await getCustomer(customerId);
  return customer.data?.attributes.urls.customer_portal;
}
```

## Webhook Integration

After successful payment, LemonSqueezy sends webhook events:
- `order_created`: Initial purchase completed
- `subscription_created`: Subscription activated
- `subscription_updated`: Plan changes
- `subscription_payment_success`: Renewal payment

These are handled in LS04-LemonSqueezy-Webhooks.md.

## Additional Context

### LemonSqueezy Checkout Features
- **Tax Compliance**: Automatic VAT/sales tax calculation
- **Multi-currency**: Local currency display and conversion
- **Payment Methods**: Cards, PayPal, and regional methods
- **Localization**: Automatic language detection
- **Mobile Optimized**: Responsive checkout design
- **Fraud Protection**: Built-in fraud detection

### Merchant of Record Benefits
- LemonSqueezy handles all tax compliance
- No need for tax registration in multiple countries
- Automatic invoice generation
- Simplified accounting (one invoice from LemonSqueezy)
- Reduced legal and compliance burden

### Migration from Embedded Checkout
If migrating from embedded forms:
1. Remove client-side checkout code
2. Replace with server-side URL generation
3. Update success/cancel handling
4. Simplify error handling
5. Remove PCI compliance requirements

### Dual Payment Provider Support
The application can support both Stripe and LemonSqueezy:
```typescript
// Choose provider based on user location or preference
const useL lemonSqueezy = userCountry === 'EU' || userPreference === 'lemonsqueezy';

if (useLemonSqueezy) {
  // Redirect to LemonSqueezy checkout
} else {
  // Redirect to Stripe checkout
}
```

## Prerequisites
- LS01-LemonSqueezy-Account.md - Account and API setup
- LS02-Install-LemonSqueezy-SDK.md - SDK installation
- LS05-Configure-LemonSqueezy-Products.md - Product configuration

## Success Criteria
- Checkout URLs generated successfully
- Users redirected to LemonSqueezy checkout
- Success/cancel redirects working
- Metadata passed for webhook processing
- Authentication and rate limiting enforced
- Error handling provides good UX