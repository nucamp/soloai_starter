• Scaffold core SvelteKit application routes using file-based routing conventions to establish fundamental navigation structure
• Create 11 core routes including public pages (/, /features, /pricing, /contact, /privacy, /terms) and auth-required routes (/login, /signup, /account, /forgot-password)
• Each route must have corresponding `+page.svelte` file with placeholder content and unique page identification
• Routes must be accessible via direct URL navigation and support browser back/forward buttons
• All routes must return proper HTTP status codes (200 for existing, 404 for missing pages)
• Implement consistent route hierarchy and organization following SvelteKit best practices
• Structure routes to support future dynamic content integration from Strapi CMS
• File organization must accommodate future internationalization with Paraglide
• Route structure must support nested layouts and authentication guards implementation
• Each page component requires unique title in `<svelte:head>`, semantic HTML structure, and TypeScript support
• Separate public marketing routes from authenticated user areas in file organization
• Routes must support future authentication middleware and CSRF protection implementation
• Initial page load must complete within 2 seconds on 3