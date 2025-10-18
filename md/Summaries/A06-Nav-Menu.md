• Create a comprehensive navigation menu component that integrates with existing layout system, authentication state, and internationalization

• Guest users see navigation links to public pages (Features, Pricing, Contact) plus Login and Signup buttons

• Authenticated users see account status, logout option, and access to protected pages like Account

• Mobile users get a hamburger menu with full-screen or slide-out navigation panel

• Desktop navigation features horizontal navbar with logo on left, main links in center, auth actions on right

• Responsive breakpoints: Desktop (1024px+), Tablet (768px-1023px), Mobile (<768px)

• Navigation structure includes public pages, authentication pages for guests, protected pages for authenticated users

• Integrate Better Auth client for session detection and dynamic rendering based on user login state

• Use Paraglide i18n for language switcher and translated navigation labels in English, Spanish, and French

• Include current page indication with visual highlighting of active navigation items

• Implement mobile-first design with minimum 44px touch targets and smooth CSS transitions

• Performance requirements: <200ms initial render, <100ms auth check, <300ms menu animations, max 5KB bundle size