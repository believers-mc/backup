#!/bin/bash

pid=$(pgrep -f bedrock_server)

if [ -z "$pid" ]; then
    echo "Server not running."
    exit 0
fi

echo "Stopping bedrock_server (PID $pid)..."
kill $pid

for i in {1..30}; do
    if ! kill -0 $pid 2>/dev/null; then
        echo "Server stopped."
        exit 0
    fi
    sleep 1
done

echo "Server did not stop after 30 seconds; consider killing manually."
exit 1

