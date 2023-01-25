#!/bin/bash

echo "Quick sync starting..."

. "$GWBACKUPY_APPDIR/prepare.sh"

# currently only for gmail!
for email in ${GWBACKUPY_ACCOUNT_EMAILS}; do
  CMD="python -m gwbackupy $GWBACKUPY_MAIN_ARGS gmail backup --email=$email $GWBACKUPY_GMAIL_ARGS"
  echo "Run: $CMD"
  if ! $CMD; then
    echo "Full backup failed for $email"
  else
    echo "Full backup succeeded for $email"
  fi
done
