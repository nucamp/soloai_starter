# OpenAI Integration Guide

## Overview

This guide documents the OpenAI API integration for automated content translation in the SoloAI application.

## 🎯 Features Implemented

✅ **OpenAI SDK Integration**: Latest OpenAI Node.js SDK installed and configured  
✅ **Translation Service**: Comprehensive service class with error handling and rate limiting  
✅ **API Endpoints**: RESTful endpoints for translation testing and execution  
✅ **Test Interface**: Web interface for testing translations at `/test/translation`  
✅ **Environment Configuration**: Secure API key management  
✅ **Error Handling**: Graceful degradation when API is unavailable  

## 🔧 Configuration

### Environment Variables

Add to your `.env` file:

```env
# OpenAI Configuration
OPENAI_API_KEY=your_openai_api_key_here
OPENAI_MODEL=gpt-4o-mini
TRANSLATION_ENABLED=true
```

### Getting an OpenAI API Key

1. Visit [OpenAI Platform](https://platform.openai.com/)
2. Create an account or log in
3. Navigate to API Keys section
4. Create a new API key
5. Copy the key to your `.env` file

## 📡 API Endpoints

### GET `/api/translate`
Test the translation service status and run basic functionality tests.

**Response:**
```json
{
  "status": "success",
  "message": "Translation service test endpoint",
  "available": true,
  "test": {
    "success": true,
    "message": "Translation service working correctly",
    "data": {
      "original": { "title": "Welcome to SoloAI" },
      "spanish": { "title": "Bienvenido a SoloAI" },
      "french": { "title": "Bienvenue chez SoloAI" }
    }
  }
}
```

### POST `/api/translate`
Translate content to a target language.

**Request:**
```json
{
  "content": {
    "title": "Welcome to SoloAI",
    "subtitle": "The Future of AI",
    "description": "Transform your business with cutting-edge AI solutions."
  },
  "targetLanguage": "Spanish",
  "contentType": "SaaS marketing",
  "context": "Homepage hero section"
}
```

**Response:**
```json
{
  "status": "success",
  "message": "Translation completed",
  "data": {
    "translatedContent": {
      "title": "Bienvenido a SoloAI",
      "subtitle": "El Futuro de la IA",
      "description": "Transforma tu negocio con soluciones de IA de vanguardia."
    },
    "sourceLanguage": "en",
    "targetLanguage": "Spanish",
    "model": "gpt-4o-mini",
    "timestamp": "2025-08-12T00:00:00.000Z"
  }
}
```

## 🧪 Testing

### Local Testing Script
```bash
# Test without API key (checks integration)
node scripts/test-translation-local.js

# Test with API key (full functionality)
OPENAI_API_KEY=your_key_here node scripts/test-translation-local.js
```

### Web Interface
Visit `http://localhost:5173/test/translation` for interactive testing.

### Command Line Testing
```bash
# Test service status
curl http://localhost:5173/api/translate

# Test translation
curl -X POST http://localhost:5173/api/translate \
  -H "Content-Type: application/json" \
  -d '{
    "content": {"title": "Hello World"},
    "targetLanguage": "Spanish"
  }'
```

## 🛠️ Service Features

### Translation Service (`src/lib/services/translation.ts`)

**Key Features:**
- **Rate Limiting**: Automatic 1-second delay between requests
- **Error Handling**: Comprehensive error detection and reporting
- **Content Structure**: Preserves original field mapping
- **Context Awareness**: Supports content type and context for better translations
- **Batch Processing**: Handles multiple fields in single request

**Supported Languages:**
- Spanish, French, German, Italian, Portuguese
- Dutch, Russian, Chinese, Japanese
- Arabic, Hindi, Urdu, Finnish

### Error Handling

The service handles various error scenarios:
- **API Key Missing**: `SERVICE_UNAVAILABLE`
- **Rate Limits**: `RATE_LIMIT` with retry guidance
- **Quota Exceeded**: `QUOTA_EXCEEDED`
- **General Errors**: `TRANSLATION_ERROR` with details

## 🔒 Security

- **API Key Protection**: Stored in environment variables only
- **Server-Side Only**: Translation logic runs on server
- **Input Validation**: Content sanitization and validation
- **No Client Exposure**: API key never sent to client

## 📊 Performance

- **Model**: `gpt-4o-mini` (cost-effective, fast)
- **Rate Limiting**: 1 request per second (respects OpenAI limits)
- **Timeout**: 30-second request timeout
- **Retry Logic**: Exponential backoff for failures

## 🔗 Integration Points

### Strapi CMS Integration
Ready for integration with Strapi content localization:
```javascript
import { translationService } from '$lib/services/translation';

// Translate Strapi content
const result = await translationService.translateContent({
  content: {
    heroTitle: 'Welcome to SoloAI',
    heroDescription: 'Transform your business...'
  },
  targetLanguage: 'French',
  contentType: 'landing page',
  context: 'Homepage content for AI SaaS'
});
```

### Future Integrations
- **Mautic Email Translation**: Email campaign localization
- **Paraglide Content**: Dynamic frontend content translation
- **Webhook Integration**: Automatic translation on content publish

## 🚀 Next Steps

1. **Add OpenAI API Key** to `.env` file
2. **Test Translation Service** using web interface
3. **Implement Content Localization Workflow** (AI02-Content-Localization-Workflow.md)
4. **Set up Automated Translation** for Strapi content

## 📝 Development Notes

- Translation service is singleton for consistent rate limiting
- All translations preserve original content structure
- Service automatically detects when OpenAI API is unavailable
- Error responses include specific guidance for resolution
- Ready for production deployment with proper API key configuration