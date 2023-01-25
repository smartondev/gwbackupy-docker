# Docker image fro [gwbackupy](https://github.com/smartondev/gwbackupy)

**Under development**

## Container environment parameters

| Env name                                 | Default value                              | Description |
|------------------------------------------|--------------------------------------------|-------------|
| `GWBACKUPY_WORKDIR`                      | `/data`                                    |             |
| `GWBACKUPY_APPDIR`                       | `/app`                                     |             |
| `GWBACKUPY_ACCOUNT_EMAILS`               | `example@example.com example2@example.com` |             |
| `GWBACKUPY_CRON_FULL_SYNC`               | `0 0 * * 0`                                |             |
| `GWBACKUPY_CRON_QUICK_SYNC`              | `0 0 * * 1-6`                              |             |
| `GWBACKUPY_CRON_LOG`                     | `${GWBACKUPY_APPDIR}/crontab.log`          |             |
| `GWBACKUPY_CRONTAB`                      | `${GWBACKUPY_APPDIR}/crontab`              |             |
| `GWBACKUPY_LOG_LEVEL`                    | `warning`                                  |             |
| `GWBACKUPY_CREDENTIALS_FILEPATH`         | ``                                         |             |
| `GWBACKUPY_SERVICE_ACCOUNT_KEY_FILEPATH` | ``                                         |             |
| `GWBACKUPY_MAIN_OPTIONS`                 | ``                                         |             |
| `GWBACKUPY_SERVICES`                     | `gmail`                                    |             |
| `GWBACKUPY_OAUTH_REDIRECT_HOST`          | `localhost`                                |             |
| `GWBACKUPY_OAUTH_PORT`                   | `43339`                                    |             |
| `GWBACKUPY_OAUTH_BIND_ADDRESS`           | `0.0.0.0`                                  |             |


