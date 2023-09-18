## Linux Commands organized by categoy

**Navigation:**

| Command          | Description                           | Example                          |
|------------------|---------------------------------------|----------------------------------|
| `pwd`            | Print working directory               | `$ pwd`                          |
| `cd`             | Change directory                      | `$ cd /path/to/directory`        |
| `ls`             | List directory contents               | `$ ls`                           |
| `touch`          | Create an empty file                  | `$ touch file.txt`               |
| `mkdir`          | Create a new directory                | `$ mkdir new_dir`                |
| `rmdir`          | Remove an empty directory             | `$ rmdir empty_dir`              |
| `cp`             | Copy files or directories             | `$ cp file.txt new_dir/`         |
| `mv`             | Move or rename files or directories   | `$ mv file.txt new_name.txt`     |

**User Management:**

| Command          | Description                           | Example                          |
|------------------|---------------------------------------|----------------------------------|
| `useradd`        | Add a new user                        | `$ sudo useradd username`        |
| `passwd`         | Change user password                  | `$ sudo passwd username`         |
| `usermod`        | Modify user account settings          | `$ sudo usermod -aG group username` |
| `userdel`        | Delete a user                         | `$ sudo userdel username`        |
| `su`             | Switch user (change user context)     | `$ su - username`                |
| `sudo`           | Execute a command with superuser privileges | `$ sudo command`             |

**File Manipulation:**

| Command          | Description                           | Example                          |
|------------------|---------------------------------------|----------------------------------|
| `rm`             | Remove files or directories           | `$ rm file.txt`                  |
| `find`           | Search for files and directories      | `$ find /path -name filename`    |
| `grep`           | Search for text patterns in files     | `$ grep pattern file.txt`        |
| `tar`            | Archive and compress files            | `$ tar -czvf archive.tar.gz dir/`|
| `wget`           | Download files from the web           | `$ wget https://example.com/file`|
| `curl`           | Transfer data with URLs               | `$ curl -O https://example.com/file`|

**Text Processing:**

| Command          | Description                           | Example                          |
|------------------|---------------------------------------|----------------------------------|
| `cat`            | Concatenate and display file content  | `$ cat file.txt`                 |
| `head`           | Display the beginning of a file       | `$ head -n 10 file.txt`          |
| `tail`           | Display the end of a file             | `$ tail -n 5 file.txt`           |
| `sort`           | Sort lines in a text file             | `$ sort file.txt`                |
| `sed`            | Stream editor for text manipulation   | `$ sed 's/old/new/' file.txt`    |
| `awk`            | Text processing tool (pattern scanning) | `$ awk '/pattern/ {print $2}' file.txt`|

**System Configuration:**

| Command          | Description                           | Example                          |
|------------------|---------------------------------------|----------------------------------|
| `hostname`       | Display or set system hostname        | `$ hostname`                     |
| `ifconfig`       | Network interface configuration       | `$ ifconfig`                     |
| `netstat`        | Network statistics                    | `$ netstat -tuln`                |
| `iptables`       | Configure firewall rules              | `$ sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT` |
| `systemctl`      | Manage system services                | `$ sudo systemctl start service` |
| `journalctl`     | Query and view system logs            | `$ journalctl -u service`        |

**System Monitoring:**

| Command          | Description                           | Example                          |
|------------------|---------------------------------------|----------------------------------|
| `top`            | Display system processes              | `$ top`                          |
| `htop`           | Interactive system process viewer     | `$ htop`                         |
| `ps`             | List running processes                | `$ ps aux`                       |
| `df`             | Disk space usage                      | `$ df -h`                        |
| `free`           | Display free and used memory          | `$ free -m`                      |
| `iostat`         | Input/Output statistics               | `$ iostat -c`                    |

**Dependency Management:**

