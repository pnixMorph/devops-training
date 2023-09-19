## Welcome!!
### This repo contains some files created to help you during this journey 
__This Mission Is Possible__

#Prerequisite Enviroment Setup

### Windows
1. **Install Windows Subsystem for Linux (WSL)**:  
   - To enable Windows Subsystem for Linux, open PowerShell as an Administrator and execute the following command:
     ```powershell
     dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
     ```
   - Enable the Virtual Machine Platform feature with this command:
     ```powershell
     dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
     ```
   - Next, install a Linux distribution of your choice from the Microsoft Store (e.g., Ubuntu).
   - Complete the setup of your Linux user account.

2. **Install Chocolatey**:
   - Open PowerShell as an Administrator and use this command to install Chocolatey:
     ```powershell
     Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
     ```

3. **Install Git, VSCode, and Terraform via Chocolatey**:
   - In PowerShell, running the following commands will install Git, VSCode, and Terraform using Chocolatey:
     ```powershell
     choco install git vscode terraform
     ```

4. **Install Azure CLI**:
   - Download and run the [Azure CLI installer for Windows](https://aka.ms/installazurecliwindows).

### Linux
1. **Install Git, VSCode, and Terraform**:
   - Utilize your distribution's package manager to install Git, VSCode, and Terraform. For instance:
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
   - Refer to the [official Azure CLI installation instructions for Linux](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux).

### macOS
1. **Install Homebrew**:
   - Launch Terminal and execute this command to install Homebrew:
     ```bash
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     ```

2. **Install Git, VSCode, and Terraform via Homebrew**:
   - In Terminal, run these commands to install Git, Visual Studio Code (VSCode), and Terraform using Homebrew:
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
