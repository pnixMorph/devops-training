## Configuration Management with Ansible

### Ansible Playbook and syntax
Here is a detailed sample of an Ansible playbook along with explanations for each section
```yaml
- name: Configure Web Servers
  hosts: web_servers
  become: yes
  become_user: root

  tasks:
    - name: Update package cache
      apt:
        update_cache: yes
      when: ansible_os_family == 'Debian'  # Only execute on Debian-based systems

    - name: Install Apache web server
      apt:
        name: apache2
        state: present
      when: ansible_os_family == 'Debian'  # Only execute on Debian-based systems

    - name: Start Apache service
      service:
        name: apache2
        state: started
        enabled: yes

    - name: Create a directory for the website
      file:
        path: /var/www/mywebsite
        state: directory

    - name: Copy website files
      copy:
        src: /path/to/local/website
        dest: /var/www/mywebsite
      notify:
        - Reload Apache  # Trigger handler to reload Apache when files change

  handlers:
    - name: Reload Apache
      service:
        name: apache2
        state: reloaded
```

### Explanation:

- **name:** A human-readable name for the playbook.
- **hosts:** Specifies the target hosts or groups on which this playbook will run. In this case, it's targeting a group called web_servers.
- **become:** Indicates that Ansible should use privilege escalation (usually sudo or su) to become the root user when running tasks.
- **become_user:** Specifies the user to become when using privilege escalation (in this case, it's root).
- **tasks:** This is where you define the list of tasks to be executed on the target hosts.
    - **name:** A descriptive name for the task.
    - **apt:** This module is used to interact with the package manager on Debian-based systems. In this example, it updates the package cache, ensuring it's up to date.
    - **when:** A conditional statement that specifies when the task should run. In this case, it only runs on Debian-based systems.
    - **service:** This module is used to manage system services. It ensures the Apache web server is started and enabled to start on boot.
    - **file:** This module is used to manage files and directories. It creates a directory for the website if it doesn't exist.
    - **copy:** Copies files from the local machine to the remote host. In this case, it copies website files to the /var/www/mywebsite directory.
    - **notify:** This section specifies a list of handlers to trigger when notified. In this case, it notifies the "Reload Apache" handler when files are copied.
- **handlers:** Handlers are tasks that get triggered by notifications. They are defined separately from tasks.
    - **name:** A name for the handler.
    - **service:** This handler reloads the Apache service when notified. It ensures that Apache picks up configuration changes without needing a full restart.

This playbook, when run against a group of web servers, will update package caches, install Apache, start the Apache service, create a directory for the website, and copy website files. If changes are made to the website files, it will also reload Apache to apply the changes.

### Inventory File
Ansible automates tasks on managed nodes or “hosts” in your infrastructure, using a list or group of lists known as inventory. You can pass host names at the command line, but most Ansible users create inventory files. Your inventory defines the managed nodes you automate, with groups so you can run automation tasks on multiple hosts at the same time. Once your inventory is defined, you use patterns to select the hosts or groups you want Ansible to run against. An example inventory file is shown below:
```yaml
web_servers:
  hosts:
    10.0.0.1:
    bar.example.com:
```

The name `web_servers` defines a group of hosts in the inventory file. This same name is used to reference same set of hosts in the `hosts` entry in the ansible playbook.

To run a playbook with a specified inventory file:
```bash
ansible-playbook -i inventory_file.yml playbook_file.yml
```

Note that the hosts specified in an Ansible inventory file do not override the hosts specified in the playbook. The inventory file and playbook work together to determine which hosts Ansible will target during the execution of a playbook. In the above example, the playbook is targeting hosts in the `web_servers` group.


### Installing Ansible

You can install Ansible on Ubuntu using the following steps. Ansible can be installed from the official Ubuntu repositories or via Python's package manager, pip.

**Method 1: Install Ansible from the Official Ubuntu Repositories**

1. Update the package lists to ensure you have the latest information about available packages:

   ```bash
   sudo apt update
   ```

2. Install Ansible using the `apt` package manager:

   ```bash
   sudo apt install ansible
   ```

3. Confirm the installation by checking the Ansible version:

   ```bash
   ansible --version
   ```


**Method 2: Install Ansible via Python's `pip` (for the latest version)**

1. First, ensure you have Python and `pip` installed. You can check if `pip` is installed by running:

   ```bash
   which pip
   ```

   If `pip` is not installed, you can install it using:

   ```bash
   sudo apt install python3-pip
   ```

2. Install Ansible using `pip`:

   ```bash
   sudo pip install ansible
   ```

   Note that if you are using Python 3, you should use `pip3` instead of `pip`.

3. Confirm the installation by checking the Ansible version:

   ```bash
   ansible --version
   ```

This will install Ansible on your Ubuntu system. You can now use Ansible to manage configurations and automate tasks on your servers.


