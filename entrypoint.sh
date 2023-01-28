#!/usr/bin/env bash

echo "Starting..."
. prepare.sh
. access-check.sh "${GWBACKUPY_ACCOUNT_EMAILS}" "${GWBACKUPY_SERVICES}" || . access-init.sh

touch "${GWBACKUPY_CRON_LOG}"
if [[ "$GWBACKUPY_CRON_QUICK_SYNC" != "" ]]; then
  echo "${GWBACKUPY_CRON_QUICK_SYNC} /bin/bash ${GWBACKUPY_APPDIR}/quick-sync.sh >> ${GWBACKUPY_CRON_LOG} 2>&1" >>${GWBACKUPY_CRONTAB}
fi
if [[ "$GWBACKUPY_CRON_FULL_SYNC" != "" ]]; then
  echo "$GWBACKUPY_CRON_FULL_SYNC /bin/bash ${GWBACKUPY_APPDIR}/full-sync.sh >> ${GWBACKUPY_CRON_LOG} 2>&1" >>${GWBACKUPY_CRONTAB}
fi
crontab "${GWBACKUPY_CRONTAB}"
echo "Installed cron jobs:"
crontab -l

echo "Run crond"
crond && tail -f "${GWBACKUPY_CRON_LOG}"
