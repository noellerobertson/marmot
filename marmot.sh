#!/bin/bash

# marmot.sh

# A script that monitors target files and records who changed/access them in a log file called marmotscream.txt.
# In another window, run: tail -f marmotscream.txt to view changes in real time.

# Check to see if inotify is installed.
if ! command -v inotify >/dev/null 2>&1; then
  echo "Configuring inotify..."

  # Install inotify (ensure the package manager is correct for your distribution).
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get install -y inotify
  else
    echo "There was an error installing inotify. Please attempt to install manually by running: sudo [package manager] install inotify-tools."
    exit 1
  fi

  # Check to see if inotify successfully installed.
  if [ $? -eq 0 ]; then
    echo "inotify was installed successfully."
    exit 1
  fi
fi

# Create the log file.
touch marmotscream.txt
echo "Log file created..."

# Define the file to monitor and the log file. 
files_to_monitor="/path/to/your/file.txt"
log_file="marmotscream.txt"

# Start monitoring the file for changes.
inotifywait -m -e modify,attrib,close_write,move,delete --format "%w%f" "$file_to_monitor" |
while read -r file_changed
do
    # Get the IP address of the user who changed the file.
    ip_address=$(who | awk '{print $5}' | sort -u | head -n 1)

    # Log the change.
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "FILE TAMPERED: $file_changed by $ip_address $USER at $timestamp" >> "$log_file"

done
