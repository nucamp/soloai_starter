• Generate and configure Mautic API credentials to enable programmatic access for user provisioning, contact management, and marketing automation

• Establishes authentication foundation for integrating SaaS application with Mautic's REST API endpoints

• Enables automated user provisioning and marketing campaign management without manual intervention

• Connect to existing Mautic instance running at http://localhost:8080 from previous container setup

• Integrate with Better Auth user registration/login flows for automatic contact creation

• Support Mautic Version 5.0+ with REST API v2 for contacts, campaigns, emails, and segments endpoints

• Use OAuth 2.0 with client credentials or API token authentication methods

• Respect Mautic's default 100 requests per hour rate limit with exponential backoff

• Generate API credentials through Mautic admin panel at http://localhost:8080/admin

• Configure API user permissions for contact read/write, campaign access, and email management

• Store credentials securely as environment variables following existing patterns

• Never expose API credentials in client-side code or version control systems

• Implement proper error handling for authentication failures and rate limiting scenarios

• Complete authentication