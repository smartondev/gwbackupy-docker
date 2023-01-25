#!/bin/bash

echo "Quick sync starting..."

. "$GWBACKUPY_APPDIR/prepare.sh"

if [[ "$GWBACKUPY_QUICK_SYNC_DAYS" != "" ]]; then
  GWBACKUPY_GMAIL_ARGS="--quick-sync-days=$GWBACKUPY_QUICK_SYNC_DAYS $GWBACKUPY_GMAIL_ARGS"
fi

# currently only for gmail!
for email in ${GWBACKUPY_ACCOUNT_EMAILS}; do
  CMD="python -m gwbackupy $GWBACKUPY_MAIN_ARGS gmail backup --email=$email $GWBACKUPY_GMAIL_ARGS"
  echo "Run: $CMD"
  if ! $CMD; then
    echo "Quick backup failed for $email"
  else
    echo -e "\e[32mQuick backup succeeded for $email\033[0m"
  fi
done
