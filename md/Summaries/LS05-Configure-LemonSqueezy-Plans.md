• Configure three subscription tiers (Free, Pro, Enterprise) in LemonSqueezy dashboard matching existing pricing structure
• Set up monthly and annual billing options for paid tiers with proper currency and tax settings
• Add structured metadata for application integration and feature mapping
• Use sandbox/test mode for development and staging environments
• Ensure product IDs are accessible for checkout session creation
• Configure VAT handling and regional pricing for international customers
• Free Tier: $0.00 with metadata including tier_id "free", max_users "1", features "basic"
• Pro Tier: $29.00 monthly/$290.00 annual with metadata including tier_id "pro", max_users "10", features "advanced"
• Enterprise Tier: $99.00 monthly/$990.00 annual with metadata including tier_id "enterprise", max_users "unlimited", features "premium"
• Maintain consistent tier_id, max_users, features, trial_period fields for application mapping
• Generate unique identifiers for each plan that can be referenced in checkout API calls
• Never expose LemonSqueezy API keys in client-side code
• Validate product I