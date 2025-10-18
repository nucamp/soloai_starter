# LS05-Configure-LemonSqueezy-Products.md

## Overview
Configure subscription products and pricing plans in the LemonSqueezy dashboard for use with LemonSqueezy-hosted checkout pages. Set up products with automatic tax handling through LemonSqueezy's merchant of record service, enabling global sales without tax compliance complexity.

## Requirements

### Functional Requirements
- **Product Configuration**: Create subscription products (Pro, Enterprise) in LemonSqueezy dashboard
- **Pricing Variants**: Configure monthly and annual billing options for each product
- **Checkout Customization**: Set up hosted checkout page appearance and options
- **Customer Portal**: Enable customer portal for subscription self-service
- **Tax Settings**: Configure automatic tax calculation (handled by LemonSqueezy)
- **Test Mode**: Use test mode for development environment
- **Webhook Configuration**: Set up webhooks for subscription events

### Data Requirements
- **Free Tier**: $0.00 with metadata including tier_id "free", max_users "1", features "basic"
- **Pro Tier**: $29.00 monthly/$290.00 annual with metadata including tier_id "pro", max_users "10", features "advanced"
- **Enterprise Tier**: $99.00 monthly/$990.00 annual with metadata including tier_id "enterprise", max_users "unlimited", features "premium"
- **Product Metadata Structure**: Consistent tier_id, max_users, features, trial_period fields for application mapping
- **Pricing IDs**: Unique identifiers for each plan that can be referenced in checkout API calls

### Security Considerations
- **Test Mode**: Use sandbox environment for development to prevent accidental charges
- **API Key Protection**: Never expose LemonSqueezy API keys in client-side code
- **Product Validation**: Validate product IDs in application before checkout creation
- **Webhook Security**: Ensure webhook endpoints are properly configured for secure event processing

### Performance Requirements
- **Dashboard Response**: Product configuration changes must reflect within 30 seconds
- **API Access**: Product/plan data must be retrievable via API within 2 seconds
- **Checkout Integration**: Product IDs must be available for immediate checkout session creation
- **Webhook Delivery**: Configure webhooks with maximum 30-second delivery delay

## Technical Specifications

### Dependencies
- Completed LemonSqueezy account setup from LS01-LemonSqueezy-Account.md
- LemonSqueezy SDK installation from LS02-Install-LemonSqueezy-SDK.md
- Existing pricing tier structure from P02-Pricing-Tiers.md
- Environment variables: LEMON_SQUEEZY_API_KEY, LEMON_SQUEEZY_STORE_ID

### Dashboard Configuration Steps

#### Store Settings
1. Navigate to Settings → Store in LemonSqueezy dashboard
2. Configure store information:
   - Store name and branding
   - Support email and contact info
   - Terms of service and privacy policy URLs
3. Set up checkout appearance:
   - Upload logo and brand colors
   - Configure checkout page styling
   - Enable/disable checkout options

#### Product Creation
1. Navigate to Products section
2. Create "Pro Plan" product:
   - Add monthly variant: $29.00/month
   - Add annual variant: $290.00/year
   - Set 14-day free trial
   - Enable recurring billing
3. Create "Enterprise Plan" product:
   - Add monthly variant: $99.00/month
   - Add annual variant: $990.00/year
   - Set 14-day free trial
   - Enable recurring billing

#### Customer Portal Setup
1. Navigate to Settings → Customer Portal
2. Enable portal features:
   - Subscription management
   - Payment method updates
   - Invoice downloads
   - Cancellation options
3. Customize portal branding
4. Configure cancellation flow

#### Webhook Configuration
1. Navigate to Settings → Webhooks
2. Add webhook endpoint:
   - URL: `https://yourdomain.com/api/lemonsqueezy/webhook`
   - Select all subscription events
   - Copy signing secret for application
3. Test webhook delivery

### Product Structure
- **Free Tier Product**: 
  - Name: "Free Plan"
  - Price: $0.00
  - Billing: One-time (lifetime access)
  - Metadata: `{"tier_id": "free", "max_users": "1", "features": "basic"}`
  
- **Pro Tier Product**:
  - Name: "Pro Plan" 
  - Monthly: $29.00/month with 14-day trial
  - Annual: $290.00/year (equivalent to 10 months)
  - Metadata: `{"tier_id": "pro", "max_users": "10", "features": "advanced", "trial_period": "14"}`
  
- **Enterprise Tier Product**:
  - Name: "Enterprise Plan"
  - Monthly: $99.00/month with 14-day trial  
  - Annual: $990.00/year (equivalent to 10 months)
  - Metadata: `{"tier_id": "enterprise", "max_users": "unlimited", "features": "premium", "trial_period": "14"}`

### API Integration Points
- **Product Retrieval**: Products must be accessible via LemonSqueezy API for dynamic pricing display
- **Checkout Creation**: Product variant IDs must be available for checkout session creation
- **Webhook Configuration**: Products must trigger proper webhook events for subscription lifecycle management
- **Metadata Access**: Product metadata must be retrievable for feature access control

### Environment Variables
- **LEMON_SQUEEZY_STORE_ID**: Store identifier for product management
- **LEMON_SQUEEZY_ENVIRONMENT**: Set to "sandbox" for testing, "production" for live
- **Product Configuration**: Store product/variant IDs in environment variables for checkout integration

## Integration Context

### Prerequisite Dependencies
- LemonSqueezy account setup and API credentials from LS01-LemonSqueezy-Account.md  
- LemonSqueezy SDK installation and configuration from LS02-Install-LemonSqueezy-SDK.md
- Existing pricing tier display from P02-Pricing-Tiers.md
- Better Auth user system for customer identification

### Future Integration Points
- Checkout flow implementation will reference configured product IDs
- Webhook processing will validate subscription events against these products
- Account billing dashboard will display subscription tier information from these products
- Payment UI will need to map these LemonSqueezy products to existing pricing cards

### Validation Requirements
- Product IDs must be validated in application before creating checkout sessions
- Metadata structure must be consistent across all tiers for feature mapping
- Pricing must match existing Stripe configuration for payment processor consistency
- Trial periods must align with application business logic and user experience

## Additional Context

### LemonSqueezy Checkout Benefits
- **Hosted Pages**: Fully managed checkout experience
- **Tax Compliance**: Automatic VAT/sales tax handling
- **Multi-currency**: Local currency display and conversion
- **Payment Methods**: Cards, PayPal, and regional methods
- **Customer Portal**: Built-in subscription management
- **Invoicing**: Automatic invoice generation and delivery

### Merchant of Record Service
LemonSqueezy acts as the merchant of record, meaning:
- They handle all tax calculations and remittance
- They issue invoices to customers
- They manage payment processing and disputes
- You receive a single monthly payout
- Simplified accounting with one vendor relationship

### Testing Checkout Flow
1. Use test mode in LemonSqueezy dashboard
2. Create test checkout URLs with product variants
3. Complete test purchases with test cards
4. Verify webhook events are received
5. Check customer portal functionality
6. Test subscription management flows

### Integration with Application
The configured products will be used for:
- Generating checkout URLs in LS03-LemonSqueezy-Checkout-URLs.md
- Processing webhook events in LS04-LemonSqueezy-Webhooks.md
- Displaying subscription status in account dashboard
- Managing subscriptions through customer portal

## Success Criteria
- Products configured with correct pricing in dashboard
- Checkout pages customized with branding
- Customer portal enabled for self-service
- Webhooks configured and tested
- Test mode working for development
- Variant IDs ready for checkout URL generation