• Create a compelling hero section for the homepage that dynamically renders content from Strapi CMS with multilingual support

• Serves as the primary conversion element with headline, subtext, and call-to-action button to drive user engagement and signups

• Full-width section with centered content, maximum 1200px container width and visual hierarchy with large headlines

• Responsive behavior: desktop two-column layout, tablet single column, mobile stacked layout with optimized typography

• Authentication-aware CTA showing "Get Started" for guests and "Go to Dashboard" for authenticated users

• Dynamic content rendering from Strapi `/api/landing-pages` endpoint with multilingual support for English/Spanish/French

• Content fallback system displays default content if Strapi CMS is unavailable or returns errors

• Rich text support with content sanitization to prevent XSS attacks

• Hero section must render within 2 seconds on 3G connection with content updates when language changes

• Required Strapi fields: heroHeadline (50-60 chars), heroSubheadline (100-120 chars), heroCta text, and optional heroImage

• Content must exist in English (