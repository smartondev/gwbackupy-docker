#!/usr/bin/env bash

TEMPFILE=$(mktemp /tmp/tempfile.XXXXXX)
touch $TEMPFILE

$1 2>&1 | tee $TEMPFILE

# TODO: $TEMPFILE store send or anything

rm $TEMPFILE
