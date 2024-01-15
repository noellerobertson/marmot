#!/bin/bash
# marmot.sh
# An experimental script that monitors a target file, creates a log file, and incorporates the IP address of the user who changed the file.

# Check to see if inotify is installed.
if ! command -v inotify >/dev/null 2>&1; then
  echo "inotify is not installed. Installing..."

  # Install inotify (ensure the package manager is correct for your distribution).
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get install -y inotify
  else
    echo "There was an error installing inotify. Please attempt to install manually."
    exit 1
  fi

  # Check to see if inotify successfully installed.
  if [ $? -eq 0 ]; then
    echo "inotify was installed successfully."
    exit 1
  fi
fi

# Define the file to monitor and the log file. 
files_to_monitor="/path/to/your/file.txt"
log_file="marmotscream.txt"

# Ensure the log file exists.
touch "$log_file"

# Start monitoring the file for changes.
inotifywait -m -e modify,attrib,close_write,move,delete --format "%w%f" "$file_to_monitor" |
while read -r file_changed
do
    # Get the IP address of the user who changed the file.
    ip_address=$(who | awk '{print $5}' | sort -u | head -n 1)

    # Log the change and IP address.
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "File changed: $file_changed by $ip_address at $timestamp" >> "$log_file"

# Display the recent findings in the terminal.
tail -f marmotscream.txt | tail -n 10
done
