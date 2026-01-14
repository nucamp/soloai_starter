# LS05-Configure-LemonSqueezy-Products.md

## Overview
Configure subscription products and pricing variants in LemonSqueezy dashboard to match the application's pricing tiers. This establishes the product catalog for non-US users who complete checkout through LemonSqueezy's hosted payment pages.

**Feature Type**: Technical Integration

**Business Value**: Creates the product foundation for international SaaS sales, ensuring pricing consistency across payment providers while leveraging LemonSqueezy's automatic tax handling and global payment method support.

**Integration Context**: This configuration creates LemonSqueezy products and variants that mirror the pricing structure already implemented for US users via Stripe (ST06-Configure-Stripe-Products.md). The application uses locale-based routing to direct users to the appropriate payment provider - LemonSqueezy handles all non-US locales while Stripe handles the `en` locale.

## Requirements

### Product Requirements
- **Product Tiers**: Configure products matching P02-Pricing-Tiers.md structure (Starter, Pro, Enterprise)
- **Pricing Variants**: Create monthly and/or annual billing options for each tier
- **Price Consistency**: Match USD pricing displayed on application pricing page
- **Product Metadata**: Include tier identifiers for webhook processing and access control
- **Variant IDs**: Obtain unique variant IDs required by LS03-LemonSqueezy-Checkout-URLs.md
- **Test Mode**: Configure products in test mode during development

### Product Structure
Each subscription tier should include:
- **Product Name**: Clear tier name (e.g., "Pro Plan", "Enterprise Plan")
- **Description**: Brief feature summary for checkout page display
- **Pricing**: Monthly and/or annual options in USD
- **Trial Period**: Optional free trial configuration (e.g., 14 days)
- **Billing Interval**: Monthly or annual recurring billing
- **Product Images**: Optional logo or product imagery for checkout page

### Configuration Requirements
- **Store Setup**: Products created within the LemonSqueezy store from LS01-LemonSqueezy-Account.md
- **Tax Configuration**: Enable automatic tax calculation for international sales
- **Payment Methods**: Ensure credit cards, PayPal, and regional methods are enabled
- **Checkout Customization**: Configure checkout page branding and messaging
- **Customer Portal**: Enable subscription management features
- **Webhook Configuration**: Products must support subscription lifecycle webhooks

### Data Mapping Requirements
- **Tier Mapping**: LemonSqueezy variant IDs must map to application tier names (starter, pro, enterprise)
- **Environment Storage**: Store variant IDs in environment variables for easy reference
- **Pricing Alignment**: LemonSqueezy prices must match Stripe prices for consistent user experience
- **Currency Support**: Configure primary currency as USD with automatic conversion

## Technical Specifications

### Product Configuration Steps

#### 1. Create Products in LemonSqueezy Dashboard
Navigate to Products → Create Product for each tier:

**Starter Plan Product:**
- Name: `Starter Plan` or `[Your App] Starter`
- Description: Entry-level subscription for individual users
- Status: Published (or Draft for testing)
- Product Type: Subscription

**Pro Plan Product:**
- Name: `Pro Plan` or `[Your App] Pro`
- Description: Professional subscription with advanced features
- Status: Published
- Product Type: Subscription

**Enterprise Plan Product:**
- Name: `Enterprise Plan` or `[Your App] Enterprise`
- Description: Full-featured subscription for teams and businesses
- Status: Published
- Product Type: Subscription

#### 2. Create Pricing Variants
For each product, create variants for different billing intervals:

**Monthly Billing Variant:**
- Price: Set according to your pricing tier (e.g., $29/month for Pro)
- Billing Interval: Monthly (every 1 month)
- Trial Period: Optional (e.g., 14 days)
- Renewal: Auto-renew enabled
- Description: Billed monthly

**Annual Billing Variant (Optional):**
- Price: Annual equivalent with discount (e.g., $290/year = ~$24/month)
- Billing Interval: Yearly (every 12 months)
- Trial Period: Optional
- Renewal: Auto-renew enabled
- Description: Billed annually - Save 20%

#### 3. Obtain Variant IDs
After creating variants, note the variant IDs from the LemonSqueezy dashboard:
- Navigate to each product's variant
- Copy the variant ID (format: `123456` or similar numeric ID)
- Variant IDs are required for checkout URL generation in LS03

### Environment Variables
```bash
# LemonSqueezy Product Variant IDs
LEMONSQUEEZY_VARIANT_STARTER_MONTHLY=123456
LEMONSQUEEZY_VARIANT_PRO_MONTHLY=234567
LEMONSQUEEZY_VARIANT_ENTERPRISE_MONTHLY=345678

# Optional: Annual variants if offering annual billing
LEMONSQUEEZY_VARIANT_STARTER_ANNUAL=123457
LEMONSQUEEZY_VARIANT_PRO_ANNUAL=234568
LEMONSQUEEZY_VARIANT_ENTERPRISE_ANNUAL=345679
```

