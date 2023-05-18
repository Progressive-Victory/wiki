# mediawiki-nginx-docker

## Setup

1. `mkdir certs && openssl req -x509 -newkey rsa:4096 -keyout nginx/certs/key.pem -out nginx/certs/cert.pem -days 365 -nodes -subj '/CN=localhost'`

## Run

1. Comment out `LocalSettings.php` in the compose file
2. Run `docker-compose up -d`
3. Visit `https://localhost` and follow the setup instructions.
3.a. Make sure the installation process references Wikimedia 3.9.
3.b. You should install all of the extensions to match the `LocalSettings.php` file provided.
3.c. Match the `.env` variables during setup, such as `db` for the host - the provided `LocalSettings.php` will read those.

## Troubleshooting

* If you see an error such as `Warning: session_name(): Cannot change session name when headers already sent in`, this means `LocalSettings.php` has a typo somewhere. Try undoing your last change.

## Making Changes

* If you want to make changes, edit `ExtraLocalSettings.php`.
