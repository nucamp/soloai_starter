• Integrate Mautic API with Better Auth signup/login flows to automatically create and update contacts for marketing automation and user engagement

• Enables automated marketing campaigns, user segmentation, and lead nurturing workflows by synchronizing user data between authentication system and marketing platform

• Uses Mautic 5.0+ REST API v2 with `/api/contacts` and `/api/segments` endpoints for contact management and categorization

• Requires OAuth 2.0 client credentials or API token with rate limiting of 100 requests per hour and exponential backoff retry mechanism

• Automatically creates Mautic contact within 30 seconds when user completes Better Auth registration with email, name, registration date, and user source data

• Maps Better Auth user fields to Mautic contact fields and assigns new users to "New Signups" segment for onboarding campaigns

• Handles duplicate contacts by checking existing email addresses and updating rather than creating duplicates

• Synchronizes profile updates within 60 seconds when authenticated users modify their information including name, email, locale, and subscription preferences

• Provides marketing opt-in/opt-out management with newsletter signup forms and GDPR-