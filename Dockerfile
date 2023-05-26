# Source: https://github.com/offspot/mediawiki-docker/blob/main/Dockerfile

FROM mediawiki:latest

ENV WIKI_DIR /var/www/html

# Install mariadb-client and curl
RUN apt-get update \
    && apt-get install -y mariadb-client curl \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

# Install dependencies
RUN apt-get update && apt-get install -y \
    nano \
    git \
    build-essential \
     # for Timeline ext
    fonts-freefont-ttf \
    ttf-unifont \
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
    # Requuired for VipsScaler
    libvips-tools \
    && rm -r /var/lib/apt/lists/*

COPY ./add-mw-extension.js /usr/local/bin/add-mw-extension
RUN chmod a+x /usr/local/bin/add-mw-extension

COPY ./download-extension.sh /usr/local/bin/download-extension
RUN chmod a+x /usr/local/bin/download-extension

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
