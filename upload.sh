#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Auto-detect the app directory relative to the workspace root
APP_DIR="${PWD#$WORKSPACE_ROOT/}"

ROKU_USER="rokudev"

echo "Enter the Roku device IP:"
read -r ROKU_IP

echo "Enter the Roku developer password (press Enter for default):"
read -rs ROKU_PASSWORD
echo

# Default password
if [ -z "$ROKU_PASSWORD" ]; then
    ROKU_PASSWORD="abcd"
fi

ROKU_USER_PASS="$ROKU_USER:$ROKU_PASSWORD"

echo "----------------------------------------"
echo "Workspace : $WORKSPACE_ROOT"
echo "App Folder: $APP_DIR"
echo "Roku IP   : $ROKU_IP"
echo "----------------------------------------"

# Create output directory
mkdir -p "$WORKSPACE_ROOT/out"

# Remove previous zip
rm -f "$WORKSPACE_ROOT/out/channel.zip"

echo "Creating channel.zip..."

cd "$WORKSPACE_ROOT/$APP_DIR" || exit 1

zip -rq "$WORKSPACE_ROOT/out/channel.zip" . \
    -x ".git/*" \
    -x ".vscode/*" \
    -x "out/*" \
    -x "*.DS_Store"

cd - >/dev/null

if [ ! -f "$WORKSPACE_ROOT/out/channel.zip" ]; then
    echo "ERROR: Failed to create channel.zip"
    exit 1
fi

echo "ZIP created successfully."

echo "Deleting existing dev channel..."

curl --digest \
     -u "$ROKU_USER_PASS" \
     -F "archive=" \
     -F "mysubmit=Delete" \
     "http://$ROKU_IP/plugin_install"

echo "Uploading new channel..."

curl --digest \
     -u "$ROKU_USER_PASS" \
     -F "archive=@$WORKSPACE_ROOT/out/channel.zip" \
     -F "mysubmit=Install" \
     "http://$ROKU_IP/plugin_install"

echo
echo "Upload completed successfully."

echo "Cleaning up..."

rm -f "$WORKSPACE_ROOT/out/channel.zip"

echo "Done."