• Build a comprehensive password reset request form component that integrates with Better Auth's password reset functionality for secure password recovery

• Create clean, centered form layout using DaisyUI components with single email input field and proper validation styling

• Implement primary submit button with loading state and disabled state during processing

• Display inline error messages below email field with red DaisyUI error styling and loading indicators

• Design mobile-first responsive layout with proper touch targets (minimum 44px height) and visual hierarchy

• Validate email format using RFC 5322 compliant regex before submission with real-time feedback

• Integrate with Better Auth client methods for password reset request functionality with proper error handling

• Handle form submission with loading states, success feedback, and specific error messages for different failure scenarios

• Ensure full WCAG 2.1 AA compliance with proper labels, ARIA attributes, and keyboard navigation

• Implement input sanitization, CSRF protection, and rate limiting handling for security

• Support email enumeration protection by not revealing whether email exists in system through error messages

• Meet performance requirements: email validation within 100ms, API response within 3 seconds, visual feedback within 200ms

• Integrate