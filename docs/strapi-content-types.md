# Strapi Content Types

This document defines the content type structures used in Strapi CMS for the SoloAI marketing website.

## Content Types Overview

- **Landing Page** (`landing-page`) - For homepage and marketing pages
- **Feature** (`feature`) - For product feature descriptions
- **FAQ** (`faq`) - For frequently asked questions and support content

## Landing Page Content Type

**Collection Name:** `landing-page`  
**API Endpoint:** `/api/landing-pages`

### Fields

| Field Name | Type | Required | Constraints | Description |
|------------|------|----------|-------------|-------------|
| `pageIdentifier` | Text (Short) | Yes | Unique | Unique slug (e.g., homepage, about) |
| `heroTitle` | Text (Short) | Yes | Max: 200 chars | Main hero section title |
| `heroSubtitle` | Text (Short) | No | Max: 200 chars | Hero section subtitle |
| `heroDescription` | Text (Long) | No | - | Hero section description |
| `heroCtaText` | Text (Short) | No | - | Call-to-action button text |
| `heroMedia` | Media (Single) | No | Images, Videos | Hero section media asset |
| `metaTitle` | Text (Short) | No | Max: 160 chars | SEO meta title |
| `metaDescription` | Text (Long) | No | Max: 160 chars | SEO meta description |
| `ogTitle` | Text (Short) | No | - | Open Graph title |
| `ogDescription` | Text (Long) | No | - | Open Graph description |
| `contentSections` | Rich Text | No | Markdown, HTML | Flexible content blocks |

### Settings
- Draft & Publish: Enabled
- Internationalization: Enabled

## Feature Content Type

**Collection Name:** `feature`  
**API Endpoint:** `/api/features`

### Fields

| Field Name | Type | Required | Constraints | Description |
|------------|------|----------|-------------|-------------|
| `name` | Text (Short) | Yes | Max: 200 chars | Feature name |
| `slug` | UID | Yes | Unique, Target: name | URL-friendly identifier |
| `shortDescription` | Text (Long) | Yes | - | Brief feature description |
| `longDescription` | Rich Text | No | Markdown, HTML | Detailed feature description |
| `icon` | Media (Single) | No | Images only | Feature icon |
| `featureImage` | Media (Single) | No | Images only | Feature showcase image |
| `category` | Enumeration | No | See values below | Feature category |
| `priority` | Number (Integer) | No | Default: 0 | Display order priority |
| `benefits` | Component (Repeatable) | No | - | List of feature benefits |
| `ctaText` | Text (Short) | No | - | Call-to-action text |
| `ctaLink` | Text (Short) | No | - | Call-to-action URL |

### Category Values
- Core Features
- Advanced Features
- Integrations
- Security

### Benefits Component (`feature.benefit`)
| Field Name | Type | Required | Description |
|------------|------|----------|-------------|
| `benefitText` | Text (Long) | No | Individual benefit description |

### Settings
- Draft & Publish: Enabled
- Internationalization: Enabled

## FAQ Content Type

**Collection Name:** `faq`  
**API Endpoint:** `/api/faqs`

### Fields

| Field Name | Type | Required | Constraints | Description |
|------------|------|----------|-------------|-------------|
| `question` | Text (Long) | Yes | - | FAQ question |
| `answer` | Rich Text | Yes | Markdown, HTML | FAQ answer |
| `category` | Enumeration | Yes | See values below | FAQ category |
| `order` | Number (Integer) | No | Default: 0 | Display order within category |
| `helpfulnessScore` | Number (Integer) | No | Default: 0 | User helpfulness rating |
| `voteCount` | Number (Integer) | No | Default: 0 | Total votes received |
| `relatedLinks` | JSON | No | - | Array of related documentation links |

### Category Values
- Billing
- Account
- Technical
- General
- Security

### Settings
- Draft & Publish: Enabled
- Internationalization: Enabled

## API Response Examples

### Landing Page Response
```json
{
  "data": {
    "id": 1,
    "attributes": {
      "pageIdentifier": "homepage",
      "heroTitle": "Welcome to SoloAI",
      "heroSubtitle": "AI-Powered Solutions",
      "heroDescription": "Transform your business...",
      "heroCtaText": "Get Started",
      "heroMedia": {
        "data": {
          "id": 1,
          "attributes": {
            "url": "/uploads/hero-image.jpg"
          }
        }
      },
      "metaTitle": "SoloAI - AI Solutions",
      "contentSections": "<h2>Features</h2><p>...</p>",
      "locale": "en",
      "publishedAt": "2024-01-01T00:00:00Z"
    }
  }
}
```

### Feature Response
```json
{
  "data": {
    "id": 1,
    "attributes": {
      "name": "AI Content Generation",
      "slug": "ai-content-generation",
      "shortDescription": "Generate content with AI",
      "longDescription": "<p>Detailed description...</p>",
      "category": "Core Features",
      "priority": 1,
      "benefits": [
        {
          "id": 1,
          "benefitText": "Save 80% of content creation time"
        }
      ],
      "ctaText": "Learn More",
      "ctaLink": "/features/ai-content-generation",
      "locale": "en",
      "publishedAt": "2024-01-01T00:00:00Z"
    }
  }
}
```

### FAQ Response
```json
{
  "data": {
    "id": 1,
    "attributes": {
      "question": "How do I reset my password?",
      "answer": "<p>To reset your password...</p>",
      "category": "Account",
      "order": 1,
      "helpfulnessScore": 45,
      "voteCount": 50,
      "relatedLinks": [
        {
          "title": "Account Security Guide",
          "url": "/docs/security"
        }
      ],
      "locale": "en",
      "publishedAt": "2024-01-01T00:00:00Z"
    }
  }
}
```

## Naming Conventions

- **Collection Names**: kebab-case (e.g., `landing-page`)
- **Field Names**: camelCase (e.g., `heroTitle`)
- **API Endpoints**: kebab-case plural (e.g., `/api/landing-pages`)
- **Component Names**: dot notation (e.g., `feature.benefit`)

## Media Upload Constraints

- **Images**: JPG, PNG, WebP (max 5MB)
- **Videos**: MP4, WebM (for hero media only)
- **Icons**: SVG, PNG (preferably square aspect ratio)

## Localization

All content types support internationalization through Strapi's i18n plugin. Available locales will be configured based on the Paraglide.js setup:
- en, es, fr, hi, pt, de, it, ur, fi, ar, ru, ja, zh

## Integration Notes

- Content will be consumed by SvelteKit frontend via Strapi REST API
- Authentication will be handled via API tokens (configured separately)
- AI translation workflow will process content through these endpoints
- Rich text fields support both Markdown and HTML for flexible content authoring