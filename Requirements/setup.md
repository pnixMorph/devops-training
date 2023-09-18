### Windows
1. **Install Windows Subsystem for Linux (WSL)**:  
   - Open PowerShell as Administrator and run the following command:
     ```powershell
     dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
     ```
   - Enable the Virtual Machine Platform feature:
     ```powershell
     dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
     ```
   - Install a Linux distribution from the Microsoft Store (e.g., Ubuntu).
   - Set up your Linux user account.

2. **Install Chocolatey**:
   - Open PowerShell as Administrator and run the following command:
     ```powershell
     Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
     ```

3. **Install Git, VSCode, and Terraform via Chocolatey**:
   - Open PowerShell as Administrator and run the following commands:
     ```powershell
     choco install git vscode terraform
     ```

4. **Install Azure CLI**:
   - Download and run the [Azure CLI installer for Windows](https://aka.ms/installazurecliwindows).


### Linux
1. **Install Git, VSCode, and Terraform**:
   - Use your distribution's package manager to install Git, VSCode, and Terraform. For example:
     - On Ubuntu/Debian:
       ```bash
       sudo apt update
       sudo apt install git code terraform
       ```
     - On CentOS/Fedora:
       ```bash
       sudo dnf install git code terraform
       ```

2. **Install Azure CLI**:
   - Follow the [official Azure CLI installation instructions for Linux](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux).


### macOS
1. **Install Homebrew**:
   - Open Terminal and run the following command:
     ```bash
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     ```

2. **Install Git, VSCode, and Terraform via Homebrew**:
   - Run the following commands in Terminal:
     ```bash
     brew install git visual-studio-code terraform
     ```

3. **Install Azure CLI**:
   - Follow the [official Azure CLI installation instructions for macOS](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-macos).


## Configuring Git
Before you start using Git, configure your name and email. Open a terminal and run the following commands, replacing `Your Name` and `your.email@example.com` with your information:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

