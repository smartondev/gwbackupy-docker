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
container PORT -> docker -> host PORT -> public or local network IP -> wait
                                                                        -> open link in browser -> redirect --\
                                                                                                              |
container PORT <- docker <- host PORT <- public or local network IP <-----------------------------------------/
```

Port, bind host, redirect host are set with `GWBACKUPY_OAUTH_PORT`, `GWBACKUPY_OAUTH_BIND_ADDRESS` 
and `GWBACKUPY_OAUTH_REDIRECT_HOST` environment variables.

If the redirect host is a hostname, it must be a public hostname and must be added to the OAuth configuration.

## Container environment parameters

| Env name                                 | Default value                              | Description                                    |
|------------------------------------------|--------------------------------------------|------------------------------------------------|
| `GWBACKUPY_WORKDIR`                      | `/data`                                    | Data directory, see more `--workdir` parameter |
| `GWBACKUPY_APPDIR`                       | `/app`                                     |                                                |
| `GWBACKUPY_ACCOUNT_EMAILS`               | `example@example.com example2@example.com` | Email accounts, space separated list           |
| `GWBACKUPY_CRON_FULL_SYNC`               | `0 0 * * 0`                                |                                                |
| `GWBACKUPY_CRON_QUICK_SYNC`              | `0 0 * * 1-6`                              |                                                |
| `GWBACKUPY_CRON_LOG`                     | `${GWBACKUPY_APPDIR}/crontab.log`          |                                                |
| `GWBACKUPY_CRONTAB`                      | `${GWBACKUPY_APPDIR}/crontab`              |                                                |
| `GWBACKUPY_LOG_LEVEL`                    | `warning`                                  | see more `--log-level` parameter               |
| `GWBACKUPY_CREDENTIALS_FILEPATH`         | ` `                                        |                                                |
| `GWBACKUPY_SERVICE_ACCOUNT_KEY_FILEPATH` | ` `                                        |                                                |
| `GWBACKUPY_MAIN_ARGS`                    | ` `                                        |                                                |
| `GWBACKUPY_SERVICES`                     | `gmail`                                    | Services for backup, currently `gmail` only    |
| `GWBACKUPY_OAUTH_REDIRECT_HOST`          | `localhost`                                |                                                |
| `GWBACKUPY_OAUTH_PORT`                   | `43339`                                    |                                                |
| `GWBACKUPY_OAUTH_BIND_ADDRESS`           | `0.0.0.0`                                  |                                                |
| `GWBACKUPY_QUICK_SYNC_DAYS`              | `7`                                        |                                                |

## Scripts

- `entrypoint.sh`: check authentication status, and if is ok, then starts crond (default script) and schedule
  full and quick backups
- `quick-sync.sh`: script for start quick backup
- `full-sync.sh`: script for start full backup 
- `access-init.sh`: script for start initialize authentication (use first time and if auth changes)
  ```bash
  docker ... -it exec /bin/bash access-init.sh
  ```
- `access-check.sh`: script for authentication states checking

Run gwbackupy with custom parameters (e.g. restore):
```bash
docker ... -it exec python -m gwbackupy ...
```
