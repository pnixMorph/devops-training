## Create new Admin User using IAM and IAM Identity Center

### Introduction

Typically, when you create a new AWS account you create a root user. This root user has unlimited powers and it is not recommended to use it for API or other kinds of access.

In order to manage access to your various cloud resources, AWS allows you to create Users, Groups and Roles via the Identity and Access Management (IAM) service.

Currently, AWS offers two methods to create users, the older legacy IAM SSO (single sign on) method and the new and more secure IAM Identity Center.

### Method 1: Creating a User using IAM Identity Center (Recommended)
The IAM Identity Center allows When using IAM Identity Center, you can login to Active Directory, a built-in IAM Identity Center directory, or another IdP connected to IAM Identity Center. You can map these credentials to an AWS Identity and Access Management (IAM) role for you to run AWS CLI commands.

Regardless of which IdP you use, IAM Identity Center abstracts those distinctions away. Follow these steps:

[Follow these guides](https://docs.aws.amazon.com/singlesignon/latest/userguide/getting-started.html) to set-up user using IAM Identity Center


### Method 2: Creating a User using IAM

1. From the `Services > Security, Identity, & Compliance` select the `IAM` service.
2. From the right sidebar menu, select `Users` and click `Create user`
3. Type in the user name and check the option `Provide user access to the AWS Management Console`
4. From the options displayed, select `I want to create an IAM user`, then click `Next`
> **Note:** Take note of the console password options
5. From the `Set permissions` screen, select `Add user to group` and click on the `Create group` button to create a group
6. When the `Create user group` dialog pops up, type in a descriptive group name (e.g. `admins`) and select the `AdministratorAccess` permission policy for that group. Note that this policy gives any user added to that group full access to your Management Console. Click `Create user group`
7. Back to the `Set permissions` screen, select the group you just created from the group list. Click `Next`
8. Review your settings, then click on `Create user`

The user is now created and the console password as well as the sign-in url will be displayed to you. You can share this information securely with the user.
There is also a `Email sign-in instructions` button that you can use to send an email to the user with sign in instructions.





### User Account Best practices

1. Ensure you enable multi-factor authentication (MFA) once you log into your account.
2. It is recommended to use the IAM Identity Center user to access your AWS CLI rather than using access tokens, which are the older methods of authentication via APIs
