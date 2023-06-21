#!/bin/bash

EXTENSION_DIR="/var/www/html/extensions/$1"
BRANCH="master"

while getopts "b:" opt; do
  case $opt in
    b)
      BRANCH=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

if [ ! -d "$EXTENSION_DIR" ]; then
    git clone -b "$BRANCH" "$2" "$EXTENSION_DIR"
fi
