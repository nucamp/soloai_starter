# MA07-Email-Translations-Route.md

## Overview
Create a SvelteKit API endpoint that generates localized versions of Mautic emails using the translation service and Mautic APIs. The endpoint accepts an English email ID and target locales, translates the email content, and creates linked translated versions in Mautic.

**Feature Type**: API Endpoint

## Requirements

### Endpoint Specification
- **Path**: `/api/mautic/emails/translate`
- **Method**: POST
- **Authentication**: Required (API key or session)
- **Content-Type**: application/json

### Request Parameters
```typescript
interface TranslateEmailRequest {
  emailId: number;        // ID of the English source email in Mautic
  locales: string[];      // Array of target locale codes (e.g., ['es', 'fr', 'de'])
  linkToParent?: boolean; // Whether to link translations to parent (default: true)
  overwrite?: boolean;    // Whether to overwrite existing translations (default: false)
}
```

### Response Format
```typescript
interface TranslateEmailResponse {
  success: boolean;
  sourceEmail: {
    id: number;
    name: string;
    subject: string;
  };
  translations: Array<{
    locale: string;
    emailId: number;
    name: string;
    subject: string;
    status: 'created' | 'updated' | 'skipped' | 'error';
    message?: string;
  }>;
  errors?: string[];
}
```

### Functional Requirements
- **Email Retrieval**: Fetch the source English email from Mautic using its ID
- **Content Extraction**: Extract translatable fields (subject, preheader, body, CTAs)
- **Translation Processing**: Use OpenAI API to translate content to target locales
- **Email Creation**: Create new localized emails in Mautic for each locale
- **Parent Linking**: Link translated emails to the English parent email
- **Error Handling**: Gracefully handle API failures and partial successes

### Translation Fields
- Email subject line
- Preheader text
- Email body content (HTML and plain text)
- CTA button text
- Alt text for images
- Dynamic content blocks

### Mautic Integration Requirements
- Use Mautic REST API v3 for all operations
- Preserve email templates and styling
- Maintain personalization tokens (e.g., {contactfield=firstname})
- Keep tracking pixels and links intact
- Preserve email categories and segments

## Technical Specifications

### Dependencies
- Mautic API client configuration from MA02-Mautic-API-Auth.md
- Translation service from AI02-Content-Localization-Workflow.md
- OpenAI integration from AI01-OpenAI-API-Setup.md
- Paraglide language configuration from PG02-Paraglide-Configure-Langs.md

### API Workflow
1. **Validate Request**
   - Verify email ID exists in Mautic
   - Validate locale codes against supported languages
   - Check user permissions

2. **Fetch Source Email**
   ```javascript
   GET /api/emails/{emailId}
   Authorization: Bearer {mautic_token}
   ```

3. **Extract Translatable Content**
   - Parse HTML/text content
   - Identify translatable strings
   - Preserve non-translatable elements (tokens, tracking)

4. **Translate Content**
   - Call translation service for each locale
   - Maintain formatting and structure
   - Handle special characters and HTML entities

5. **Create Translated Emails**
   ```javascript
   POST /api/emails/new
   Authorization: Bearer {mautic_token}
   Content-Type: application/json
   {
     "name": "{original_name} - {locale}",
     "subject": "{translated_subject}",
     "customHtml": "{translated_html}",
     "plainText": "{translated_text}",
     "language": "{locale}",
     "translationParent": {emailId}
   }
   ```

6. **Link to Parent**
   ```javascript
   PUT /api/emails/{translatedId}/edit
   {
     "translationParent": {parentEmailId},
     "language": "{locale}"
   }
   ```

### Error Handling
- **API Rate Limiting**: Implement exponential backoff for Mautic API calls
- **Translation Failures**: Continue with other locales if one fails
- **Partial Success**: Return details of successful and failed translations
- **Validation Errors**: Return specific error messages for invalid inputs
- **Network Errors**: Implement retry logic with timeout

### Environment Variables
```bash
MAUTIC_BASE_URL=http://localhost:8080
MAUTIC_API_USERNAME=admin
MAUTIC_API_PASSWORD=password
OPENAI_API_KEY=sk-...
TRANSLATION_BATCH_SIZE=5
TRANSLATION_TIMEOUT_MS=30000
```

