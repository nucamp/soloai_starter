# ST05-Stripe-Portal-Integration.md

## Overview
Connect the existing pricing page and account dashboard UI components to Stripe subscription data, leveraging Stripe-hosted checkout and Customer Portal for payment and subscription management. Display subscription status while delegating sensitive operations to Stripe's secure interfaces.

**Feature Type**: Technical Integration

**Business Value**: Provides users with clear subscription visibility while utilizing Stripe's optimized, secure interfaces for payment collection and subscription management, reducing PCI compliance scope and support burden.

## Requirements

### Functional Requirements

**FR-1: Pricing Page Integration**
- Display current subscription status on pricing tier cards for authenticated users
- Show "Current Plan" badge for active subscription tier
- Display "Upgrade" or "Downgrade" buttons that redirect to Stripe Checkout
- Disable selection of current plan with clear visual indication

**FR-2: Account Dashboard Subscription Display**
- Show subscription overview with tier name and status
- Display next billing date and amount from webhook data
- Show subscription period (monthly/annual) and renewal information
- Include "Manage Subscription" button linking to Stripe Customer Portal

**FR-3: Checkout Redirect Flow**
- Create checkout sessions via API when user selects new plan
- Redirect users to Stripe-hosted checkout page
- Handle success/cancel URL parameters on return
- Display appropriate confirmation messages after checkout

**FR-4: Customer Portal Integration**
- Generate Customer Portal sessions for authenticated users
- Redirect to Stripe Portal for subscription management
- Handle portal return URL with status updates
- Let Stripe handle cancellations, payment method updates, and plan changes

### Data Requirements

**DR-1: User Subscription Model Extension**
- Utilize existing subscription fields from ST04-Stripe-Webhooks.md:
  - `stripe_customer_id`: Links user to Stripe customer
  - `subscription_status`: Current subscription state
  - `subscription_tier`: Active pricing tier
  - `subscription_end_date`: Next billing or cancellation date

**DR-2: Stripe API Data Fetching**
- Retrieve subscription details using Stripe Node.js SDK
- Fetch customer payment methods and billing history
- Cache subscription data for 5 minutes to reduce API calls
- Handle API rate limits with exponential backoff

**DR-3: Real-time Data Synchronization**
- Subscribe to subscription updates from webhook processing
- Update cached subscription data when webhooks modify database
- Invalidate cache when users perform subscription actions
- Maintain data consistency between Stripe and application state

### Security Considerations

**SC-1: Authentication & Authorization**
- Verify Better Auth session before displaying subscription data
- Ensure users can only view their own subscription information
- Validate subscription ownership before allowing management actions
- Protect Stripe API calls with server-side authentication

**SC-2: Data Protection**
- Never expose Stripe secret keys to client-side code
- Sanitize subscription data before sending to frontend
- Log subscription access and modification attempts
- Implement CSRF protection for subscription management forms

**SC-3: Payment Security**
- Use Stripe Customer Portal for sensitive billing operations
- Validate subscription tier changes against available products
- Implement rate limiting for subscription modification attempts
- Audit all subscription management actions with timestamps

### Performance Requirements

**PR-1: Load Times**
- Subscription data must load within 2 seconds on account dashboard
- Pricing page subscription status updates within 1 second
- Cache subscription data for 5 minutes to reduce API latency
- Support 50+ concurrent subscription data requests

**PR-2: API Efficiency**
- Batch Stripe API calls when fetching multiple data points
- Implement client-side caching for subscription status
- Use Stripe webhooks to minimize real-time API calls
- Optimize database queries for subscription data retrieval

**PR-3: User Experience**
- Show loading states during subscription data fetching
- Provide skeleton components while data loads
- Handle network failures gracefully with retry options
- Update UI within 100ms of user subscription actions

## Technical Specifications

### Dependencies
- **Required NPM Packages**: 
  - `stripe` (Node.js SDK) - already installed from ST02-Install-Stripe-SDK.md
- **External Services**: 
  - Stripe API v2025-06-30.basil+ with existing API keys from ST01-Stripe-Account-Setup.md
  - Stripe Checkout (hosted pages)
  - Stripe Customer Portal
