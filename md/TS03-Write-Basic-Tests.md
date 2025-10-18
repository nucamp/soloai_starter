# Write Basic Tests (Auth, UI, Payments)

## Overview
Create comprehensive test coverage for core application flows including authentication, user interface components, and payment processing to ensure system reliability and prevent regressions during development and deployment.

## Requirements

### User Stories
- As a developer, I want automated tests to verify authentication flows work correctly so that users can reliably sign up, log in, and access protected routes
- As a developer, I want UI component tests to catch visual regressions so that the user experience remains consistent across updates
- As a developer, I want payment flow tests to ensure checkout processes work so that revenue operations are not disrupted
- As a QA engineer, I want end-to-end tests to verify complete user journeys so that critical workflows are validated before release

### Functional Requirements

#### Authentication Flow Tests
- **Unit Tests**: Test Better Auth client methods, session validation, and route protection logic
- **Integration Tests**: Verify signup/login forms submit correctly and handle validation errors
- **E2E Tests**: Complete user registration → email verification → login → access protected routes → logout workflow
- **Session Tests**: Verify session persistence across browser tabs and page reloads

#### UI Component Tests
- **Component Tests**: Render all major components (navigation, forms, cards) without errors
- **Responsive Tests**: Verify mobile, tablet, and desktop layouts render correctly
- **Accessibility Tests**: Validate WCAG 2.1 AA compliance with proper ARIA labels and keyboard navigation
- **Internationalization Tests**: Confirm content displays correctly in English, Spanish, and French locales

#### Payment Flow Tests
- **Stripe Tests**: Mock checkout session creation, webhook processing, and subscription status updates
- **LemonSqueezy Tests**: Mock checkout flows, payment confirmations, and billing management
- **Subscription Tests**: Verify tier changes, cancellations, and reactivations update database correctly
- **Error Handling**: Test payment failures, network issues, and invalid payment methods

### Data Requirements
- **Test Database**: Isolated MySQL database for testing with clean state between test runs
- **Mock Data**: User fixtures, product/pricing fixtures, and payment method test data
- **Test API Keys**: Separate Stripe/LemonSqueezy test credentials isolated from development
- **Mock Services**: Stubbed external API responses for Strapi, Mautic, and OpenAI integrations

### Security Considerations
- **Test Isolation**: No test data contamination between test runs or environments
- **Credential Security**: Test API keys separate from production with limited permissions
- **Input Validation**: Test form inputs handle malicious data and prevent injection attacks
- **Session Security**: Verify authentication bypasses are impossible and sessions expire correctly

### Performance Requirements
- **Unit Test Speed**: Individual test files complete within 5 seconds
- **E2E Test Speed**: Complete user workflows finish within 2 minutes per test
- **Test Suite Speed**: Full test suite (unit + E2E) completes within 10 minutes
- **Parallel Execution**: Support running up to 4 concurrent browser instances for E2E tests

## Technical Specifications

### Dependencies
- **Testing Frameworks**: Vitest (unit), Playwright (E2E) from TS01-Vitest-Setup.md and TS02-Playwright-Setup.md
- **Testing Libraries**: @testing-library/svelte, @testing-library/jest-dom, @playwright/test
- **Mock Libraries**: MSW (Mock Service Worker) for API mocking, vi.mock for module mocking
- **Database**: Dedicated test MySQL database separate from development and production

### Test Structure
```
src/
  lib/
    components/
      __tests__/
        Navigation.test.ts
        LoginForm.test.ts
        PricingCard.test.ts
        AccountDashboard.test.ts
    auth/
      __tests__/
        auth-client.test.ts
        route-guards.test.ts
    utils/
      __tests__/
        validation.test.ts
        api-helpers.test.ts
tests/
  e2e/
    auth-flow.spec.ts
    payment-flow.spec.ts
    content-management.spec.ts
    multilingual.spec.ts
  fixtures/
    users.json
    products.json
    payment-methods.json
```

### Environment Variables
- `TEST_DATABASE_URL`: Isolated test database connection string
- `TEST_STRIPE_PUBLISHABLE_KEY`: Stripe test environment publishable key
- `TEST_STRIPE_SECRET_KEY`: Stripe test environment secret key
- `TEST_LEMONSQUEEZY_API_KEY`: LemonSqueezy test environment API key
- `TEST_BETTER_AUTH_SECRET`: Dedicated JWT secret for test environment
- `PLAYWRIGHT_HEADLESS`: Boolean to control browser visibility during E2E tests

### API Changes
- **Test Endpoints**: Create `/api/test/reset-db` endpoint for cleaning test database
- **Mock Handlers**: MSW handlers for external API responses (Strapi, Mautic, OpenAI)
- **Test Middleware**: Database transaction rollback for isolated test runs

## Additional Context for AI Assistant

### Authentication Test Priority
Focus on testing the complete Better Auth integration including:
- User registration with email/password and social OAuth providers
- Session persistence and cross-tab synchronization from AU06-Session-Persistence.md
- Route protection middleware from AU05-Protect-Routes.md
- Password reset workflow from FP01-ForgotPass-Route.md through FP03-ForgotPass-Success.md

### Payment Integration Testing
Mock both Stripe and LemonSqueezy payment processors:
- Use test payment methods and webhook signatures
- Verify subscription status updates from ST04-Stripe-Webhooks.md and LS04-LemonSqueezy-Webhooks.md
- Test subscription management from D04-Account-Billing.md
- Validate pricing tier display from ST05-Stripe-Portal-Integration.md

### Content Management Testing
Test dynamic content delivery:
- Strapi CMS integration from SP05-Strapi-Frontend-Connect.md
- Multilingual content from PG03-Paraglide-Translate-Content.md
- AI translation workflow from AI01-OpenAI-API-Setup.md and AI02-Content-Localization-Workflow.md

### Component Test Coverage
Prioritize testing these completed components:
- Main layout from A02-Create-Layout-Component.md
- Navigation menu from A06-Nav-Menu.md
- Homepage sections from H01-Home-Route.md through H05-Homepage-Footer.md
- Account dashboard from D01-Account-Route.md through D05-Account-Logout.md
- All form components from login, signup, contact, and profile update flows

### Test Data Management
Create comprehensive test fixtures covering:
- User accounts with different subscription tiers
- Strapi content entries in multiple languages
- Payment methods and subscription states
- Mautic contact and campaign data

### Performance and Reliability
Ensure tests are:
- **Deterministic**: Same inputs always produce same outputs
- **Independent**: Tests don't depend on execution order
- **Fast**: Quick feedback for development workflow
- **Comprehensive**: Cover happy paths, edge cases, and error conditions