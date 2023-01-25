#!/bin/bash

echo "Starting gwbackupy docker"
. prepare.sh

# if access is OK, then start cron
# else show access-init required

echo "Checking access..."
for email in ${GWBACKUPY_ACCOUNT_EMAILS}; do
  for service in ${GWBACKUPY_SERVICES}; do
    echo "Checking $email for $service..."
    cmd="python -m gwbackupy $GWBACKUPY_MAIN_OPTIONS $service access-check --email=$email"
    echo $cmd
    $cmd
    if [ "$?" != "0" ]; then
      echo "$email account auth check failed for $service service, sea more access-init.sh"
      exit 1
    fi
  done
done


#CMD crond && tail -f ${GWBACKUPY_CRON_LOG}
