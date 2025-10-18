• Create a comprehensive FAQ/help section for the `/contact` route to reduce support ticket volume and provide self-service customer support

• Position FAQ section below contact form with search functionality and category filtering capabilities

• Implement real-time search that filters FAQ items by question and answer content within 200ms

• Add category filter tabs for "All", "Getting Started", "Billing", "Technical", and "Account Management"

• Use expandable/collapsible FAQ items with DaisyUI collapse component and 300ms animation duration

• Design mobile-first responsive interface with touch-friendly expand/collapse interactions

• Fetch FAQ content from existing Strapi `/api/faqs` endpoint with proper error handling

• Support rich text content in FAQ answers with HTML rendering and XSS protection

• Implement client-side caching with 5-minute TTL for FAQ content

• Create four new Svelte components: ContactFAQ, FAQItem, FAQSearch, and FAQCategoryTabs

• Use existing Strapi FAQ content type with question, answer, category, and priority fields

• Only display FAQ items with published status from Strapi CMS

• Include loading states