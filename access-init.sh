#!/usr/bin/env bash

. prepare.sh

echo "Check and initialize authentication..."
for email in ${GWBACKUPY_ACCOUNT_EMAILS}; do
  for service in ${GWBACKUPY_SERVICES}; do
    . access-check.sh "$email" "$service" && continue
    python -m gwbackupy $GWBACKUPY_MAIN_ARGS $service access-init --email=$email
    if [ "$?" -ne "0" ]; then
        echo "$email account auth init failed for $service service"
        exit 1
    fi
    . access-check.sh "$email" "$service" && continue
    echo "$email account auth init failed for $service service (rechecking failed)"
    exit 1
  done
done

return 0
