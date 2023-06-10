# Progressive Victory Wiki

## Installation

1. Install and run [Docker](https://docs.docker.com/desktop/install/windows-install/)
2. Install [yarn](https://classic.yarnpkg.com/en/docs/install/#windows-stable)

## Setup

1. Run `mkdir -p certs && openssl req -x509 -newkey rsa:4096 -keyout ./nginx/certs/key.pem -out ./nginx/certs/cert.pem -days 365 -nodes -subj '/CN=localhost'`
2. Comment out `LocalSettings.php` in the docker-compose.yml file
3. Run `cp .env.example .env`
4. Run `yarn start`
5. Visit `https://localhost` and follow the setup instructions
6. Make sure the installation process references Wikimedia 3.9. Also you can tick to install all of the extensions if you want.
7. When going through the Mediawiki setup, it will ask you for a bunch of settings. For example, when it asks about connecting to the database, use `db` for the host. This is just to go through the setup and connect to the database so the install wizard can run the required setup commands. Afterwards, the provided `LocalSettings.php` file will read from the environment variables automatically. Do not use the one they give you.
8. Undo the comment in docker-compose.yml, so `LocalSettings.php` will not be commented out
9. Run `yarn restart`
10. Visit `https://localhost`, you should now see the "Main Page" of the wiki

## Run

* Run `yarn start`

## Troubleshooting

* If you see an error such as `Warning: session_name(): Cannot change session name when headers already sent in`, this means `LocalSettings.php` has a typo somewhere. Try undoing your last change.
* You can view installed extensions by visiting [https://localhost/index.php/Special:Version](https://localhost/index.php/Special:Version).
* If you see an error along the lines of `exec /docker-entrypoint.sh: no such file or directory`, you need to change the line ending in the docker-compose.yml file to be `LF`.

## Making Changes

* If you want to make changes, edit `ExtraLocalSettings.php`.
* To restart, run `yarn restart`.

## Environments

* The environments exist, they just aren't public yet.

When you deploy to the `main` branch, it will automatically deploy to the dev environment. Similarly, when you deploy to the `prod` branch, it will automatically deploy to the prod environment.
