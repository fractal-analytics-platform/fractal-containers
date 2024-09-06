#!/bin/sh
DIRECTORY_TO_WATCH="/data"
echo $$ >/run/monitord.pid
# Monitor the directory and change permissions
inotifywait -m -e create --format '%w%f' "$DIRECTORY_TO_WATCH" | while read NEW_FILE; do
  chmod 0666 "$NEW_FILE"
  echo "Changed permissions for $NEW_FILE"
done
