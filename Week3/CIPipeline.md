## Setup CI Pipeline with Jenkins
- Install and configure Jenkins on your server
- Create a new Jenkins job and configure the source code repository (e.g., Git, SVN).
- Define the build steps, such as compiling code, running unit tests, and generating build artifacts.
- Set up triggers to automatically initiate the build process on code changes.
- Configure post-build actions, such as deploying the built artifacts to a testing environment.

### Example
```jenkins
pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout your code from version control (e.g., Git)
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                // For a static HTML page, there is no build step, so you can leave this empty.
            }
        }
        
        stage('Deploy') {
            steps {
                // Copy the HTML files to the server using SSH or SCP
                sh '''
                    ssh user@your-server-ip "mkdir -p /path/to/deployment"
                    scp -r * user@your-server-ip:/path/to/deployment
                '''
            }
        }
    }
    
    post {
        success {
            // Send a notification (e.g., email) on successful deployment
            echo 'Deployment successful!'
        }
    }
}
```

## Setup CI Pipeline with GitLab CI/CD
- Create a GitLab repository for your project
- Define a `.gitlab-ci.yml` file in the root of your repository
- Configure the stages and jobs in the pipeline, specifying the necessary commands for building, testing, and deploying your application
- Define triggers for running the pipeline, such as branch changes or merge requests


### Example
```yaml
image: node:14 # Use a Node.js image with npm

stages:
  - build
  - test

variables:
  # Define any environment variables needed for your CI/CD process
  # For example, you might define variables for deployment credentials or settings.
  # MY_ENV_VAR: "my_value"

before_script:
  - npm install -g htmlhint # Install HTMLHint for HTML validation

build:
  stage: build
  script:
    - echo "Building HTML..."
    # Add build commands if needed (e.g., minification, optimization)

test:
  stage: test
  script:
    - echo "Testing HTML..."
    - find . -name "*.html" -type f -exec htmlhint {} + # Run HTMLHint on all HTML files

# Add deployment stages or additional jobs as needed
# For example, you can add a deploy stage to publish the static site to a web server.
```

## Setup CI Pipeline with Github Actions
- Define triggers for running the pipeline, such as branch changes or merge requests
- Create a GitHub repository for the project
- In the repo, create a `.github/workflows` directory, which will hold all github actions
- In the `.github/workflows` directory, create a YAML file for your workflow (e.g., `ci.yml` or any name you prefer)
- In the workflow file, define the workflow using YAML syntax, specify the name, triggers, jobs, and steps
- Create jobs within the workflow. Each job can have multiple steps. Define the steps necessary for building, testing, or deploying your code.
- Set up the environment for your workflow, specifying the type of runner (e.g., Linux, Windows, macOS) and any required dependencies.
- Use existing GitHub Actions or create custom actions to perform specific tasks within your workflow. Actions are reusable units of code.
- Store sensitive information and configuration parameters as secrets or environment variables in your GitHub repository settings.
- Test your workflow locally using GitHub Actions' `act` tool or by pushing changes to your repository to trigger the workflow

### Example
```yaml
name: CI for Static Website

on:
  push:
    branches:
      - main # Change to your main branch name

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout Code
      uses: actions/checkout@v2

    - name: Build HTML
      run: |
        # In this step, you can perform any build tasks if needed.
        # For a static HTML page, there may not be a build step,
        # but you can include it here for completeness.

    - name: Test HTML
      run: |
        # In this step, you can run any tests or checks on your HTML.
        # For example, you can use HTML validation tools like HTMLHint or
        # link checkers to ensure your HTML is valid and all links are working.
        # Replace the commands below with your specific testing commands.

        # Install HTMLHint (if not already installed)
        npm install -g htmlhint

        # Run HTMLHint on all HTML files in the repository
        find . -name "*.html" -type f -exec htmlhint {} +

    - name: Upload Test Results
      if: always() # Upload test results even if previous steps fail
      uses: actions/upload-artifact@v2
      with:
        name: test-results
        path: ./ # Upload all files in the current directory

# Add additional steps or jobs as needed for deployment or other actions.
```
