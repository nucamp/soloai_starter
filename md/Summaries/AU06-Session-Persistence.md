• Implement automatic session persistence and synchronization for Better Auth client to maintain authentication state across page reloads, browser tabs, and network interruptions

• Automatically fetch and initialize session state when the application starts

• Sync authentication state across multiple browser tabs and windows in real-time using BroadcastChannel API

• Automatically refresh expired sessions without user interaction when possible

• Handle network interruptions gracefully and restore session state when connectivity returns

• Trigger reactive updates throughout the application immediately when session changes occur

• Propagate logout actions across all open tabs and trigger appropriate redirects

• Build upon existing Better Auth client configuration from AU04-Global-Client-Setup.md

• Integrate seamlessly with route protection middleware to prevent authentication flashing

• Create reactive Svelte stores for session state that update automatically

• Prevent unauthenticated content from briefly appearing to logged-in users

• Show appropriate loading indicators during session initialization and refresh operations

• Session initialization must complete within 100ms on application start

• Cross-tab synchronization must propagate within 50ms

• Never expose JWT tokens in client-side JavaScript or local storage for security

• Regularly validate session authenticity with server an