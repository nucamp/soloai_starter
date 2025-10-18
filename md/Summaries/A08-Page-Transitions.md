• Add simple page transitions between routes to enhance user experience with smooth navigation animations

• Implement subtle fade or slide transitions with 200-300ms duration for optimal perceived performance

• Respect `prefers-reduced-motion` accessibility setting for users who prefer minimal animations

• Ensure transitions perform smoothly on mobile devices at 60fps

• Support smooth transitions between all major routes (/, /features, /pricing, /contact, /account, etc.)

• Implement different transition styles for public vs protected routes

• Coordinate transitions with existing loading states from Strapi content fetching

• Maintain proper focus management during transitions for keyboard navigation accessibility

• Use existing dependencies: SvelteKit routing, Tailwind CSS, DaisyUI components

• Consider optional integration with motion libraries like `framer-motion` or `svelte/motion`

• No new database tables or API endpoints required

• Cache transition preferences in localStorage for user customization

• Ensure transitions don't expose sensitive information during route changes

• Transition animations must run at 60fps and not exceed 300ms total time

• Integrate with existing route structure, layout component, and navigation menu

• Coordinate with Better Auth for