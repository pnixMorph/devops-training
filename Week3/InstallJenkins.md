## Ansible Playbook: Install Jenkins and Nginx

### 1. Creating an Ansible Playbook for Configuring Jenkins and Nginx

Below is an Ansible playbook that configures Nginx and sets the document root to /var/www/html. Save this playbook in a file, e.g., `nginx_config.yml`.

```yaml
- name: Install Nginx and Jenkins
  hosts: your_remote_server  # Replace with the target server where you want to install Nginx and Jenkins
  become: yes
  become_user: root

  tasks:
    - name: Add Jenkins APT Repository Key
      apt_key:
        url: https://pkg.jenkins.io/debian-stable/jenkins.io.key
        state: present

    - name: Add Jenkins APT Repository
      apt_repository:
        repo: deb https://pkg.jenkins.io/debian-stable binary/
        state: present

    - name: Update APT Package Cache
      apt:
        update_cache: yes

    - name: Install Nginx and Jenkins
      apt:
        name: "{{ item }}"
        state: present
      loop:
        - nginx
        - jenkins

    - name: Start Jenkins Service
      service:
        name: jenkins
        state: started
        enabled: yes

    - name: Configure Nginx Document Root
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/sites-available/default
      notify:
        - Reload Nginx

  handlers:
    - name: Reload Nginx
      service:
        name: nginx
        state: reloaded
```

In this playbook:
- `hosts` should be replaced with the IP address or hostname of your remote server.
- We use the `apt` module to install Nginx on the server.
- The `template` module is used to configure Nginx by replacing the default Nginx configuration file (`nginx.conf.j2`) with your custom configuration file
- Added Nginx installation alongside Jenkins installation in the same playbook.
- After Jenkins installation, it configures Nginx to set `/var/www/html` as the document root using the `template` module.
- A `handler` is defined to reload Nginx when changes are made to the Nginx configuration.

### 2. Creating the Nginx Configuration File Template (nginx.conf.j2):

Create a Jinja2 template file named `nginx.conf.j2` with the following content:

```nginx
server {
    listen 80;
    server_name _;
    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

This template sets up a basic Nginx server block with the document root at `/var/www/html`.

### 3. Run the Playbook
Run this playbook using the `ansible-playbook` command, specifying your inventory file or target server:

```bash
ansible-playbook -i your_inventory_file install_nginx_and_jenkins.yml
```

Replace `your_inventory_file` with the path to your Ansible inventory file or the IP/hostname of your target server if you're specifying it directly.
