# mediawiki-nginx-docker

## Setup

1. `mkdir certs && openssl req -x509 -newkey rsa:4096 -keyout nginx/certs/key.pem -out nginx/certs/cert.pem -days 365 -nodes -subj '/CN=localhost'`

## Run

1. `docker-compose up -d`
