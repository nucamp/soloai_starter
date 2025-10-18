• Implement runtime validation for all required environment variables to prevent application startup with missing or invalid configuration
• Ensure early failure detection during development and deployment with clear error messages
• Environment variable validation must occur immediately during application startup, before any service initialization
• Application must refuse to start and exit with non-zero status code when required variables are missing or invalid
• Display specific error messages indicating which variables are missing, invalid, or have incorrect format
• Validate all environment variables including database, API keys, authentication secrets, and application settings
• Ensure variables contain valid values with type validation (URLs, numbers, booleans, enums)
• Support different validation rules for development and production environments
• Optional variables should have sensible defaults when not provided
• JWT secrets and session keys must meet minimum length requirements (32+ characters)
• Validation errors must not log or display actual secret values in error messages
• Environment variable values must be sanitized to prevent injection attacks
• Environment variable validation must complete within 100ms
• Validation process should not consume more than 10MB of memory
• Consider zod or joi for schema-based validation with TypeScript support
• Validate DATABASE_URL, OPENAI_API