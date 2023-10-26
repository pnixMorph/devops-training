## CloudFormation

CloudFormation is an AWS Infrastructure as Code (IaC) service that allows you to define and provision AWS infrastructure resources in a safe and predictable manner.
It has a lot of configuration options and the files are usually organized in the JSON or YAML format.

**Key Features**
- **Declarative Templates:** Define the desired state of your infrastructure using a JSON or YAML template.
- **Automation:** Automate the provisioning and updating of infrastructure.
- **Stacks:** Create, update, and delete a collection of resources as a single unit called a stack.
- **Resource Management:** Handles dependencies between resources and manages their lifecycle.

### Example YAML configuration file

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: 'Simple EC2 Instance Stack'

Resources:
  MyEC2Instance:
    Type: 'AWS::EC2::Instance'
    Properties:
      ImageId: 'ami-xxxxxxxxxxxxxxxxx'  # Specify your desired Amazon Machine Image (AMI)
      InstanceType: 't2.micro'
      KeyName: 'my-key-pair'
      SecurityGroupIds:
        - 'sg-xxxxxxxxxxxxxxxxx'  # Specify your security group ID
      SubnetId: 'subnet-xxxxxxxxxxxxxxxxx'  # Specify your subnet ID
      Tags:
        - Key: 'Name'
          Value: 'MyEC2Instance'
```

### Example CloudFormation Snippets

#### 1. Create EC2 instance in specified Availability Zone
```yaml
Ec2Instance:
  Type: AWS::EC2::Instance
  Properties:
    AvailabilityZone: aa-example-1a
    ImageId: ami-1234567890abcdef0
```

#### 2. Configure a tagged Amazon EC2 instance with an EBS volume and user data
```yaml
Ec2Instance:
  Type: AWS::EC2::Instance
  Properties:
    KeyName: !Ref KeyName
    SecurityGroups:
      - !Ref Ec2SecurityGroup
    UserData:
      Fn::Base64:
        Fn::Join:
          - ":"
          - - "PORT=80"
            - "TOPIC="
            - !Ref MySNSTopic
    InstanceType: aa.size
    AvailabilityZone: aa-example-1a
    ImageId: ami-1234567890abcdef0
    Volumes:
      - VolumeId: !Ref MyVolumeResource
        Device: "/dev/sdk"
    Tags:
      - Key: Name
        Value: MyTag
```

#### 3. Define DynamoDB table name in user data for Amazon EC2 instance launch

```yaml
Ec2Instance:
  Type: AWS::EC2::Instance
  Properties:
    UserData:
      Fn::Base64:
        Fn::Join:
          - ''
          - - 'TableName='
            - Ref: DynamoDBTableName
    AvailabilityZone: aa-example-1a
    ImageId: ami-1234567890abcdef0
```

References: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/quickref-ec2-instance-config.html


### Create a CloudFormation stack from existing template

AWS has provided lots of templates for basic server configurations that can be used as the starting point for deployments. [Here's a tutorial on creating a Wordpress website using existing template.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/GettingStarted.Walkthrough.html)

### Create a CloudFormation stack using Designer
AWS provides the CloudFormation Designer](), a GUI-based canvas for building stack templates via drag-and-drop. [Here is an example how to build a Basic web server](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/working-with-templates-cfn-designer-walkthrough-createbasicwebserver.html) using CloudFormation Designer.