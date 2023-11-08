## Setup and use Sonarqube for Code Analysis

**SonarQube** is a self-managed, automatic code review tool that systematically helps you deliver Clean Code. SonarQube can be integrated into existing workflows and detects issues in  code to perform continuous code inspections in a project. The tool analyses 30+ different programming languages and integrates into the CI pipeline and DevOps platform to ensure that code meets high-quality standards.

Clean Code is the standard for all code that results in secure, reliable, and maintainable software therefore, writing clean code is essential to maintaining a healthy codebase. This applies to all code: source code, test code, infrastructure as code, glue code, scripts, and more. For details, see [Clean Code](https://docs.sonarsource.com/sonarqube/latest/user-guide/clean-code/).

### Installing Sonarqube

Sonarqube can be [downloaded from this link](https://www.sonarsource.com/products/sonarqube/downloads/). Pick any of the options available. The Free Community Edition includes static code analysis for 19 languages: Java, C#, JavaScript, TypeScript, CloudFormation, Terraform, Docker, Kubernetes, Kotlin, Ruby, Go, Scala, Flex, Python, PHP, HTML, CSS, XML, VB.NET and Azure Resource Manager.

After downloading, extract the file from the zipped file. Sonarqube has several requirements which you have to ensure are in place:
1. JRE (Java Runtime Environment)
2. Database server (Postgresql or SQL Server)
3. A database created with a name `sonarqube` or some other unique name

To create a database in postgresql run the `CREATE DATABASE name_of_database` command in the `psql` command line utility.

### Configuring Sonarqube

To configure Sonarqube, there is a `sonarqube.properties` file located in the sonarqube `conf` folder, which you have to edit. In this file, ensure to specify the url to the database you have created for sonarqube using a JDBC url string. In most cases, you may not need to change the values if you go with defaults.
You also need to provide the username and password for the database user. Uncomment the `sonar.jdbc.username` and `sonar.jdbc.password` lines and type in the correct values for those properties.

### Start Sonarqube

To start Sonarqube, run the `sonar.sh` command in one of the directories in the `bin` folder where you installed Sonarqube. Choose the one corresponding to your OS and run the script.
The script requires command line parameters, so the command to run to start will be:

```bash
./bin/macosx-universal-64/sonar.sh start
```

Once you get the message `Started SonarQube`, you can visit the site at http://localhost:9000

> Note: ElasticSearch will not run as the root user. So ensure you create a non-root user account before installing SonarQube

Once the site has fully loaded, login with the default username `admin` and password `admin`. You will be required to change the default password.

Afterwards, follow the configuration steps to set up a code analysis project for your codebase.

If you are running a custom configuration, you will need to download the `Sonar Scanner` to your local machine and manually run the scan. The scanner can be [downloaded here](https://docs.sonarqube.org/9.9/analyzing-source-code/scanners/sonarscanner/)


### Faster Alternative: Install SonarQube Docker image

This is a much faster and smoother approach to installing SonarQube.
Just run it from the official docker image. Ensure you have docker installed, then run:

```bash
sudo docker run -p 9000:9000 sonarqube
```

After this, you can visit the site at http://hostname:9000


### Analyze Code and View Reports

Once a scan is completed, you will be able to assess the reports from SonarQube and review the issues identified as well as recommended resolution steps.


## Integrating SonarQube into CI/CD Pipeline

SonarQube can easily be integrated into your CI/CD Pipeline. There are plugins to integrate into the popular services e.g. Github, GitLab, Bitbucket, etc.

We will do an example using Github Actions. Below is a sample Github Action configuration file that runs a job for SAST using SonarQube:

```yaml
name: SonarQube Static Analysis

on:
  push:
    branches:
      - main

jobs:
  sonarqube-analysis:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Set up JDK
        uses: actions/setup-java@v2
        with:
          distribution: 'adopt'
          java-version: '17'

      - name: SonarQube Scan
        uses: sonarsource/sonarqube-scan-action@v2
        with:
          sonar-host-url: 'https://your-sonarqube-instance.com'  # Replace with your SonarQube server URL
          sonar-login: ${{ secrets.SONARQUBE_TOKEN }}  # Add a secret named SONARQUBE_TOKEN to your repository

      - name: Upload SonarQube results
        uses: actions/upload-artifact@v2
        with:
          name: sonarqube-report
          path: .scannerwork/report
```

Save this YAML file in your working directory (e.g., `.github/workflows/sonarqube.yml`), replacing `'https://your-sonarqube-instance.com'` with the URL of your SonarQube instance.

Make sure to add a secret named SONARQUBE_TOKEN to your GitHub repository. You can do this by going to your repository on GitHub, navigating to "Settings" > "Secrets," and adding a new secret with the name SONARQUBE_TOKEN and the value being the access token generated from your SonarQube server.

This example workflow triggers on each push to the `main` branch, checks out the code, sets up the JDK, runs SonarQube static analysis, and uploads the results as an artifact.

Once you add this to your repository, you will have SAST set-up to scann your codebase once there is a push to the `main` branch.
