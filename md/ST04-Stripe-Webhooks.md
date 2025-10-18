# ST04-Stripe-Webhooks.md

## Overview
Handle Stripe webhook events from Checkout sessions and subscription lifecycle to maintain user billing status synchronization. Process events from Stripe-hosted checkout completions and ongoing subscription management.

**Feature Type**: Technical Integration

## Requirements

### Technical Integration Details
- **Service**: Stripe Webhooks API v2025-06-30.basil+
- **Endpoints**: `/api/stripe/webhook` for receiving webhook events
- **Authentication**: Webhook signature verification using STRIPE_WEBHOOK_SECRET
- **Key Events**: checkout.session.completed from Stripe-hosted checkout
- **Integration Points**: Better Auth user system, Checkout session metadata

### Functional Requirements
- **Checkout Session Events**: Process checkout.session.completed when users complete Stripe-hosted checkout
- **Subscription Events**: Handle customer.subscription.created/updated/deleted for ongoing management
- **Payment Events**: Process invoice.payment_succeeded/failed for recurring billing
- **Signature Verification**: Validate all webhooks using STRIPE_WEBHOOK_SECRET
- **Idempotency**: Prevent duplicate processing using Stripe event IDs
- **User Status Updates**: Update subscription status immediately after checkout completion
- **Customer Linking**: Associate Stripe customers with application users via metadata
- **Error Recovery**: Implement retry logic for transient failures
- **Audit Logging**: Track all webhook events and processing results
- **Portal Events**: Handle customer.portal events for self-service changes

### Data Requirements
- Extend existing user database schema to include subscription status, Stripe customer ID, and billing information
- Store webhook event IDs to implement idempotency and prevent duplicate processing
- Track subscription tier changes with timestamps for billing history and analytics
- Maintain audit logs of all webhook events and processing results for compliance

### Security Considerations
- Implement webhook signature verification using Stripe's signature headers and webhook secret
- Validate webhook event source and authenticity before processing any data changes
- Sanitize webhook payload data to prevent injection attacks and malformed data processing
- Rate limit webhook endpoint to prevent abuse and DoS attacks
- Log security events including invalid signatures and suspicious webhook activity

### Performance Requirements
- Process webhook events within 10 seconds under normal conditions
- Handle up to 100 webhook events per minute without performance degradation
- Implement webhook response within 2 seconds to prevent Stripe retry attempts
- Support concurrent webhook processing for multiple users simultaneously
- Database updates must complete within 5 seconds of webhook receipt

## Technical Specifications

### Dependencies
- Stripe Node.js SDK v14.0+ from ST02-Install-Stripe-SDK.md
- Better Auth user system from AU02-BetterAuth-Init.md
- MySQL database from DB01-DB-Container-Setup.md
- Environment variables from ST01-Stripe-Account-Setup.md (STRIPE_WEBHOOK_SECRET, STRIPE_SECRET_KEY)
- Pricing tiers configuration from P02-Pricing-Tiers.md

### Database Changes
- Add subscription fields to users table: stripe_customer_id, subscription_status, subscription_tier, subscription_end_date
- Create webhook_events table with columns: id, stripe_event_id, event_type, processed_at, user_id, processing_status
- Add database indexes on stripe_customer_id and stripe_event_id for efficient webhook processing
- Create subscription_history table for tracking tier changes and billing events

### API Changes
- New POST endpoint: `/api/stripe/webhook` accepting Stripe webhook payloads
- Webhook endpoint must return 200 status for successful processing, 400 for invalid data, 500 for processing errors
- Implement proper HTTP status codes and error responses for webhook processing failures
- Support raw body parsing for webhook signature verification requirements

### Environment Variables
- STRIPE_WEBHOOK_SECRET: Webhook signing secret from Stripe dashboard
- STRIPE_SECRET_KEY: Server-side API key for Stripe operations (from ST01-Stripe-Account-Setup.md)
- DATABASE_URL: MySQL connection string for subscription data updates

## Additional Context for AI Assistant

### SaaS Architecture Integration
This webhook handler integrates with the existing SvelteKit/Better Auth architecture by:
- Using SvelteKit API routes for webhook endpoint implementation
- Leveraging Better Auth user session management for subscription updates
- Connecting to MySQL database through existing Prisma ORM setup
- Maintaining consistency with established error handling patterns

### Webhook Event Types to Handle

#### Primary Events (Checkout Flow)
- `checkout.session.completed`: Stripe-hosted checkout successful
- `checkout.session.expired`: Checkout session expired without payment

#### Subscription Events
- `customer.subscription.created`: New subscription from checkout
- `customer.subscription.updated`: Plan changes via Customer Portal
- `customer.subscription.deleted`: Subscription cancelled
- `customer.subscription.trial_will_end`: Trial ending notification

#### Payment Events
- `invoice.payment_succeeded`: Successful recurring payment
- `invoice.payment_failed`: Failed payment attempt
- `payment_intent.succeeded`: One-time payment completed

#### Customer Portal Events
- `billing_portal.session.created`: User accessed Customer Portal
- `customer.updated`: Customer info changed in Portal

### Integration with Completed Features
- Build upon Stripe checkout sessions from ST03-Stripe-Checkout-Sessions.md
- Use API key configuration from ST01-Stripe-Account-Setup.md
- Connect to user authentication system from Better Auth setup
- Integrate with pricing tier structure from P02-Pricing-Tiers.md

### Future Integration Points
- Webhook events will trigger Mautic email campaigns for billing notifications
- Subscription status updates will affect user access to protected features
- Payment events will integrate with upcoming account billing dashboard
- Webhook processing will support LemonSqueezy integration patterns