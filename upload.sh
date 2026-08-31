
#!/bin/bash

set -e

# Directory where this script is located (also the project root)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Project root is the same directory as this script
PROJECT_ROOT="$SCRIPT_DIR"

# Load configuration
CONFIG_FILE="$SCRIPT_DIR/roku.conf"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "ERROR: Configuration file not found:"
    echo "$CONFIG_FILE"
    exit 1
fi

# Read configuration
source "$CONFIG_FILE"

# Validate configuration
if [ -z "$ROKU_IP" ] || [ -z "$ROKU_USER" ] || [ -z "$ROKU_PASSWORD" ]; then
    echo "ERROR: Missing configuration values."
    echo "Please update $CONFIG_FILE"
    exit 1
fi

echo "-----------------------------------------"
echo "Project : $PROJECT_ROOT"
echo "Roku IP : $ROKU_IP"
echo "User    : $ROKU_USER"
echo "-----------------------------------------"

# Create output folder
mkdir -p "$PROJECT_ROOT/out"

# Remove previous zip
rm -f "$PROJECT_ROOT/out/channel.zip"

echo
echo "Creating channel.zip..."

cd "$PROJECT_ROOT"

zip -rq "$PROJECT_ROOT/out/channel.zip" . \
    -x ".git/*" \
    -x ".vscode/*" \
    -x "out/*" \
    -x "*.DS_Store" \
    -x "roku.conf" \
    -x "upload.sh"

if [ ! -f "$PROJECT_ROOT/out/channel.zip" ]; then
    echo "ERROR: channel.zip was not created."
    exit 1
fi

echo "ZIP created successfully."

echo
echo "Deleting existing dev channel..."

curl --digest \
    -u "$ROKU_USER:$ROKU_PASSWORD" \
    -F "archive=" \
    -F "mysubmit=Delete" \
    "http://$ROKU_IP/plugin_install"

echo
echo "Uploading new channel..."

curl --digest \
    -u "$ROKU_USER:$ROKU_PASSWORD" \
    -F "archive=@$PROJECT_ROOT/out/channel.zip" \
    -F "mysubmit=Install" \
    "http://$ROKU_IP/plugin_install"

echo
echo "Cleaning up..."

rm -f "$PROJECT_ROOT/out/channel.zip"

echo
echo "========================================="
echo "Upload completed successfully."
echo "========================================="