-- Create Strapi database
CREATE DATABASE IF NOT EXISTS strapi_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create Strapi user and grant privileges
CREATE USER IF NOT EXISTS 'strapi_db_user'@'%' IDENTIFIED BY 'superSecretUserPwd';
GRANT ALL PRIVILEGES ON strapi_db.* TO 'strapi_db_user'@'%';
FLUSH PRIVILEGES;