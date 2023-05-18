#!/bin/sh

# Wait for the database to be ready
sleep 10

# Set ownership and permissions for LocalSettings.php
chown www-data:www-data /var/www/html/LocalSettings.php
chmod 644 /var/www/html/LocalSettings.php

# Output specific environment variables
echo "DB_SERVER: $DB_SERVER"
echo "DB_NAME: $DB_NAME"
echo "DB_PORT: $DB_PORT"
echo "DB_USER: $DB_USER"
echo "DB_PASSWORD: $DB_PASSWORD"
echo "MW_ADMIN_PASSWORD: $MW_ADMIN_PASSWORD"
echo "MW_SITE_SERVER: $MW_SITE_SERVER"
echo "MW_SITE_NAME: $MW_SITE_NAME"
echo "MW_ADMIN_USERNAME: $MW_ADMIN_USERNAME"
echo "----------------------"

# Run the MediaWiki installation script
php maintenance/install.php \
  --dbtype postgres \
  --dbserver "$DB_SERVER" \
  --dbname "$DB_NAME" \
  --dbport "$DB_PORT" \
  --dbuser "$DB_USER" \
  --dbpass "$DB_PASSWORD" \
  --installdbpass "$DB_PASSWORD" \
  --pass "$MW_ADMIN_PASSWORD" \
  --scriptpath "" \
  --server "$MW_SITE_SERVER" \
  --with-extensions \
  "$MW_SITE_NAME" \
  "$MW_ADMIN_USERNAME"

echo "Finished installing MediaWiki"

# Run the database update script
php maintenance/update.php --quick

echo "Finished updating MediaWiki"

# Run the original entrypoint command
docker-php-entrypoint "$@"
