• Display current subscription status on pricing tier cards for authenticated users, showing "Current Plan" button for active tier
• Show "Upgrade" or "Downgrade" buttons for other tiers based on user's current subscription level
• Hide or modify Free tier display for users with active paid subscriptions
• Show comprehensive subscription overview in account dashboard including tier name, status, billing date, and payment method
• Display subscription status (active, past_due, canceled, trialing) with next billing date and amount
• Include subscription start date and trial period information in dashboard display
• Reflect subscription changes immediately after successful Stripe operations through real-time updates
• Update UI when webhook events modify subscription status without requiring page refresh
• Handle loading states during subscription data fetching with skeleton components
• Provide error states for failed subscription data retrieval with retry options
• Enable subscription cancellation with confirmation dialog through UI
• Support subscription reactivation for canceled subscriptions
• Allow subscription tier changes (upgrade/downgrade) through existing checkout flow
• Provide access to Stripe Customer Portal for advanced billing management
• Utilize existing user subscription fields: stripe_customer_id, subscription_status, subscription_tier, subscription_en