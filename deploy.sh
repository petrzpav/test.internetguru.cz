#!/bin/bash

CHANGED_FILES=($(git diff --name-only $TRAVIS_COMMIT_RANGE))
TO_UPLOAD=()

for file in ${CHANGED_FILES[@]}; do
  [[ "$file" == ".travis.yml" || "$file" == "deploy.sh" || "$file" == ".gitignore" ]] && continue
  if [[ ! -f "$file" ]]; then
    curl -v -u "$FTP_USER":"$FTP_PASS" ftp://31.31.75.247:21/"$WEBSITE/$file" -Q "DELE $file"
    continue
  fi
  curl -k --ftp-ssl --ftp-create-dirs -T "$file" -u "$FTP_USER":"$FTP_PASS" ftp://31.31.75.247:21/$WEBSITE/"$(dirname "$file")/"
done

