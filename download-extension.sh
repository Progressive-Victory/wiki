#!/bin/bash

#echo "Checking permissions..."
#echo "Permissions for /var/www/html/extensions: $(ls -ld /var/www/html/extensions)"
#echo "Permissions for this script: $(ls -l $0)"

# Get the extension name and URL from command line arguments
EXTENSION_NAME=$1
EXTENSION_URL=$2

# Define the file name of the extension archive
EXTENSION_FILE="/var/www/html/extensions/$EXTENSION_NAME.tar.gz"

# Define the target directory for the extracted files
TARGET_DIR="/var/www/html/extensions"

if [ -z "$EXTENSION_NAME" ]; then
    echo "No extension name provided."
    exit 1
fi

if [ -d "$TARGET_DIR/$EXTENSION_NAME" ]; then
    echo "Extension $EXTENSION_NAME is already installed."
    exit 0
fi

# Define the maximum number of retries
MAX_RETRIES=5

# Define the retry interval in seconds
RETRY_INTERVAL=5

echo "Current working directory: $(pwd)"
echo "Listing files in $TARGET_DIR: $(ls $TARGET_DIR)"

# Download and extract the extension archive
for i in $(seq 1 $MAX_RETRIES); do
    echo "Downloading $EXTENSION_NAME extension (attempt $i)..."
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
