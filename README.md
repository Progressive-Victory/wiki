# mediawiki-nginx-docker

## Setup

1. `mkdir certs && openssl req -x509 -newkey rsa:4096 -keyout certs/key.pem -out certs/cert.pem -days 365 -nodes -subj '/CN=localhost'`
