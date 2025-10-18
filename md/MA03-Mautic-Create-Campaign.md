# MA03-Mautic-Create-Campaign.md

## IMPORTANT IMPLEMENTATION NOTE
All configuration and setup for Mautic must be performed exclusively through the official Mautic interfaces:
- Mautic Web UI (Admin Dashboard)
- Mautic REST API
- Mautic CLI Tools

Directly injecting code, editing core source files, or programmatically modifying the Mautic application files, configuration files, or database to create or modify entities is STRICTLY PROHIBITED.

This restriction ensures:
- System consistency and database integrity
- Compatibility with future Mautic updates and plugins
- Maintainability and ease of troubleshooting
- Full support for automation, validation, and permissions features

Do NOT create or modify Mautic entities, configurations, or features by editing PHP files, configuration files, or the database directly.
Always use only the Web UI, official REST API, or CLI commands as documented by Mautic.
If actions are required using the UI, ask the user to perform them through the Mautic Admin interface or provide instructions for using the Mautic CLI.

## Overview
- Create and configure a welcome/onboarding email campaign in Mautic using the WYSIWYG builder to engage new users and guide them through initial product setup
- Business value: Automated user onboarding improves activation rates, reduces churn, and provides consistent brand experience
- Feature type: Technical Integration

## Requirements

### For Technical Integrations, include:
- **Service Details**: Mautic 5.0+ campaign builder, email editor, contact segmentation, and automation workflows
- **Authentication**: Uses existing Mautic admin credentials from MA01-Mautic-Container-Setup.md
- **Integration Points**: Connects to contact provisioning from MA05-Mautic-Frontend-Connect.md

### Functional Requirements
- **Campaign Creation**: Design complete welcome email campaign with trigger conditions, email templates, and automation flow
- **Email Content**: Create professional onboarding email using Mautic's WYSIWYG editor with dynamic contact variables
- **Segmentation**: Configure campaign to target "New Signups" segment created in MA05-Mautic-Frontend-Connect.md
- **Automation Flow**: Set up trigger conditions (new contact creation) and follow-up sequences
- **Testing**: Send test emails and verify campaign triggers correctly with new user registrations

### Data Requirements
- **Contact Variables**: Utilize firstName, lastName, email, and registration date from Better Auth integration
- **Campaign Metrics**: Track open rates, click-through rates, and conversion metrics
- **Segmentation Data**: Target contacts in "New Signups" segment with registration date filters

### Security Considerations
- **Email Authentication**: Configure SPF, DKIM, and DMARC records for email deliverability
- **Unsubscribe Management**: Include mandatory unsubscribe links and honor opt-out requests
- **Data Privacy**: Respect GDPR compliance with proper consent management

### Performance Requirements
- **Email Delivery**: Campaign emails must be sent within 5 minutes of trigger conditions
- **Processing Speed**: Campaign workflows must process up to 100 new contacts per hour
- **Deliverability**: Maintain email deliverability rate above 95% with spam score below 5

## Technical Specifications

### Dependencies
- Existing Mautic 5.0+ container from MA01-Mautic-Container-Setup.md
- Mautic API credentials from MA02-Mautic-API-Auth.md
- Contact provisioning integration from MA05-Mautic-Frontend-Connect.md
- SMTP configuration for email delivery

### Database Changes
- No direct database changes required (Mautic handles campaign storage internally)
- Campaign data stored in Mautic's campaign tables
- Email statistics and tracking data automatically generated

### API Changes
- No new API endpoints required
- Uses existing Mautic REST API for campaign management and monitoring
- Webhook endpoints may be configured for campaign event tracking

### Environment Variables
- Uses existing MAUTIC_URL and MAUTIC_API credentials
- Optional: SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASSWORD for email delivery
- EMAIL_FROM_ADDRESS and EMAIL_FROM_NAME for sender identification

## Campaign Configuration Requirements

### Email Template Design
- **Subject Line**: Personalized welcome message with contact's first name
- **Header Section**: Company branding, logo, and welcoming headline
- **Content Sections**: Product introduction, key features overview, and next steps guidance
- **Call-to-Action**: Clear buttons linking to account dashboard, feature tour, or documentation
- **Footer**: Contact information, social media links, and unsubscribe option

### Campaign Automation Flow
- **Trigger**: New contact added to "New Signups" segment
- **Delay**: Send welcome email immediately upon trigger
- **Follow-up**: Optional second email after 7 days for users who haven't logged in
- **Conditions**: Check contact engagement and adjust email frequency accordingly

### Personalization Variables
- Use Mautic's contact field tokens: {contactfield=firstname}, {contactfield=lastname}, {contactfield=email}
- Dynamic content based on registration source or user preferences
- Personalized product recommendations based on signup context

### Testing and Quality Assurance
- **Preview Testing**: Test email rendering across desktop and mobile clients
- **Spam Testing**: Verify spam score and deliverability using Mautic's email testing tools
- **Variable Testing**: Confirm all dynamic variables populate correctly with contact data
- **Automation Testing**: Verify campaign triggers correctly with new contact creation from Better Auth integration

## Integration with Existing System

### Prerequisites
- MA01-Mautic-Container-Setup.md: Mautic container running at localhost:8080
- MA02-Mautic-API-Auth.md: API credentials for programmatic access
- MA05-Mautic-Frontend-Connect.md: Contact provisioning from signup/login flows

### Content Preparation
- Welcome message copy emphasizing product value proposition
- Feature highlights matching content from SP02-Strapi-Content-Type.md
- Clear next steps for user onboarding and account setup
- Brand-consistent design elements and color scheme

### Monitoring and Analytics
- **Campaign Performance**: Track email open rates, click-through rates, and conversion metrics
- **Contact Engagement**: Monitor which users engage with welcome emails and follow-up accordingly
- **A/B Testing**: Optional testing of subject lines, send times, and content variations
- **Integration Health**: Verify contact provisioning continues working correctly with campaign active

## Success Criteria
- Welcome campaign successfully created and published in Mautic interface
- Test emails delivered successfully with proper personalization
- Campaign automatically triggers for new user registrations from Better Auth
- Email templates render correctly across major email clients
- All dynamic variables populate with accurate contact data
- Campaign performance metrics are trackable in Mautic dashboard
- Integration maintains compatibility with existing contact provisioning workflow

## Additional Context for AI Assistant

This feature establishes the foundation for marketing automation by creating the first automated email campaign. The implementation should:

1. **Use Mautic's Interface**: All campaign creation happens through Mautic's web UI at localhost:8080/admin
2. **Build on Contact Integration**: Leverage the contact provisioning already established in MA05-Mautic-Frontend-Connect.md
3. **Prepare for Localization**: Design email content structure that can be easily translated in future AI localization workflows
4. **Maintain Performance**: Ensure campaign doesn't interfere with user registration or authentication flows

The campaign should serve as a template for future marketing automation while providing immediate value through professional user onboarding.