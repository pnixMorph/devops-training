# This guide will help you setup and create your OpenSSH in Windows.

## Using Windows Command Line (CMD) 

1. **Check for the availability of OpenSSH using**
```
where ssh 
```

2. **Install OpenSSH (if not already installed)**
```
Windows 10 and later versions come with OpenSSH pre-installed. If you're using an older version, you might need to enable it manually.

Go to Settings > Apps > Optional Features.
Click Add a feature and select OpenSSH Client and OpenSSH Server. Install both.
```

3. **Create SSH Keys**
```
ssh-keygen
```

4. **Specify the path**
When prompted, specify the location for saving the keys (press Enter to save in the default location, usually your user directory). You can also set a passphrase for additional security

5. **Copy the Public Key**
```
type C:\path\to\your\ssh\folder\id_rsa.pub
```
Replace C:\path\to\your\ssh\folder\id_rsa.pub with the actual path to your public key file. Copy the entire key starting with ssh-rsa.

6. **Connect to the server using another terminal**
**Connect to Your Server:**
Log in to your server using your preferred method, such as SSH or a web-based control panel provided by your hosting provider.

**Edit the authorized_keys File:**
Once logged in to your server, navigate to your home directory and create a .ssh directory if it doesn't already exist:
```
mkdir -p ~/.ssh
```

6. **Edit the authorized_keys file**
```
nano ~/.ssh/authorized_keys
```

7. **Paste the Public Key:**
Inside the editor, paste your public key that you copied earlier into the authorized_keys file.

8. **Save and exit**
Save the file and exit

9. **Set Correct Permissions (important for Security)**
Ensure that the ~/.ssh directory and the authorized_keys file have the correct permissions. Run the following commands:

```
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```
