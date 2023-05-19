# Progressive Victory Wiki

## Setup

1. Run `mkdir certs && openssl req -x509 -newkey rsa:4096 -keyout nginx/certs/key.pem -out nginx/certs/cert.pem -days 365 -nodes -subj '/CN=localhost'`
2. Comment out `LocalSettings.php` in the compose file
3. Run `cp .env.example .env`
4. Run `docker-compose up -d`
5. Visit `https://localhost` and follow the setup instructions
6. Make sure the installation process references Wikimedia 3.9
7. You should install all of the extensions to match the `LocalSettings.php` file provided
8. Match the `.env` variables during setup, such as `db` for the host - the provided `LocalSettings.php` will read those

## Run

* Run `docker-compose up -d`

## Troubleshooting

* If you see an error such as `Warning: session_name(): Cannot change session name when headers already sent in`, this means `LocalSettings.php` has a typo somewhere. Try undoing your last change.

## Making Changes

* If you want to make changes, edit `ExtraLocalSettings.php`.

## Environments

* The dev environment you can visit on [http://137.184.42.110:81](http://137.184.42.110:81) - It would be nice to have this deployed on the proper domain or Vercel but we would have to figure out how to run the maintenance scripts properly.
* The prod environment you can visit on [https://wiki.progressivevictory.win](https://wiki.progressivevictory.win).

When you deploy to the `main` branch, it will automatically deploy to the dev environment. Similarly, when you deploy to the `prod` branch, it will automatically deploy to the prod environment.
