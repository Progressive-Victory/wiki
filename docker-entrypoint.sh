#!/bin/bash

# Wait for MySQL to be ready
until mysqladmin ping -hdb -uroot -p${DB_PASSWORD:-root} --silent; do
    echo "Waiting for MySQL to be ready..."
    sleep 2
done

# Set ownership and permissions for LocalSettings.php
chown www-data:www-data /var/www/html/LocalSettings.php
chmod 644 /var/www/html/LocalSettings.php

# Run the original entrypoint command
docker-php-entrypoint "$@"