- **Existing Code Dependencies**:
  - Better Auth session management from AU04-Global-Client-Setup.md
  - User database schema from ST04-Stripe-Webhooks.md
  - Pricing tier components from P02-Pricing-Tiers.md
  - Account dashboard from D02-Account-Overview.md

### Database Changes
- **No new tables required** - utilizes existing subscription fields added in ST04-Stripe-Webhooks.md:
  - `users.stripe_customer_id`
  - `users.subscription_status`
  - `users.subscription_tier`
  - `users.subscription_end_date`

### API Changes
**New Server Endpoints**:
- `GET /api/stripe/subscription` - Fetch current user subscription data
- `POST /api/stripe/customer-portal` - Generate Customer Portal session URL

**Enhanced Existing Endpoints**:
- `/api/stripe/checkout` from ST03-Stripe-Checkout-Sessions.md handles all subscription operations
- Webhook processing in ST04-Stripe-Webhooks.md updates subscription data

**Removed Endpoints** (handled by Stripe Portal):
- No direct cancellation endpoint - use Customer Portal
- No reactivation endpoint - use Customer Portal
- No payment method update endpoint - use Customer Portal

### Environment Variables
- **Existing Variables** (already configured):
  - `STRIPE_SECRET_KEY` - Server-side Stripe operations
  - `STRIPE_PUBLISHABLE_KEY` - Client-side Stripe integration
  - `STRIPE_WEBHOOK_SECRET` - Webhook signature verification

## Integration Points

### Component Updates Required

**Pricing Page Components** (from P02-Pricing-Tiers.md):
- Modify `PricingTierCard.svelte` to accept subscription status prop
- Update button logic in `PricingButton.svelte` to show current plan status
- Add subscription status indicators and tier comparison features

**Account Dashboard Components** (from D02-Account-Overview.md):
- Extend `AccountOverview.svelte` with subscription information section
- Add new `SubscriptionCard.svelte` component for detailed billing display
- Create `SubscriptionActions.svelte` for management operations

**Authentication Integration**:
- Build upon Better Auth session from AU04-Global-Client-Setup.md
- Ensure subscription data fetching respects authentication state
- Handle unauthenticated users gracefully in pricing displays

### Data Flow Architecture

**Client-Side Flow**:
1. Better Auth session provides authenticated user context
2. SvelteKit load functions fetch subscription data from API endpoints
3. Components reactively update based on subscription state changes
4. User actions trigger API calls and optimistic UI updates

**Server-Side Flow**:
1. API endpoints validate Better Auth session tokens
2. Stripe API calls retrieve real-time subscription information
3. Database queries supplement Stripe data with application state
4. Webhook events update database and invalidate client caches

### Internationalization Support
- Integrate with Paraglide i18n system from PG02-Paraglide-Configure-Langs.md
- Support subscription status display in English, Spanish, and French
- Translate subscription tier names and billing terminology
- Localize date formatting for billing dates and trial periods

### Error Handling Strategy
- Graceful degradation when Stripe API is unavailable
- Fallback to cached subscription data during network issues
- Clear error messages for subscription management failures
- Retry mechanisms for temporary API failures with exponential backoff

## Additional Context for AI Assistant

**Integration Complexity**: This feature requires careful coordination between multiple existing systems:
- Stripe API integration (ST01-ST04)
- Better Auth user sessions (AU02-AU06)
- Existing UI components (P02, D02)
- Database schema modifications (ST04)

**User Experience Priority**: Focus on creating seamless transitions between subscription states without requiring page refreshes. Users should see immediate feedback for their actions while background processes handle Stripe synchronization.

**Performance Considerations**: Implement intelligent caching strategies to balance real-time accuracy with API efficiency. Subscription data changes infrequently but must be current for billing operations.

**Future Integration Points**: This implementation prepares for:
- LemonSqueezy integration (LS01-LS05) requiring similar UI patterns
- Advanced billing features and subscription analytics
- Multi-currency and tax calculation displays