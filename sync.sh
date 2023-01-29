#!/usr/bin/env bash

echo "Sync starting..."

cd "$GWBACKUPY_APPDIR" || (
  echo "$GWBACKUPY_APPDIR directory is not exists?"
  exit 1
)
. prepare.sh

ERROR=0
for email in ${GWBACKUPY_ACCOUNT_EMAILS}; do
  # currently only for gmail!
  service="gmail"

  . access-check.sh "$email" "$service"
  if [ $? -eq 0 ]; then
    echo "Start backup for $email ($service)"
    python -m gwbackupy $GWBACKUPY_MAIN_ARGS gmail backup --email=$email $GWBACKUPY_GMAIL_ARGS
    if [ $? -eq 0 ]; then
      echo "Backup succeeded for $email"
    else
      echo "Backup failed for $email ($service, run backup)"
      ERROR=1
    fi
  else
    echo "Backup failed for $email ($service, access check)"
    ERROR=1
  fi
done

exit $ERROR
