• Create a dedicated `/terms` route for displaying Terms of Service with clean, readable layout and multilingual support

• Provide publicly accessible route without authentication requirements, supporting direct URL navigation

• Implement clean single-column layout with maximum 800px content width for optimal reading experience

• Include sticky table of contents on desktop for easy navigation between sections

• Ensure mobile-responsive design with proper text sizing and touch-friendly navigation

• Add print-friendly styling for users who need hard copies of terms

• Display last updated date prominently at the top of the document

• Integrate with main layout component for consistent branding and navigation

• Support comprehensive terms covering user agreements, service usage, liability, and dispute resolution

• Include sections for account terms, payment terms, intellectual property, and termination policies

• Implement static terms content as fallback with optional Strapi CMS integration for dynamic content management

• Support multilingual content structure for English, Spanish, and French languages

• Sanitize dynamic content from Strapi to prevent XSS attacks and ensure content integrity

• Meet performance requirements: page load under 2 seconds on 3G, content rendering within 1 second

• Follow same design patterns as