#!/usr/bin/env bash

echo "Container starting..."
. prepare.sh
. access-init.sh

mkdir -p "${GWBACKUPY_TEMPDIR}"
mkdir -p "${GWBACKUPY_LOGDIR}"

# setup logrotate
LOGROTATE_CONF="${GWBACKUPY_APPDIR}/logrotate.conf"
cat <<EOF >"${LOGROTATE_CONF}"
${GWBACKUPY_CRON_LOG} {
    rotate 8
    weekly
    compress
    delaycompress
    missingok
    notifempty
}
EOF

# setup crons
touch "${GWBACKUPY_CRON_LOG}"
echo "13 * * * * /usr/bin/flock ${GWBACKUPY_CRON_FLOCK_FILEPATH} logrotate -f ${LOGROTATE_CONF}" >>"${GWBACKUPY_CRONTAB}"
if [[ "$GWBACKUPY_CRON_FULL_SYNC" != "" ]]; then
  echo "$GWBACKUPY_CRON_FULL_SYNC /usr/bin/flock ${GWBACKUPY_CRON_FLOCK_FILEPATH} /bin/bash ${GWBACKUPY_APPDIR}/logcmd.sh ${GWBACKUPY_APPDIR}/sync.sh >> ${GWBACKUPY_CRON_LOG} 2>&1" >>"${GWBACKUPY_CRONTAB}"
fi
if [[ "$GWBACKUPY_CRON_QUICK_SYNC" != "" ]]; then
  echo "${GWBACKUPY_CRON_QUICK_SYNC} sleep 1; /usr/bin/flock -xn ${GWBACKUPY_CRON_FLOCK_FILEPATH} /bin/bash ${GWBACKUPY_APPDIR}/logcmd.sh ${GWBACKUPY_APPDIR}/quick-sync.sh >> ${GWBACKUPY_CRON_LOG} 2>&1" >>"${GWBACKUPY_CRONTAB}"
fi
crontab "${GWBACKUPY_CRONTAB}"
echo "Installed cron jobs:"
crontab -l

echo "Run crond"
crond && tail -f "${GWBACKUPY_CRON_LOG}"
