• Establish secure environment variable management system for development, testing, and production environments
• Create structured `.env` configuration files with validation and documentation for all service integrations
• Generate `.env.example` template file with placeholder values and comprehensive documentation
• Implement proper .gitignore configuration to prevent sensitive data from entering version control
• Establish SCREAMING_SNAKE_CASE naming conventions with service prefixes
• Support multiple environment contexts (development, test, production) with environment-specific overrides
• Include database configuration variables for MySQL container connection strings and credentials
• Store service API keys securely for OpenAI, Strapi tokens, and Mautic credentials
• Configure authentication secrets including JWT secrets, session keys, and OAuth credentials for Better Auth
• Set application settings including base URLs, port configurations, and feature flags
• Configure localization settings for default locale, supported languages, and translation services
• Never commit actual API keys, passwords, or sensitive tokens to version control
• Use strong, randomly generated secrets for JWT signing and session management
• Implement proper file permissions (600) for .env files in production environments
• Environment variable loading must complete within 100ms during application startup
• Support