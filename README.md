# mediawiki-nginx-docker

## Setup

1. `mkdir certs && openssl req -x509 -newkey rsa:4096 -keyout nginx/certs/key.pem -out nginx/certs/cert.pem -days 365 -nodes -subj '/CN=localhost'`

## Run

1. Make sure `./LocalSettings.php` is commented out in the `docker-compose.yml` file
2. Run `docker-compose up -d`
3. Visit `https://localhost/`
4. Follow the instructions to install MediaWiki
5. Uncomment `./LocalSettings.php` in the `docker-compose.yml` file
