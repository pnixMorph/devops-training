## Create new Admin User using IAM and IAM Identity Center

### Introduction

Typically, when you create a new AWS account you create a root user. This root user has unlimited powers and it is not recommended to use it for API or other kinds of access.

In order to manage access to your various cloud resources, AWS allows you to create Users, Groups and Roles via the Identity and Access Management (IAM) service.

Currently, AWS offers two methods to create users, the older legacy IAM SSO (single sign on) method and the new and more secure IAM Identity Center.

### Method 1: Creating a User using IAM Identity Center (Recommended)
The IAM Identity Center allows When using IAM Identity Center, you can login to Active Directory, a built-in IAM Identity Center directory, or another IdP connected to IAM Identity Center. You can map these credentials to an AWS Identity and Access Management (IAM) role for you to run AWS CLI commands.

Regardless of which IdP you use, IAM Identity Center abstracts those distinctions away. Follow these steps:

#### Step 1: Choose your identity source
- From the `Services > Security, Identity, & Compliance` select the `IAM Identity Center` service. If you have not already enabled it, you will be asked to enable it.

#### Step 2: Choose your identity source
- From the sidebar menu, select `Settings`, the in the `Identity source` tab, click the `Actions` dropdown and select `Change Identity Source`
- There are 3 options:
    - **Identity Center directory:** When you enable IAM Identity Center for the first time, it is automatically configured with an Identity Center directory as your default identity source. This is where you create your users and groups, and assign their level of access to your AWS accounts and applications.
    - **Active Directory:** Choose this option if you want to continue managing users in either your AWS Managed Microsoft AD directory using AWS Directory Service or your self-managed directory in Active Directory (AD).
    - **External identity provider:** Choose this option if you want to manage users in an external identity provider (IdP) such as Okta or Azure Active Directory.

- The identity source that you choose determines where IAM Identity Center searches for users and groups that need single sign-on access.

#### Step 3: Create an administrative permission set
Permission sets are stored in IAM Identity Center and define the level of access that users and groups have to an AWS account. Perform the following steps to create a permission set that grants administrative permissions.

- In the IAM Identity Center navigation pane, under Multi-account permissions, choose Permission sets.
- Choose Create permission set.
- On the Select permission set type page, in the Permission set type section, choose Predefined permission set.
- In the Policy for predefined permission set section, choose `AdministratorAccess` and choose `Next`.
- The default settings grant full access to AWS services and resources using the `AdministratorAccess` predefined permission set. The predefined `AdministratorAccess` permission set uses the `AdministratorAccess` AWS managed policy.
- On the Specify permission set details page, keep the default settings and choose `Next`. The default setting limits your session to one hour.
- On the Review and create page, confirm the following:
    - For Step 1: Select permission set type, the AWS managed policy is AdministratorAccess.
    - For Step 2: Define permission set details, the permission set name is AdministratorAccess.
    - Choose Create.

#### Step 4: Set up AWS account access for an IAM Identity Center administrative user
#### Step 5: Sign in to the AWS access portal with your IAM Identity Center administrative user credentials
#### Step 6: Create a permission set that applies least-privilege permissions
#### Step 7: Set up AWS account access for additional users (optional)
#### Step 8: Set up single sign-on access to your applications (optional)


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
