• Set up OpenAI API integration to enable automated content translation workflow for SaaS application across English, Spanish, and French languages

• Use OpenAI API v1 with GPT-4 or GPT-3.5-turbo models via official Node.js SDK v4.0+ for translation tasks

• Store OpenAI API key securely as `OPENAI_API_KEY` environment variable, never exposing it in client-side code or version control

• Respect OpenAI rate limits (typically 3 requests/minute for new accounts) with proper error handling and graceful degradation

• Prepare integration points for Strapi CMS content translation, future Mautic email campaigns, and Paraglide i18n compatibility

• Implement translation testing capability to successfully translate sample text from English to Spanish and French

• Preserve HTML markup, rich text formatting, and content structure during translation process

• Support batch processing of multiple content fields in single API request for efficiency

• Accept structured content objects with field identification and return translated content maintaining original structure

• Implement input validation, sanitization, and secure error logging without exposing sensitive data

• Ensure translation requests