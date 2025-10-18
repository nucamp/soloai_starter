• Create a prominent call-to-action section on the homepage to drive user acquisition and conversions
• Display different content based on authentication status - signup CTA for guests, dashboard access for authenticated users
• Position as full-width section after features preview with centered content container (max-width 1200px)
• Implement responsive design: horizontal layout on desktop, centered single column on tablet, stacked layout on mobile
• Use DaisyUI `btn-primary` class for buttons with minimum 44px touch target and sufficient contrast
• Integrate Better Auth client to check authentication status and show appropriate CTA buttons
• Support multilingual content using Paraglide i18n for English, Spanish, and French locales
• Fetch dynamic content from Strapi CMS including headline, description, and button text
• Guest users see "Get Started Free" button linking to `/signup` page
• Authenticated users see "Go to Dashboard" button linking to `/account` page
• Extend Strapi Landing Page content type with CTA fields: headline, description, button text, and optional secondary text
• Implement content fallback to show default English content if translation unavailable
• Ensure section