### Product Configuration Utility
```typescript
// src/lib/lemonsqueezy/products.ts
import { env } from '$env/dynamic/private';

/**
 * LemonSqueezy product variant configuration
 * Maps application tiers to LemonSqueezy variant IDs
 */
export const LEMONSQUEEZY_PRODUCTS = {
  starter: {
    monthly: env.LEMONSQUEEZY_VARIANT_STARTER_MONTHLY,
    annual: env.LEMONSQUEEZY_VARIANT_STARTER_ANNUAL,
    tierName: 'starter',
    displayName: 'Starter Plan'
  },
  pro: {
    monthly: env.LEMONSQUEEZY_VARIANT_PRO_MONTHLY,
    annual: env.LEMONSQUEEZY_VARIANT_PRO_ANNUAL,
    tierName: 'pro',
    displayName: 'Pro Plan'
  },
  enterprise: {
    monthly: env.LEMONSQUEEZY_VARIANT_ENTERPRISE_MONTHLY,
    annual: env.LEMONSQUEEZY_VARIANT_ENTERPRISE_ANNUAL,
    tierName: 'enterprise',
    displayName: 'Enterprise Plan'
  }
} as const;

/**
 * Get variant ID for a specific tier and billing interval
 */
export function getVariantId(
  tier: 'starter' | 'pro' | 'enterprise',
  interval: 'monthly' | 'annual' = 'monthly'
): string {
  const variantId = LEMONSQUEEZY_PRODUCTS[tier][interval];
  
  if (!variantId) {
    throw new Error(`No variant ID configured for ${tier} ${interval}`);
  }
  
  return variantId;
}

/**
 * Validate that all required variant IDs are configured
 */
export function validateProductConfiguration(): void {
  const requiredVariants = [
    'LEMONSQUEEZY_VARIANT_STARTER_MONTHLY',
    'LEMONSQUEEZY_VARIANT_PRO_MONTHLY',
    'LEMONSQUEEZY_VARIANT_ENTERPRISE_MONTHLY'
  ];

  const missing = requiredVariants.filter(varName => !process.env[varName]);

  if (missing.length > 0) {
    throw new Error(
      `Missing required LemonSqueezy variant IDs: ${missing.join(', ')}`
    );
  }

  console.log('[LemonSqueezy] Product configuration validated successfully');
}

/**
 * Get all configured variants for a tier
 */
export function getTierVariants(tier: 'starter' | 'pro' | 'enterprise') {
  return LEMONSQUEEZY_PRODUCTS[tier];
}
```

### Pricing Page Integration
```typescript
// src/routes/pricing/+page.svelte
<script lang="ts">
  import { getLocale } from '$lib/paraglide/runtime';
  import { authClient } from '$lib/auth-client';

  // Stripe price IDs for US users (from ST06)
  const STRIPE_PRICE_IDS = {
    starter: 'price_STARTER_MONTHLY',
    pro: 'price_PRO_MONTHLY',
    enterprise: 'price_ENTERPRISE_MONTHLY'
  };

  // LemonSqueezy variant IDs for non-US users
  // These should match the variant IDs from your LemonSqueezy dashboard
  const LEMONSQUEEZY_VARIANT_IDS = {
    starter: import.meta.env.PUBLIC_LEMONSQUEEZY_VARIANT_STARTER_MONTHLY || 'variant_starter_here',
    pro: import.meta.env.PUBLIC_LEMONSQUEEZY_VARIANT_PRO_MONTHLY || 'variant_pro_here',
    enterprise: import.meta.env.PUBLIC_LEMONSQUEEZY_VARIANT_ENTERPRISE_MONTHLY || 'variant_enterprise_here'
  };

  let isLoading = false;
  let sessionData = authClient.useSession();
  const currentUser = $derived($sessionData?.data?.user);
  const currentTier = $derived((currentUser as any)?.subscriptionTier || 'free');

  // Determine payment provider based on locale
  const isUSUser = $derived(getLocale() === 'en');
  const paymentProvider = $derived(isUSUser ? 'Stripe' : 'LemonSqueezy');

  async function handleCheckout(tier: 'starter' | 'pro' | 'enterprise') {
    if (isLoading) return;

    isLoading = true;
    try {
      if (isUSUser) {
        // Use Stripe for US users (locale: en)
        const priceId = STRIPE_PRICE_IDS[tier];
        const response = await fetch('/api/stripe/checkout', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ priceId, tier })
        });

        const data = await response.json();
        if (!response.ok) throw new Error(data.error);

        if (data.url) {
          window.location.href = data.url;
        }
      } else {
        // Use LemonSqueezy for non-US users
        const variantId = LEMONSQUEEZY_VARIANT_IDS[tier];
        const response = await fetch('/api/lemonsqueezy/checkout', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ variantId, tier })
        });

        const data = await response.json();
        if (!response.ok) throw new Error(data.error);

        if (data.url) {
          window.location.href = data.url;
        }
      }
    } catch (error) {
      console.error('Checkout error:', error);
      alert(error instanceof Error ? error.message : 'Failed to start checkout');
      isLoading = false;
    }
  }
</script>
```

