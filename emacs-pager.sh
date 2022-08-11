#!/bin/bash

# Creates temporary file to hold contents from stdin then hands off path
# to temporary file to emacsclient for it to load into the running Emacs
# process.
#
# NOTE: the emacs-pager function *might* delete the temporary file after
# loading the file's contents into an Emacs buffer.

FILE="$(mktemp)"
cat - > "${FILE}"
echo "-- loading in Emacs..."
emacsclient --eval "(emacs-pager \"${FILE}\")"