| Command          | Description                           | Example                          |
|------------------|---------------------------------------|----------------------------------|
| `apt`            | Advanced Package Tool (Debian/Ubuntu) | `$ sudo apt-get install package` |
| `yum`            | Package manager (Red Hat/CentOS)      | `$ sudo yum install package`     |
| `dnf`            | Next-generation package manager (Fedora) | `$ sudo dnf install package`   |
| `rpm`            | RPM package manager                   | `$ rpm -i package.rpm`           |
| `pip`            | Python package manager                | `$ pip install package`          |
| `npm`            | Node.js package manager               | `$ npm install package`          |

**Networking:**

| Command          | Description                                     | Example                                      |
|------------------|-------------------------------------------------|----------------------------------------------|
| `ifconfig`       | Display and configure network interfaces        | `$ ifconfig`                                 |
| `netstat`        | Display network connections and routing tables  | `$ netstat -tuln`                            |
| `ping`           | Test network connectivity                       | `$ ping google.com`                         |
| `traceroute`     | Trace the route to a host                       | `$ traceroute google.com`                   |
| `ssh`            | Securely access remote systems via SSH          | `$ ssh user@hostname`                        |
| `scp`            | Securely copy files between systems via SSH     | `$ scp localfile user@hostname:/remote/path` |

**Security:**

| Command          | Description                                     | Example                                      |
|------------------|-------------------------------------------------|----------------------------------------------|
| `chmod`          | Change file permissions                         | `$ chmod 644 file.txt`                      |
| `chown`          | Change file ownership                           | `$ chown user:group file.txt`               |
| `passwd`         | Change user password                            | `$ passwd username`                         |
| `ufw`            | Uncomplicated Firewall - firewall management    | `$ sudo ufw allow 80/tcp`                   |
| `iptables`       | Configure and manage firewall rules             | `$ sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT` |
| `fail2ban`       | Intrusion prevention system                     | `$ sudo fail2ban-client status`             |

**File Compression and Archiving:**

| Command          | Description                                     | Example                                      |
|------------------|-------------------------------------------------|----------------------------------------------|
| `tar`            | Archive and compress files                      | `$ tar -czvf archive.tar.gz dir/`           |
| `zip`            | Create compressed zip archives                  | `$ zip -r archive.zip dir/`                 |
| `unzip`          | Extract files from zip archives                 | `$ unzip archive.zip`                       |
| `gzip`           | Compress files with gzip                        | `$ gzip file.txt`                           |
| `gunzip`         | Decompress files compressed with gzip           | `$ gunzip file.txt.gz`                      |

**System Information:**

| Command          | Description                                     | Example                                      |
|------------------|-------------------------------------------------|----------------------------------------------|
| `uname`          | Display system information                      | `$ uname -a`                                 |
| `df`             | Display disk space usage                        | `$ df -h`                                    |
| `free`           | Display free and used memory                    | `$ free -m`                                  |
| `lscpu`          | Display CPU information                         | `$ lscpu`                                    |
| `lsblk`          | List block devices and partitions               | `$ lsblk`                                    |

**Text Editors:**

| Command          | Description                                     | Example                                      |
|------------------|-------------------------------------------------|----------------------------------------------|
| `vi` or `vim`    | Text editor with extensive features             | `$ vi filename.txt`                         |
| `nano`           | Simple and user-friendly text editor            | `$ nano filename.txt`                       |
| `emacs`          | Extensible and highly customizable text editor  | `$ emacs filename.txt`                      |

**Process Management:**

| Command          | Description                                     | Example                                      |
|------------------|-------------------------------------------------|----------------------------------------------|
| `ps`             | List running processes                          | `$ ps aux`                                  |
| `top`            | Display and manage system processes             | `$ top`                                     |
| `kill`           | Terminate processes                             | `$ kill process_id`                          |
| `nice`           | Set process priority                            | `$ nice -n 10 command`                       |
| `nohup`          | Run a command immune to hangups                | `$ nohup command &`                          |

**Shell Scripting:**

