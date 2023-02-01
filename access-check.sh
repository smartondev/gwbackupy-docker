#!/usr/bin/env bash

. prepare.sh

EMAILS="$1"
SERVICES="$2"
if [[ "${EMAILS}" == "" ]]; then
  EMAILS="${GWBACKUPY_ACCOUNT_EMAILS}"
fi
if [[ "${SERVICES}" == "" ]]; then
  SERVICES="${GWBACKUPY_SERVICES}"
fi

for email in ${EMAILS}; do
  for service in ${SERVICES}; do
    python -m gwbackupy $GWBACKUPY_MAIN_ARGS $service access-check --email=$email
    if [ "$?" -ne "0" ]; then
      echo "$email account auth check failed for $service service, sea more access-init.sh"
      return 1
    fi
    echo "$email account auth check successful for $service service"
  done
done

return 0
