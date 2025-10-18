• Deploy Mautic 5.0+ as Docker container service accessible at http://localhost:8080
• Connect to existing MySQL database from DB01-DB-Container-Setup.md using dedicated database and user
• Create initial admin user account for marketing campaign management and configuration
• Implement persistent storage for configuration, media uploads, and plugin data across container restarts
• Set up container health checks and auto-restart policies for reliability
• Ensure Mautic API endpoints are accessible for future user provisioning and campaign automation
• Create dedicated `mautic` database in existing MySQL container with UTF8MB4 encoding
• Create `mautic_user` with appropriate database permissions (SELECT, INSERT, UPDATE, DELETE)
• Mount volumes for media files, images, and application configuration directories
• Use mautic/mautic:v5-apache official Docker image with Apache 2.4+ and PHP 8.1+
• Configure environment variables for database connection, admin credentials, and secret key
• Set up port mapping 8080:80 for HTTP access to Mautic interface
• Allocate minimum 1GB RAM with 2GB recommended for marketing automation