#!/usr/bin/env bash

echo "Quick sync starting..."

cd "$GWBACKUPY_APPDIR" || exit 1
. prepare.sh

if [[ "$GWBACKUPY_QUICK_SYNC_DAYS" != "" ]]; then
  GWBACKUPY_GMAIL_ARGS="--quick-sync-days=$GWBACKUPY_QUICK_SYNC_DAYS $GWBACKUPY_GMAIL_ARGS"
fi

. sync.sh
