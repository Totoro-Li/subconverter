#!/bin/bash

REPO_URL="https://github.com/ACL4SSR/ACL4SSR.git"
REPO_DIR="./ACL4SSR"

# Check if the repository directory exists
if [ ! -d "$REPO_DIR" ]; then
    echo "Cloning repository..."
    git clone "$REPO_URL" "$REPO_DIR"
fi

# Change to the repository directory
cd "$REPO_DIR" || exit

# Switch to the master branch
echo "Switching to master branch..."
git checkout master
echo "Fetching and pulling the latest changes..."
git fetch origin
git reset --hard origin/master

cd ..

TARGET_BASE="./base/rules/ACL4SSR"

cp -r "$REPO_DIR"/Clash "$TARGET_BASE"/Clash