### Implementation Example
```typescript
// src/routes/api/mautic/emails/translate/+server.ts
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { getMauticClient } from '$lib/mautic/client';
import { translateContent } from '$lib/services/translation';

export const POST: RequestHandler = async ({ request }) => {
  const { emailId, locales, linkToParent = true, overwrite = false } = await request.json();
  
  const mautic = getMauticClient();
  const results = {
    success: false,
    sourceEmail: null,
    translations: [],
    errors: []
  };
  
  try {
    // 1. Fetch source email
    const sourceEmail = await mautic.emails.get(emailId);
    results.sourceEmail = {
      id: sourceEmail.id,
      name: sourceEmail.name,
      subject: sourceEmail.subject
    };
    
    // 2. Process each locale
    for (const locale of locales) {
      try {
        // Check for existing translation
        const existing = await mautic.emails.getList({
          search: `translationParent:${emailId} AND language:${locale}`
        });
        
        if (existing.total > 0 && !overwrite) {
          results.translations.push({
            locale,
            emailId: existing.emails[0].id,
            name: existing.emails[0].name,
            subject: existing.emails[0].subject,
            status: 'skipped',
            message: 'Translation already exists'
          });
          continue;
        }
        
        // Translate content
        const translatedContent = await translateContent({
          subject: sourceEmail.subject,
          html: sourceEmail.customHtml,
          text: sourceEmail.plainText
        }, locale);
        
        // Create or update translated email
        const emailData = {
          name: `${sourceEmail.name} - ${locale.toUpperCase()}`,
          subject: translatedContent.subject,
          customHtml: translatedContent.html,
          plainText: translatedContent.text,
          language: locale,
          ...(linkToParent && { translationParent: emailId })
        };
        
        const translatedEmail = existing.total > 0 && overwrite
          ? await mautic.emails.edit(existing.emails[0].id, emailData)
          : await mautic.emails.create(emailData);
        
        results.translations.push({
          locale,
          emailId: translatedEmail.id,
          name: translatedEmail.name,
          subject: translatedEmail.subject,
          status: existing.total > 0 && overwrite ? 'updated' : 'created'
        });
        
      } catch (error) {
        results.translations.push({
          locale,
          emailId: null,
          name: null,
          subject: null,
          status: 'error',
          message: error.message
        });
        results.errors.push(`Failed to translate to ${locale}: ${error.message}`);
      }
    }
    
    results.success = results.translations.some(t => t.status !== 'error');
    return json(results);
    
  } catch (error) {
    return json({
      success: false,
      error: `Failed to fetch source email: ${error.message}`
    }, { status: 500 });
  }
};
```

### Testing Requirements
- Unit tests for translation logic
- Integration tests with Mautic API
- Mock API responses for development
- Error scenario testing
- Performance testing with multiple locales

### Security Considerations
- Validate and sanitize all input parameters
- Implement rate limiting on the endpoint
- Use API authentication (Bearer token or API key)
- Log all translation operations for audit
- Sanitize HTML content to prevent XSS
- Validate locale codes against whitelist

### Performance Optimization
- Cache Mautic API tokens
- Batch translation requests to OpenAI
- Implement request queuing for large batches
- Use concurrent processing for multiple locales
- Cache frequently translated content
- Implement progress tracking for long operations

## Usage Example

### Request
```bash
curl -X POST http://localhost:5173/api/mautic/emails/translate \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_API_TOKEN" \
  -d '{
    "emailId": 123,
    "locales": ["es", "fr", "de"],
    "linkToParent": true,
    "overwrite": false
  }'
```

### Response
```json
{
  "success": true,
  "sourceEmail": {
    "id": 123,
    "name": "Welcome Email",
    "subject": "Welcome to our SaaS!"
  },
  "translations": [
    {
      "locale": "es",
      "emailId": 124,
      "name": "Welcome Email - ES",
      "subject": "¡Bienvenido a nuestro SaaS!",
      "status": "created"
    },
    {
      "locale": "fr",
      "emailId": 125,
      "name": "Welcome Email - FR",
      "subject": "Bienvenue dans notre SaaS!",
      "status": "created"
    },
    {
      "locale": "de",
      "emailId": 126,
      "name": "Welcome Email - DE",
      "subject": "Willkommen bei unserem SaaS!",
      "status": "created"
    }
  ]
}
```

## Additional Implementation Notes

1. **Preserve Email Structure**: Ensure that the email template structure, CSS styles, and responsive design are maintained in translated versions

2. **Handle Dynamic Content**: Properly handle Mautic's dynamic content blocks and conditional content during translation

3. **Segment Association**: Maintain the same segment associations for translated emails as the parent email

4. **Campaign Integration**: If the parent email is part of a campaign, consider automatically adding translated versions to locale-specific campaign variants

5. **Translation Memory**: Consider implementing a translation memory system to reuse previously translated phrases and maintain consistency

6. **Webhook Integration**: Optionally trigger this endpoint via Mautic webhooks when new emails are created

7. **Bulk Operations**: Consider adding a batch endpoint for translating multiple emails in a single request

8. **Progress Tracking**: For large translation jobs, implement a job queue system with progress tracking and webhook notifications