| Command          | Description                                     | Example                                      |
|------------------|-------------------------------------------------|----------------------------------------------|
| `bash`           | Execute shell scripts and commands              | `$ bash script.sh`                          |
| `chmod`          | Change file permissions                         | `$ chmod +x script.sh`                      |
| `sh`             | Shell interpreter                               | `$ sh script.sh`                            |
| `#!/bin/bash`    | Shebang line for specifying the shell interpreter in a script | `#!/bin/bash`                      |

**Remote Access:**

| Command          | Description                                     | Example                                      |
|------------------|-------------------------------------------------|----------------------------------------------|
| `ssh`            | Securely access remote systems via SSH          | `$ ssh user@hostname`                        |
| `scp`            | Securely copy files between systems via SSH     | `$ scp localfile user@hostname:/remote/path` |

**Disk Management:**

| Command          | Description                                     | Example                                      |
|------------------|-------------------------------------------------|----------------------------------------------|
| `fdisk`          | Manipulate disk partition tables                | `$ sudo fdisk /dev/sdX`                     |
| `mkfs`            | Create a filesystem                            | `$ sudo mkfs.ext4 /dev/sdX`                |
| `mount`          | Mount filesystems                              | `$ sudo mount /dev/sdX /mnt`                |
| `umount`         | Unmount filesystems                            | `$ sudo umount /mnt`                        |

**Package Compilation:**

| Command          | Description                                     | Example                                      |
|------------------|-------------------------------------------------|----------------------------------------------|
| `make`           | Build software from source code                 | `$ make`                                    |
| `configure`      | Configure software before compiling             | `$ ./configure`                             |
| `gcc`            | GNU Compiler Collection                         | `$ gcc -o output_file source_file.c`        |
| `cmake`          | Cross-platform build system                     | `$ cmake . && make`                         |

**System Backup and Restore:**

| Command          | Description                                     | Example                                      |
|------------------|-------------------------------------------------|----------------------------------------------|
| `rsync`          | Synchronize files and directories               | `$ rsync -av source/ destination/`           |
| `tar`            | Archive and compress files                      | `$ tar -czvf backup.tar.gz source/`         |
| `dd`             | Disk backup and cloning                         | `$ sudo dd if=/dev/sdX of=backup.img bs=1M`  |
| `restore`        | Restore files from backups                      | `$ restore -rf /path/to/backup`             |

## Shell I/O - Input / Output redirection

| Redirection Type          | Description                                   | Code Example(s)                                     |
|---------------------------|-----------------------------------------------|-----------------------------------------------------|
| Standard Input (`stdin`)  | Default input source (keyboard)               | `$ cat` (then type input and press Ctrl+D)         |
| Standard Output (`stdout`)| Default output to the terminal                | `$ echo "Hello, World!"`                           |
| Standard Error (`stderr`) | Default error messages to the terminal        | `$ ls /nonexistent-directory`                      |
| Input Redirection (`<`)   | Redirect `stdin` from a file                  | `$ cat < input.txt`                                |
| Output Redirection (`>`)  | Redirect `stdout` to a file (overwrite)      | `$ echo "Hello, World!" > output.txt`              |
| Append Output (`>>`)      | Append `stdout` to a file (no overwrite)     | `$ echo "Appended Text" >> output.txt`             |
| Redirect Stderr (`2>`)    | Redirect `stderr` to a file                  | `$ ls /nonexistent-directory 2> error.txt`         |
| Redirect Stdout & Stderr (`&>` or `2>&1`) | Redirect both `stdout` and `stderr` to a file | `$ command &> output_and_error.txt`        |
| Pipes (`\|`)               | Send `stdout` of one command as `stdin` to another | `$ cat input.txt | grep "another"`         |
| Discard Output (`/dev/null`) | Redirect output to discard it             | `$ command > /dev/null`                            |
| Multiple commands (`&&`)  | Run multiple commands one after the other    | `$ command1 && command2`                           |
