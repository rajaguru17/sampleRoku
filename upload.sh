#!/bin/bash

set -e

# Directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Workspace root (parent of scripts directory)
WORKSPACE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

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

# Determine app directory
APP_DIR="${PWD#$WORKSPACE_ROOT/}"

# If script is executed from workspace root,
# use the workspace as the app directory.
if [ "$APP_DIR" = "$PWD" ]; then
    APP_DIR="."
fi

echo "-----------------------------------------"
echo "Workspace : $WORKSPACE_ROOT"
echo "App Folder: $APP_DIR"
echo "Roku IP   : $ROKU_IP"
echo "User      : $ROKU_USER"
echo "-----------------------------------------"

# Create output folder
mkdir -p "$WORKSPACE_ROOT/out"

# Remove previous zip
rm -f "$WORKSPACE_ROOT/out/channel.zip"

echo
echo "Creating channel.zip..."

cd "$WORKSPACE_ROOT/$APP_DIR"

zip -rq "$WORKSPACE_ROOT/out/channel.zip" . \
    -x ".git/*" \
    -x ".vscode/*" \
    -x "out/*" \
    -x "*.DS_Store"

cd "$WORKSPACE_ROOT"

if [ ! -f "$WORKSPACE_ROOT/out/channel.zip" ]; then
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
    -F "archive=@$WORKSPACE_ROOT/out/channel.zip" \
    -F "mysubmit=Install" \
    "http://$ROKU_IP/plugin_install"

echo
echo "Cleaning up..."

rm -f "$WORKSPACE_ROOT/out/channel.zip"

echo
echo "========================================="
echo "Upload completed successfully."
echo "========================================="