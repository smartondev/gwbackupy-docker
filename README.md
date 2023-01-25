# Docker image fro [gwbackupy](https://github.com/smartondev/gwbackupy)

**Under development**

## Overview

...

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

- `access-init.sh`: initializes authentication if required
  ```bash
  docker run ... exec /bin/bash access-init.sh
  ```
- `entrypoint.sh`: check authentication status, and if is ok, then starts crond (default script)
- `quick-sync.sh`: quick backup
- `full-sync.sh`: full backup

