#!/bin/bash

echo "[$FTP_PASS]"

CHANGED_FILES=($(git diff --name-only $TRAVIS_COMMIT_RANGE))
curl -k --ftp-ssl --ftp-create-dirs -T "{$(IFS=,; echo ${CHANGED_FILES[@]})}" -u "$FTP_USER":"$FTP_PASS" ftp://31.31.75.247:21/$WEBSITE/
