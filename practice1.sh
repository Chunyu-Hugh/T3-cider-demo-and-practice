#!/bin/bash

# Get the current user's home directory
USER_HOME=$(eval echo ~${USER})

# Create base directory structure
mkdir -p "$USER_HOME/practice/practice1"
cd "$USER_HOME/practice/practice1"

# Create deeply nested directory structure
mkdir -p level1/level2/level3/dead_end
mkdir -p level1/level2/secret/hidden/deeper/deepest
mkdir -p level1/distraction/folder1/folder2
mkdir -p level1/level2/level3/alternate/path1/path2
mkdir -p level1/level2/level3/alternate/path1/path3/final

# Create hidden directories within the structure
mkdir -p level1/.hidden1
mkdir -p level1/level2/.hidden2
mkdir -p level1/level2/level3/.hidden3
mkdir -p level1/level2/secret/.concealed

# Place decoy files throughout the structure
touch level1/file1.txt
touch level1/level2/file2.txt
touch level1/level2/level3/file3.txt
touch level1/level2/secret/hidden/deeper/decoy.dat

# Create symbolic links that lead to different paths
ln -s level1/level2/level3 shortcut1
ln -s level1/distraction false_path
ln -s level1/level2/secret/hidden/deeper true_path

# Create the target file deep in the nested structure
mkdir -p level1/level2/level3/alternate/path1/path3/final/.system
dd if=/dev/zero of=level1/level2/level3/alternate/path1/path3/final/.system/target.dat bs=1K count=2 2>/dev/null
chmod 400 level1/level2/level3/alternate/path1/path3/final/.system/target.dat

echo "Nested Labyrinth challenge setup complete. Begin at $USER_HOME/practice/practice1"
