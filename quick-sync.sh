#!/usr/bin/env bash

echo "Quick sync starting..."

cd "$GWBACKUPY_APPDIR" || exit 1
. prepare.sh

if [[ "$GWBACKUPY_QUICK_SYNC_DAYS" != "" ]]; then
  GWBACKUPY_GMAIL_ARGS="--quick-sync-days=$GWBACKUPY_QUICK_SYNC_DAYS $GWBACKUPY_GMAIL_ARGS"
fi

ERROR=0
for email in ${GWBACKUPY_ACCOUNT_EMAILS}; do
  # currently only for gmail!
  service="gmail"

  . access-check.sh "$email" "$service"
  if [ $? -eq 0 ]; then
    python -m gwbackupy $GWBACKUPY_MAIN_ARGS gmail backup --email=$email $GWBACKUPY_GMAIL_ARGS
    if [ $? -eq 0 ]; then
      echo "Quick backup succeeded for $email"
    else
      echo "Quick backup failed for $email ($service, run backup)"
      ERROR=1
    fi
  else
    echo "Quick backup failed for $email ($service, access check)"
    ERROR=1
  fi
done

exit $ERROR
