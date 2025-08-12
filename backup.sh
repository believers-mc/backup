#!/bin/bash
export HOME=/home/ubuntu
MAX_COMMITS=100
cd /home/ubuntu/minecraft-server

git add .
if git diff --staged --quiet; then
    echo "No changes to backup"
    exit 0
fi

git commit -m "Backup $(date)"
COMMIT_COUNT=$(git rev-list --count HEAD)

if [ $COMMIT_COUNT -gt $MAX_COMMITS ]; then
    echo "Too many commits ($COMMIT_COUNT), keeping last $MAX_COMMITS"

    KEEP_FROM=$(git rev-list HEAD | head -n $MAX_COMMITS | tail -n 1)
    git checkout --orphan temp-branch $KEEP_FROM
    git commit -m "Repository reset - keeping last $MAX_COMMITS commits"

    git branch -D main
    git branch -m temp-branch main
fi

git push -f origin main

echo "Backup completed. Total commits: $(git rev-list --count HEAD)"


