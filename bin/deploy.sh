#!/bin/bash

if [ "$1" != "" ]; then
  BRANCH=$(git rev-parse --abbrev-ref HEAD)

  expect -f deploy.exp $BRANCH $1
else
  echo "Missing the env arg"
fi
