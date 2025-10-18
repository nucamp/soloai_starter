• Configure Mautic webhooks to automate marketing campaign triggers and enable real-time event processing for user actions like signup, subscription changes, and engagement activities

• Handle incoming webhook events from Mautic including contact updates, campaign interactions, email opens/clicks, and form submissions

• Send webhook notifications to Mautic when users perform key actions (signup, subscription change, profile update, login activity)

• Verify webhook authenticity using signature validation and prevent duplicate event processing using idempotency keys

• Process webhook events within 30 seconds and update user records or trigger automated campaigns accordingly

• Automatically trigger welcome campaigns, subscription tier-specific emails, and re-engagement sequences based on user actions

• Integrate with existing Mautic API authentication, Better Auth system, and Stripe/LemonSqueezy subscription events

• Create webhook_events table to store incoming webhook events with fields for event_id, event_type, payload, processed_at, status, user_id, campaign_id, error_message

• Create user_activity_log table to track user actions that should trigger Mautic webhooks including signup, login, subscription_change, profile_update, feature_