• Create a dynamic features preview section on the homepage showcasing 3-5 key product features fetched from Strapi CMS with multilingual support

• Display features in a responsive grid layout: 3-column on desktop, 2-column on tablet, single column on mobile

• Each feature card includes icon/illustration, title, description, and optional CTA with consistent styling using DaisyUI components

• Fetch features from Strapi `/api/features` endpoint with server-side rendering in the homepage's `+page.ts` load function

• Support multilingual content in English, Spanish, and French based on Paraglide locale with English fallback

• Filter and display only published features marked as "homepage" or with highest priority, sorted by priority order

• Implement smooth loading states with skeleton cards and hover effects for enhanced interactivity

• Sanitize all rich text content from Strapi to prevent XSS attacks and validate data structure before rendering

• Ensure WCAG 2.1 AA compliance with proper heading hierarchy and alt text for accessibility

• Meet performance requirements: features load within 2 seconds on 3G connection with image lazy loading

• Position