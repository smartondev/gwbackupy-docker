#!/bin/bash

if [[ "$GWBACKUPY_ACCOUNT_EMAILS" == "example@example.com example2@example.com" ]]; then
  echo "Please provide GWBACKUPY_ACCOUNT_EMAILS, currently is: $GWBACKUPY_ACCOUNT_EMAILS"
  exit 1
fi

if [[ "$GWBACKUPY_LOG_LEVEL" != "" ]]; then
  GWBACKUPY_MAIN_ARGS="--log-level=$GWBACKUPY_LOG_LEVEL $GWBACKUPY_MAIN_ARGS"
fi

if [[ "$GWBACKUPY_CREDENTIALS_FILEPATH" != "" ]]; then
  GWBACKUPY_MAIN_ARGS="--credentials-filepath=$GWBACKUPY_CREDENTIALS_FILEPATH $GWBACKUPY_MAIN_ARGS"
fi

if [[ "$GWBACKUPY_SERVICE_ACCOUNT_KEY_FILEPATH" != "" ]]; then
  GWBACKUPY_MAIN_ARGS="--service-account-key-filepath=$GWBACKUPY_SERVICE_ACCOUNT_KEY_FILEPATH $GWBACKUPY_MAIN_ARGS"
fi

if [[ "$GWBACKUPY_OAUTH_REDIRECT_HOST" != "" ]]; then
  GWBACKUPY_MAIN_ARGS="--oauth-redirect-host=$GWBACKUPY_OAUTH_REDIRECT_HOST $GWBACKUPY_MAIN_ARGS"
fi

if [[ "$GWBACKUPY_OAUTH_PORT" != "" ]]; then
  GWBACKUPY_MAIN_ARGS="--oauth-port=$GWBACKUPY_OAUTH_PORT $GWBACKUPY_MAIN_ARGS"
fi

if [[ "$GWBACKUPY_WORKDIR" != "" ]]; then
  GWBACKUPY_MAIN_ARGS="--workdir=$GWBACKUPY_WORKDIR $GWBACKUPY_MAIN_ARGS"
fi

if [[ "$GWBACKUPY_MAIN_ARGS" != "" ]]; then
  echo "Gwbackupy run with following main arguments: $GWBACKUPY_MAIN_ARGS"
fi
