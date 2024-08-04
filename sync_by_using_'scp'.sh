#!/bin/bash
# Define source and destination directories
SOURCE_DIR="/home/kali/test_directory/source_directory"
DEST_DIR="/home/kali/test_directory/target_directory"

# Ensure the destination directory exists
mkdir -p "$DEST_DIR"

# Function to synchronize files
sync_files() {
  local src_file=$1
  local dest_file=$2

  # Check if the file exists in the destination directory
  if [ -f "$dest_file" ]; then
    # Compare the files
    if ! cmp -s "$src_file" "$dest_file"; then
      # If files are different, copy the file
      cp "$src_file" "$dest_file"
      echo "Updated: $dest_file"
    fi
  else
    # If the file does not exist in the destination directory, copy the file
    cp "$src_file" "$dest_file"
    echo "Copied: $dest_file"
  fi
}

# Export the function so it can be used with find
export -f sync_files
export SOURCE_DIR
export DEST_DIR

# Find all files in the source directory and synchronize them
find "$SOURCE_DIR" -type f -exec bash -c 'sync_files "$0" "$DEST_DIR${0#$SOURCE_DIR}"' {} \;

echo "Synchronization complete."
