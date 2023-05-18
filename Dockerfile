FROM mediawiki:latest

# Install mariadb-client
RUN apt-get update \
    && apt-get install -y mariadb-client \
    && rm -rf /var/lib/apt/lists/*
