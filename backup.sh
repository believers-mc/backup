
export HOME=/home/ubuntu

MAX_COMMITS=75

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

    ROOT_COMMIT=$(git rev-list HEAD | tail -n +$((MAX_COMMITS + 1)) | head -n 1)

    KEEP_FROM=$(git rev-list HEAD | tail -n +$MAX_COMMITS | head -n 1)

    git rebase -i --onto $(git rev-list HEAD | sed -n "${MAX_COMMITS}p") $(git rev-list HEAD | tail -1)
fi

git push -f origin main

echo "Backup completed. Total commits: $(git rev-list --count HEAD)"
