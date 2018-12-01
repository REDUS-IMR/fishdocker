#!/bin/sh

# Start nginx
nginx
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start nginx: $status"
  exit $status
fi

# Start filebrowser
filebrowser -c /etc/filebrowser.json &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start filebrowser: $status"
  exit $status
fi

# Start ttyd
ttyd -p 8002 sh &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start ttyd: $status"
  exit $status
fi


# Naive check runs checks once a minute to see if either of the processes exited.

while sleep 60; do
  ps aux |grep nginx |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep filebrowser |grep -q -v grep
  PROCESS_2_STATUS=$?
  ps aux |grep ttyd |grep -q -v grep
  PROCESS_3_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not all 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 -o $PROCESS_3_STATUS -ne 0]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done

