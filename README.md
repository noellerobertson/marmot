<h1>Marmot</h1>

A tamper detection script that monitors target files for changes or access. 

<h1>Process</h1>

1. Checks system for inotify-tools package.
2. If not installed, installs inotify-tools.
3. If installed, proceeds with script and starts "watching" for changes to target files.
4. In another window, run tail -r marmotscream.txt to view changes in real time.

Changes will be shown in marmotscream.txt as "File Name", "User" and date/time.

<h1>Information About inotify</h1>

To manually install:

Ubuntu: sudo apt-get inotify-tools<br>
CentOS 7: sudo yum inotify-tools<br>
Fedora 21: sudo dnf inotify-tools<br>

inotify is incorporated into the Linux kernel 2.16.3 and beyond.

https://en.wikipedia.org/wiki/Inotify
