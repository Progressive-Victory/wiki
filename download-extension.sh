#!/bin/bash

EXTENSION_NAME=$1
MW_VERSION=$2

if [ -z "$EXTENSION_NAME" ]; then
    echo "No extension name provided."
    exit 1
fi

if [ -z "$MW_VERSION" ]; then
    echo "No MediaWiki version provided."
    exit 1
fi

TARGET_DIR="/var/www/html/extensions"

if [ -d "$TARGET_DIR/$EXTENSION_NAME" ]; then
    echo "Extension $EXTENSION_NAME is already installed."
    exit 0
fi

API_URL="https://www.mediawiki.org/w/api.php?action=query&list=extdistbranches&edbexts=$EXTENSION_NAME&format=json"
EXTENSION_FILE="$TARGET_DIR/$EXTENSION_NAME.tar.gz"
MAX_RETRIES=5
RETRY_INTERVAL=5

for i in $(seq 1 $MAX_RETRIES); do
    echo "Downloading $EXTENSION_NAME extension (attempt $i)..."

    EXTENSION_URL=$(curl -s $API_URL | jq -r ".query.extdistbranches.extensions.$EXTENSION_NAME.$MW_VERSION")

    if [ "$EXTENSION_URL" == "null" ]; then
        echo "Failed to fetch extension URL. Please ensure the extension name and MediaWiki version are correct."
        exit 1
    fi

    curl -Lk --retry $MAX_RETRIES --retry-delay $RETRY_INTERVAL -o $EXTENSION_FILE $EXTENSION_URL
    if [ $? -eq 0 ]; then
        echo "File should have been downloaded to $EXTENSION_FILE"
        echo "Extracting $EXTENSION_NAME extension..."
        tar -xzf $EXTENSION_FILE -C $TARGET_DIR
        if [ $? -ne 0 ]; then
            echo "Failed to extract $EXTENSION_NAME extension..."
        else
            rm $EXTENSION_FILE
            echo "Extension $EXTENSION_NAME successfully installed."
        fi
        break
    else
        echo "Failed to download $EXTENSION_NAME extension (attempt $i). Retrying in $RETRY_INTERVAL seconds..."
        sleep $RETRY_INTERVAL
    fi
done
