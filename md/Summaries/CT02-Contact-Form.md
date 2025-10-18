• Create a comprehensive contact form component for the `/contact` route with proper validation, error handling, and authentication integration

• Implement user stories for guest users to submit inquiries and authenticated users to have pre-populated form fields

• Design clean, single-column form layout using DaisyUI components with Name, Email, Subject, and Message fields

• Implement mobile-first responsive design with minimum 44px touch targets and real-time validation feedback

• Integrate with Better Auth to pre-populate name and email fields for authenticated users using session data

• Add client-side validation for required fields, RFC 5322 compliant email format, and message length (10-2000 characters)

• Process form submissions through SvelteKit server action with proper error handling and email delivery

• Implement CSRF protection and rate limiting (maximum 3 submissions per IP address per hour)

• Sanitize all user input to prevent XSS attacks and injection vulnerabilities

• Store submission timestamp, IP address (hashed), and user ID if authenticated without database persistence

• Send form submissions directly via email using existing Better Auth email provider configuration

• Create form validation rules: Name (2-100 chars),