#!/bin/bash

. prepare.sh

echo "Checking access..."
for email in ${GWBACKUPY_ACCOUNT_EMAILS}; do
  for service in ${GWBACKUPY_SERVICES}; do
    echo "Checking $email for $service..."
    CMD_CHECK="python -m gwbackupy $GWBACKUPY_MAIN_ARGS $service access-check --email=$email"
    echo "Run: $CMD_CHECK"
    if ! $CMD_CHECK; then
      echo "$email account auth check failed for $service service"
      CMD_INIT="python -m gwbackupy $GWBACKUPY_MAIN_ARGS $service access-init --email=$email"
      echo "Run: $CMD_INIT"
      if ! $CMD_INIT; then
        echo "$email account auth init failed for $service service"
        exit 1
      fi
      echo "Run: $CMD_CHECK"
      if ! $CMD_CHECK; then
        echo "$email account auth check (after init) failed for $service service"
        exit 1
      fi
      echo "$email auth int successful"
    else
      echo "$email auth check successful"
    fi
  done
done
