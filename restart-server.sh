#!/bin/bash
cd /home/ubuntu/minecraft-server || exit 1

./stop-server.sh

sleep 8

nohup ./bedrock_server >> server.log 2>&1 &

echo "Started Server"
