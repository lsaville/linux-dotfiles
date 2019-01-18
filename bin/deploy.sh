#!/bin/bash

if [ "$1" != "" ]; then
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  BRANCH_ABBRV=$(echo "$BRANCH" | cut -b -7 )

  expect -f deploy.exp $BRANCH $1
  ./blink
  ./slackpm jennmorris "Yo yo yo @jennmorris $BRANCH_ABBRV is deployed to $1"
else
  echo "Missing the env arg"
fi
