#!/bin/bash

. prepare.sh

echo "Checking access..."
for email in ${GWBACKUPY_ACCOUNT_EMAILS}; do
  for service in ${GWBACKUPY_SERVICES}; do
    echo "Checking $email for $service..."
    CMD="python -m gwbackupy $GWBACKUPY_MAIN_ARGS $service access-check --email=$email"
    echo "Run: $CMD"
    if ! $CMD; then
      echo "$email account auth check failed for $service service, sea more access-init.sh"
      return 1
    else
      echo "$email account auth check successful for $service service"
    fi
  done
done

return 0
