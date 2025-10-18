# MA02-Mautic-API-Auth.md

## IMPORTANT IMPLEMENTATION NOTE
All configuration and setup for Mautic must be performed exclusively through the official Mautic interfaces:
- Mautic Web UI (Admin Dashboard)
- Mautic REST API
- Mautic CLI Tools

Directly injecting code, editing core source files, or programmatically modifying the Mautic application files, configuration files, or database to create or modify entities is STRICTLY PROHIBITED.

This restriction ensures:
- System consistency and database integrity
- Compatibility with future Mautic updates and plugins
- Maintainability and ease of troubleshooting
- Full support for automation, validation, and permissions features

Do NOT create or modify Mautic entities, configurations, or features by editing PHP files, configuration files, or the database directly.
Always use only the Web UI, official REST API, or CLI commands as documented by Mautic.
If actions are required using the UI, ask the user to perform them through the Mautic Admin interface or provide instructions for using the Mautic CLI.

## Overview
Generate and configure Mautic API credentials to enable programmatic access for user provisioning, contact management, and marketing automation. This establishes the authentication foundation for integrating the SaaS application with Mautic's REST API endpoints.

**Business Value**: Enables automated user provisioning and marketing campaign management without manual intervention, supporting scalable growth and improved user experience.

**Feature Type**: Technical Integration

## Requirements

### Integration Points
- **Mautic Container**: Connect to existing Mautic instance from MA01-Mautic-Container-Setup.md running at http://localhost:8080
- **Better Auth**: Integrate with user registration/login flows from AU02-BetterAuth-Init.md for automatic contact creation
- **Environment Management**: Extend existing environment variable system from EV01-Env-File-Setup.md

### Service Details
- **Mautic Version**: 5.0+ with REST API v2 support
- **API Endpoints**: Access to `/api/contacts`, `/api/campaigns`, `/api/emails`, `/api/segments`
- **Authentication Method**: OAuth 2.0 with client credentials or API token authentication
- **Rate Limits**: Respect Mautic's default 100 requests per hour limit with exponential backoff

### Authentication Requirements
- **API Credentials**: Generate OAuth 2.0 client ID and secret or API token through Mautic admin interface
- **Credential Storage**: Store credentials securely as environment variables following existing patterns
- **Scope Configuration**: Request appropriate permissions for contact management and campaign access
- **Token Management**: Handle token refresh and expiration gracefully

### Functional Requirements
- **Credential Generation**: Create API credentials through Mautic admin panel accessible at http://localhost:8080/admin
- **Permission Configuration**: Set up API user with contact read/write, campaign access, and email management permissions
- **Connection Testing**: Verify API connectivity and authentication with test API call
- **Error Handling**: Implement proper error responses for authentication failures and rate limiting

### Security Considerations
- **Credential Protection**: Never expose API credentials in client-side code or version control
- **Access Control**: Limit API permissions to only required scopes for user provisioning and campaign management
- **Network Security**: Ensure API calls use HTTPS in production environments
- **Token Security**: Store tokens with proper encryption and implement secure rotation procedures

### Performance Requirements
- **Authentication Speed**: Complete authentication handshake within 2 seconds
- **Rate Limit Compliance**: Implement request throttling to stay within Mautic's API limits
- **Connection Pooling**: Reuse HTTP connections for multiple API requests
- **Timeout Handling**: Set appropriate timeouts for API requests (10 seconds default)

## Technical Specifications

### Dependencies
- Existing Mautic container from MA01-Mautic-Container-Setup.md
- HTTP client library (fetch API or axios) for API requests
- Environment variable validation from EV02-Env-Validation.md

### Environment Variables
Add to existing `.env` configuration:
- `MAUTIC_API_URL` - Base URL for Mautic API (http://localhost:8080 for development)
- `MAUTIC_CLIENT_ID` - OAuth 2.0 client identifier
- `MAUTIC_CLIENT_SECRET` - OAuth 2.0 client secret
- `MAUTIC_API_TOKEN` - Alternative to OAuth for simpler authentication
- `MAUTIC_USERNAME` - Admin username for API access (if using basic auth)
- `MAUTIC_PASSWORD` - Admin password for API access (if using basic auth)

### API Configuration
- **Base URL**: `http://localhost:8080/api` for development, configurable for production
- **Authentication Headers**: Include proper authorization headers for all requests
- **Content Type**: Use `application/json` for request/response payload format
- **User Agent**: Include application identifier in API requests for tracking

### Database Changes
No direct database changes required - Mautic manages its own data storage.

### Integration Architecture
- **Service Layer**: Create Mautic API service class for credential management and request handling
- **Authentication Middleware**: Implement token refresh and error handling logic
- **Connection Testing**: Add health check endpoint to verify Mautic API connectivity
- **Logging**: Implement API request/response logging for debugging and monitoring

## Prerequisites
- MA01-Mautic-Container-Setup.md - Mautic container running and accessible
- EV01-Env-File-Setup.md - Environment variable management system
- EV02-Env-Validation.md - Environment variable validation framework

## Success Criteria
- API credentials successfully generated through Mautic admin interface
- Environment variables properly configured and validated
- Test API call successfully authenticates and returns expected response
- Error handling properly manages authentication failures and rate limits
- Foundation established for user provisioning in MA05-Mautic-Frontend-Connect.md