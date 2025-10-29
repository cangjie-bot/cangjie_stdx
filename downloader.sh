#!/bin/bash

# Exit on any error
set -e

# --- Helper Functions ---

# Print error message and exit
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Get current platform and architecture
get_platform_arch() {
    os=$(uname -s)
    arch=$(uname -m)

    case "$os" in
        Linux)
            platform="linux"
            ;;
        Darwin)
            platform="mac"
            ;;
        *)
            error_exit "Unsupported operating system: $os"
            ;;
    esac

    case "$arch" in
        x86_64)
            architecture="x64"
            ;;
        aarch64 | arm64)
            architecture="aarch64"
            ;;
        *)
            error_exit "Unsupported architecture: $arch"
            ;;
    esac

    echo "${platform}-${architecture}"
}

# --- Main Script ---

# 1. Argument Parsing
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <version> [<platform-arch>] [<extract-dir>]"
    echo "Example: $0 1.0.3.1 linux-x64 ./output"
    exit 1
fi

VERSION="$1"
PLATFORM_ARCH="${2:-$(get_platform_arch)}"
DEST_DIR="${3:-.}"

# Validate platform-architecture
case "$PLATFORM_ARCH" in
    linux-aarch64|linux-x64|mac-aarch64|mac-x64|ohos-aarch64|ohos-x64|windows-x64)
        # valid
        ;;
    *)
        error_exit "Unsupported platform-architecture: $PLATFORM_ARCH"
        ;;
esac

# 2. Define Variables
REPO_URL="https://gitcode.com/Cangjie/cangjie_stdx"
FILENAME="cangjie-stdx-${PLATFORM_ARCH}-${VERSION}.zip"
DOWNLOAD_URL="${REPO_URL}/releases/download/v${VERSION}/${FILENAME}"
CACHE_DIR="$HOME/.cangjie_stdx/v${VERSION}"
CACHED_FILE="${CACHE_DIR}/${FILENAME}"
EXTRACTED_DIR_NAME="cangjie-stdx-${PLATFORM_ARCH}-${VERSION}"

# 3. Destination Directory Check
if [ ! -d "$DEST_DIR" ]; then
    error_exit "Destination directory does not exist: $DEST_DIR"
fi
DEST_DIR_ABS=$(cd "$DEST_DIR" && pwd)

# 4. Cache and Download Logic
mkdir -p "$CACHE_DIR"

if [ -f "$CACHED_FILE" ]; then
    echo "Using cached file: $CACHED_FILE"
else
    echo "Downloading from: $DOWNLOAD_URL"
    if command -v curl &> /dev/null; then
        curl -# -L -o "$CACHED_FILE" "$DOWNLOAD_URL"
    elif command -v wget &> /dev/null; then
        wget -q --show-progress -O "$CACHED_FILE" "$DOWNLOAD_URL"
    else
        error_exit "Please install 'curl' or 'wget' to download files."
    fi

    if [ $? -ne 0 ]; then
        rm -f "$CACHED_FILE" # Clean up partial download
        error_exit "Download failed."
    fi
fi

# 5. Extraction and Rename Logic
echo "Extracting to: $DEST_DIR_ABS"
# Create a temporary directory for extraction to safely get the top-level folder name
TMP_EXTRACT_DIR=$(mktemp -d)
unzip -q "$CACHED_FILE" -d "$TMP_EXTRACT_DIR" || error_exit "Unzip failed. The file might be corrupted or not a valid zip archive."

# Find the top-level directory within the temp extraction folder
TOP_LEVEL_DIR=$(find "$TMP_EXTRACT_DIR" -mindepth 1 -maxdepth 1 -type d)

if [ -z "$TOP_LEVEL_DIR" ] || [ ! -d "$TOP_LEVEL_DIR" ]; then
    rm -rf "$TMP_EXTRACT_DIR"
    error_exit "Could not find a top-level directory in the zip file."
fi

# Move and rename the extracted content
FINAL_PATH="${DEST_DIR_ABS}/${EXTRACTED_DIR_NAME}"
if [ -d "$FINAL_PATH" ]; then
    echo "Warning: Target directory already exists. Overwriting: ${FINAL_PATH}"
    rm -rf "$FINAL_PATH"
fi
mv "$TOP_LEVEL_DIR" "$FINAL_PATH"

# Clean up temp directory
rm -rf "$TMP_EXTRACT_DIR"

# 6. Success Output
echo "Successfully extracted to: $FINAL_PATH"