### Validation in Server Startup
```typescript
// src/hooks.server.ts or equivalent
import { validateProductConfiguration } from '$lib/lemonsqueezy/products';

// Validate product configuration on server startup
try {
  validateProductConfiguration();
} catch (error) {
  console.error('[LemonSqueezy] Product configuration error:', error);
  // Don't crash server, but log warning
  console.warn('[LemonSqueezy] Some features may not work correctly');
}
```

## Product Configuration Checklist

### Pre-Configuration
- [ ] LemonSqueezy account created and verified (LS01)
- [ ] LemonSqueezy SDK installed and configured (LS02)
- [ ] Pricing tiers defined in application (P02)
- [ ] Stripe products configured for reference (ST06)

### Dashboard Configuration
- [ ] Store configured in LemonSqueezy dashboard
- [ ] Tax settings enabled for automatic calculation
- [ ] Payment methods configured (cards, PayPal, regional)
- [ ] Checkout page branding customized
- [ ] Customer portal features enabled

### Product Creation
- [ ] Starter Plan product created
- [ ] Pro Plan product created
- [ ] Enterprise Plan product created
- [ ] Product descriptions written
- [ ] Product images uploaded (optional)

### Variant Creation
- [ ] Monthly variants created for all tiers
- [ ] Annual variants created (if offering annual billing)
- [ ] Trial periods configured (if applicable)
- [ ] Pricing matches application pricing page
- [ ] Variant IDs recorded for each product

### Environment Setup
- [ ] Variant IDs added to .env file
- [ ] Environment variables validated
- [ ] Test mode configuration verified
- [ ] Product configuration utility created

### Testing
- [ ] Test checkout with each variant ID
- [ ] Verify checkout page displays correctly
- [ ] Confirm success/cancel redirects work
- [ ] Check webhook events fire correctly
- [ ] Validate subscription activation

## Testing Considerations

### Test Mode Products
- Create separate products for test mode vs production
- Use test mode variant IDs during development
- Test with LemonSqueezy test card: 4242 4242 4242 4242
- Verify webhook delivery in test mode

### Price Testing
- Confirm prices display correctly in checkout
- Test tax calculation for different countries
- Verify currency conversion works properly
- Check discount codes if implemented

### Subscription Testing
- Test subscription activation after checkout
- Verify recurring billing configuration
- Test trial period functionality if enabled
- Confirm cancellation flow works correctly

## Common Issues & Solutions

### Issue: Variant ID Not Found
**Solution**: Verify variant ID is correct in LemonSqueezy dashboard and matches environment variable

### Issue: Invalid Signature Error
**Solution**: Ensure you're not modifying the checkout URL after receiving it from LemonSqueezy API

### Issue: Tax Not Calculating
**Solution**: Enable automatic tax calculation in LemonSqueezy store settings

### Issue: Wrong Currency Displayed
**Solution**: Set USD as primary currency in product configuration, enable multi-currency if needed

### Issue: Webhook Not Receiving Events
**Solution**: Verify webhook endpoint is configured in LemonSqueezy dashboard settings

## Additional Context

### Pricing Strategy Considerations
When configuring products, consider:
- **Monthly vs Annual**: Offer annual plans with discount to encourage longer commitments
- **Trial Periods**: 14-day trials can increase conversion rates
- **Price Points**: Align with Stripe pricing for consistency across providers
- **Feature Parity**: Ensure LemonSqueezy tiers match Stripe tier features exactly

### Multi-Currency Support
LemonSqueezy automatically:
- Detects user location
- Displays prices in local currency
- Handles currency conversion
- Calculates appropriate tax/VAT

Configure base prices in USD, LemonSqueezy handles the rest.

### Product Metadata Best Practices
Include metadata in products for:
- Internal tier identification
- Feature flag mapping
- Analytics tracking
- A/B testing variants

### Dual Provider Architecture Benefits
By maintaining parallel product configurations:
- **US Users (Stripe)**: Optimal US payment experience with ACH, wire transfers
- **International Users (LemonSqueezy)**: Automatic tax compliance, regional payment methods
- **Consistent Pricing**: Same displayed prices across all geographies
- **Simplified Tax**: LemonSqueezy handles VAT/GST automatically for international sales

## Prerequisites
- **Required**: ST06-Configure-Stripe-Products.md - Stripe products define the pricing structure to mirror
- **Required**: P02-Pricing-Tiers.md - Application pricing tiers that products must match
- **Required**: PG02-Paraglide-Configure-Langs.md - Locale system for provider routing
- LS01-LemonSqueezy-Account.md - LemonSqueezy account with store access
- LS02-Install-LemonSqueezy-SDK.md - SDK for API interactions

## Success Criteria
- All pricing tier products created in LemonSqueezy dashboard
- Variant IDs obtained and stored in environment variables
- Prices match application pricing page and Stripe products
- Test checkout completes successfully with each variant
- Webhooks deliver subscription events correctly
- Product configuration passes validation checks
- Documentation includes all variant IDs and product details
