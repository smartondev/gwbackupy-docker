# Docker image for [gwbackupy](https://github.com/smartondev/gwbackupy)

This docker container runs scheduled backups of one or more Gmail accounts, including full and fast backups.
The backup process is based on the open-source software [gwbackupy](https://github.com/smartondev/gwbackupy).

**Under development**

## Overview

## OAuth challenge

If docker host with desktop UI:

```
container PORT -> docker -> host PORT -> browser -> redirect --\
                                                               |
container PORT <- docker <- host PORT <------------------------/
```

If docker host is in terminal only context:

```
container PORT -> docker -> host PORT -> public or local network IP -> wait for operator
                                                                          -> operator -> open link in browser -> redirect --\
                                                                                                                            |
container PORT <- docker <- host PORT <- public or local network IP <-------------------------------------------------------/
```

Port, bind host, redirect host are set with `GWBACKUPY_OAUTH_PORT`, `GWBACKUPY_OAUTH_BIND_ADDRESS`
and `GWBACKUPY_OAUTH_REDIRECT_HOST` environment variables.

If the redirect host is a hostname, it must be a public hostname and must be added to the OAuth configuration.

## Environment variables

| Env name                                 | Default value                              | Description                                                                                                       |
|------------------------------------------|--------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| `GWBACKUPY_WORKDIR`                      | `/data`                                    | Data directory, see more `--workdir` parameter                                                                    |
| `GWBACKUPY_APPDIR`                       | `/app`                                     |                                                                                                                   |
| `GWBACKUPY_ACCOUNT_EMAILS`               | `example@example.com example2@example.com` | Email accounts, space separated list                                                                              |
| `GWBACKUPY_CRON_FULL_SYNC`               | `0 0 * * 0`                                | Cron's pattern to full backup. If empty, it will be turned off. By default, it runs every Monday at 0 AM.         |
| `GWBACKUPY_CRON_QUICK_SYNC`              | `0 */12 * * *`                             | Cron's pattern to quick backup. If empty, it will be turned off. By default, it runs every day at 0 and 12 hours. |
| `GWBACKUPY_CRON_LOG`                     | `${GWBACKUPY_WORKDIR}/logs/crontab.log`    |                                                                                                                   |
| `GWBACKUPY_CRONTAB`                      | `${GWBACKUPY_APPDIR}/crontab`              |                                                                                                                   |
| `GWBACKUPY_CRON_FLOCK_FILEPATH`          | `/var/lock/gwbackupy-cron.lock`            | Filepath of cron's `flock`                                                                                        |
| `GWBACKUPY_LOG_LEVEL`                    | `warning`                                  | see more `--log-level` parameter                                                                                  |
| `GWBACKUPY_CREDENTIALS_FILEPATH`         | ` `                                        |                                                                                                                   |
| `GWBACKUPY_SERVICE_ACCOUNT_KEY_FILEPATH` | ` `                                        |                                                                                                                   |
| `GWBACKUPY_MAIN_ARGS`                    | ` `                                        |                                                                                                                   |
| `GWBACKUPY_SERVICES`                     | `gmail`                                    | Services for backup, currently `gmail` only                                                                       |
| `GWBACKUPY_OAUTH_REDIRECT_HOST`          | `localhost`                                |                                                                                                                   |
| `GWBACKUPY_OAUTH_PORT`                   | `43339`                                    |                                                                                                                   |
| `GWBACKUPY_OAUTH_BIND_ADDRESS`           | `0.0.0.0`                                  |                                                                                                                   |
| `GWBACKUPY_QUICK_SYNC_DAYS`              | `7`                                        |                                                                                                                   |
| `TZ`                                     | ` `                                        | timezone settings from alpine docker                                                                              |

The full and quick backup do not run simultaneously.
If a quick backup is already running, a new instance of the quick backup will not be started.
The full backup will wait for the currently running process to finish and then start.

## Arguments

It is possible to specify the name/location and version of the gwbackupy download during the build by passing arguments.

| Env name                | Default value | Description                                                                                                                                            |
|-------------------------|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| `GWBACKUPY_PIP_VERSION` | ` `           | The version of gwbackupy for installation (default is latest version by pip). The version specification should be understood according to pip install. |
| `GWBACKUPY_PIP_PACKAGE` | `gwbackupy`   | The package name of gwbackupy for installation. Either the pip package name or direct zip access can be specified, see pip.                            |

For build a specific version of gwbackupy use this argument:

- `GWBACKUPY_PIP_VERSION="~=0.10"`

```bash
docker build --build-arg GWBACKUPY_PIP_VERSION="~=0.10" -t gwbackupy-v0-10 ./
```

For build image with dev master (main) use this argument:

- `GWBACKUPY_PIP_PACKAGE="https://github.com/smartondev/gwbackupy/archive/main.zip"`

```bash
docker build --build-arg GWBACKUPY_PIP_PACKAGE="https://github.com/smartondev/gwbackupy/archive/main.zip" -t gwbackupy-devmaster ./
```

*Please note that the given docker image may not be compatible with all versions of gwbackupy.*

## Scripts

- `entrypoint.sh`: check authentication status, and if is ok, then starts crond (default script) and schedule
  full and quick backups
- `quick-sync.sh`: script for start quick backup
- `sync.sh`: script for start full backup
- `access-init.sh`: script for start initialize authentication (use first time and if auth changes)
  ```bash
  docker ... -it exec /bin/bash access-init.sh
  ```
- `access-check.sh`: script for authentication states checking
    - `access-check.sh <email(s)>`: run checks for email addresses
    - `access-check.sh <email(s)> <service(s)>`: run checks for specified services and email addresses

Run gwbackupy with custom parameters (e.g. restore):

```bash
docker ... -it exec python -m gwbackupy ...
```

## Security

See [SECURITY.md](SECURITY.md)

## Contributing

Welcome! I am happy that you want to make the project better.

Currently, there is no developed documentation for the process, in the meantime, please use issues and pull requests.

## Changelog

The changes are contained in [CHANGELOG.md](CHANGELOG.md).

## About

[Márton Somogyi](https://github.com/Kamarton)
