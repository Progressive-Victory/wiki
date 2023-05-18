FROM php:7.4-fpm

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    libpq-dev \
    libzip-dev \
    unzip \
    curl \
    libicu-dev \
    pkg-config \
    libssl-dev \
    git

# Install PHP extensions
RUN docker-php-ext-install \
    pdo_pgsql \
    pgsql \
    zip \
    calendar

# Install intl and other PECL extensions
RUN pecl install intl \
    && docker-php-ext-enable intl

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Get MediaWiki
WORKDIR /var/www/html
RUN curl https://releases.wikimedia.org/mediawiki/1.39/mediawiki-1.39.4.tar.gz | tar xz && \
    mv mediawiki-1.39.4/* . && \
    rm -rf mediawiki-1.39.4

# Install MediaWiki with Composer
RUN composer install --no-dev

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
