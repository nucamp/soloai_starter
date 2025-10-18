• Create a reusable main layout component with header, navigation, footer, and content slot for the SvelteKit SaaS application
• Establish consistent visual structure and navigation patterns across all pages
• Integrate with existing Tailwind CSS styling, Paraglide i18n, Better Auth session management, and Strapi CMS content
• Header section includes logo/brand, main navigation menu, language switcher, and authentication status/buttons
• Navigation menu links to all core public pages (/, /features, /pricing, /contact, /privacy, /terms)
• Authentication area displays login/signup buttons for guests or user menu for authenticated users
• Language switcher provides dropdown for switching between English, Spanish, and French
• Content area uses main slot for page-specific content with proper spacing and constraints
• Footer section contains links, copyright, social media, and legal pages
• Responsive design with mobile-first approach and hamburger menu for smaller screens
• Create `src/routes/+layout.svelte` as main layout component with separate Header, Navigation, Footer, LanguageSwitcher, and AuthButton components
• Integration with Better Auth client for session management and user authentication status