# Progressive Victory Wiki

## Installation

1. Install and run [Docker](https://docs.docker.com/desktop/install/windows-install/)
2. Install [yarn](https://classic.yarnpkg.com/en/docs/install/#windows-stable)

## Setup

1. Run `mkdir -p certs && openssl req -x509 -newkey rsa:4096 -keyout ./nginx/certs/key.pem -out ./nginx/certs/cert.pem -days 365 -nodes -subj '/CN=localhost'`
2. Comment out `LocalSettings.php` in the compose file
3. Run `cp .env.example .env`
4. Run `yarn start`
5. Visit `https://localhost` and follow the setup instructions
6. Make sure the installation process references Wikimedia 3.9
7. You should install all of the extensions to match the `LocalSettings.php` file provided
8. Match the `.env` variables during setup, such as `db` for the host - the provided `LocalSettings.php` will read those

## Run

* Run `docker-compose up -d`

## Troubleshooting

* If you see an error such as `Warning: session_name(): Cannot change session name when headers already sent in`, this means `LocalSettings.php` has a typo somewhere. Try undoing your last change.
* You can view installed extensions by visiting [https://localhost/index.php/Special:Version](https://localhost/index.php/Special:Version).

## Making Changes

* If you want to make changes, edit `ExtraLocalSettings.php`.
* To restart, run `yarn restart`.

## Environments

* The environments exist, they just aren't public yet.

When you deploy to the `main` branch, it will automatically deploy to the dev environment. Similarly, when you deploy to the `prod` branch, it will automatically deploy to the prod environment.
