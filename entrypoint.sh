#!/bin/bash

echo "Starting gwbackupy docker"
. prepare.sh

echo "Checking access..."
for email in ${GWBACKUPY_ACCOUNT_EMAILS}; do
  for service in ${GWBACKUPY_SERVICES}; do
    echo "Checking $email for $service..."
    CMD="python -m gwbackupy $GWBACKUPY_MAIN_ARGS $service access-check --email=$email"
    echo "Run: $CMD"
    if ! $CMD; then
      echo "$email account auth check failed for $service service, sea more access-init.sh"
      exit 1
    else
      echo "$email account auth check successful for $service service"
    fi
  done
done

touch "${GWBACKUPY_CRON_LOG}"
if [[ "$GWBACKUPY_CRON_QUICK_SYNC" != "" ]]; then
  echo "Cron pattern for quick sync: $GWBACKUPY_CRON_QUICK_SYNC"
  echo "${GWBACKUPY_CRON_QUICK_SYNC} /bin/bash ${GWBACKUPY_APPDIR}/quick-sync.sh >> ${GWBACKUPY_CRON_LOG} 2>&1" >>${GWBACKUPY_CRONTAB}
fi
if [[ "$GWBACKUPY_CRON_FULL_SYNC" != "" ]]; then
  echo "Cron pattern for full sync: $GWBACKUPY_CRON_FULL_SYNC"
  echo "$GWBACKUPY_CRON_FULL_SYNC /bin/bash ${GWBACKUPY_APPDIR}/full-sync.sh >> ${GWBACKUPY_CRON_LOG} 2>&1" >>${GWBACKUPY_CRONTAB}
fi
crontab "${GWBACKUPY_CRONTAB}"
echo "Installed cron jobs:"
crontab -l

echo "Run crond"
crond && tail -f "${GWBACKUPY_CRON_LOG}"
