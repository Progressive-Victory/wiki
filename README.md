# mediawiki-nginx-docker

## Setup

1. `mkdir certs && openssl req -x509 -newkey rsa:4096 -keyout nginx/certs/key.pem -out nginx/certs/cert.pem -days 365 -nodes -subj '/CN=localhost'`

## Run

1. Comment out `LocalSettings.php` in the compose file
2. Run `docker-compose up -d`
3. Visit `https://localhost` and follow the setup instructions.
3.a. You should install all of the extenstions to match the `LocalSettings.php` file provided.
3.b. Match the `.env` variables, such as `db` for the host.
