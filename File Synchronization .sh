#!/bin/bash

# Usage: ./sync_directories.sh source_directory target_directory

SOURCE=/home/kali/test_directory/source_directory
TARGET=/home/kali/test_directory/target_directory

# Check if the source and target directories are provided
if [ -z "$SOURCE" ] || [ -z "$TARGET" ]; then
    echo "Usage: $0 source_directory target_directory"
    exit 1
fi

# Check if the source directory exists
if [ ! -d "$SOURCE" ]; then
    echo "Source directory does not exist: $SOURCE"
    exit 1
fi

# Synchronize files from the source to the target directory
rsync -av --delete "$SOURCE" "$TARGET"

# Explanation of rsync options:
# -a: Archive mode, which preserves symbolic links, permissions, timestamps, etc.
# -v: Verbose, provides detailed information about what is being synchronized.
# --delete: Deletes files in the target directory that are not in the source directory.

echo "Synchronization complete."