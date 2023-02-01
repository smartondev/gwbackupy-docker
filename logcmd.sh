#!/usr/bin/env bash

TEMPFILE=$(mktemp "${GWBACKUPY_TEMPDIR}/log.XXXXXX")
touch $TEMPFILE

$1 2>&1 | tee $TEMPFILE

# TODO: $TEMPFILE store send or anything

rm $TEMPFILE
