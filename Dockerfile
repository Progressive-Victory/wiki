# Source: https://github.com/offspot/mediawiki-docker/blob/main/Dockerfile

FROM mediawiki:1.39.3

ENV WIKI_DIR /var/www/html

# Install SSH Client
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-client && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

# Install dependencies
RUN apt-get update && apt-get install -y \
    nano \
    git \
    curl \
    wget \
    jq \
    build-essential \
     # for Timeline ext
    fonts-freefont-ttf \
    # ttf-unifont \
    fonts-unifont \
    # Required for Math renderer
    texlive \
    texlive-fonts-recommended \
    texlive-lang-greek \
    texlive-latex-recommended \
    texlive-latex-extra \
    # Ruired for Scribunto
    lua5.1 \
    # Required for SyntaxHighlighting
    python3 \
    # Required for PagedTiffHandler
    exiv2 \
    libtiff-tools \
    # Required for VipsScaler
    libvips-tools \
    && rm -r /var/lib/apt/lists/*

# Install mariadb-client
RUN apt-get update \
    && apt-get install -y mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Install composer, the PHP dependency manager
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --version=2.5.8 --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

COPY ./add-mw-extension.js /usr/local/bin/add-mw-extension
RUN chmod a+x /usr/local/bin/add-mw-extension

COPY ./download-extension.sh /usr/local/bin/download-extension
RUN chmod a+x /usr/local/bin/download-extension

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

COPY ./composer.json $WIKI_DIR/composer.json
RUN chmod a+w $WIKI_DIR/composer.json

ENTRYPOINT ["/docker-entrypoint.sh"]
