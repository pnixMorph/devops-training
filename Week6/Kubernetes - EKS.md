## Deploy a scalable application with AWS Elastic Kubernetes Service (EKS)

In this tutorial we will be deploying a simple ReactJs frontend, Python backend app using `kubernetes`. We will be using a managed Kubernetes service provided by AWS (called Elastic Kubernetes Service or EKS), which allows us to deploy Kubernetes clusters without the complexities of handling the control plane and containerized infrastructure.

### Prerequisites
To follow this tutorial, you need to:
- Create an [AWS account](https://aws.amazon.com) if you don't have one already. Other cloud providers can also be used (e.g. GCP, Azure, DigitalOcean, etc), however, you will have to setup image registries in those services.
- Create an [Elastic Container Registry (ECR)](https://console.aws.amazon.com/ecr) repository for Docker images
- Create an AWS IAM access key, which can be obtained from the **Securiy Credentials** user account menu item on your [Dashboard](https://console.aws.amazon.com)
- [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html), the AWS command line tool
- [Install `kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/), the Kubernetes command-line tool

#### Step 1: Create your web app
Create a sample app and make a docker container from it. Here's a sample backend api app made with `FastApi`.

```python
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post("/postform")
async def postform():
    return {"message": "form successfully posted"}
```

Save this in a file `main.py`. To run this file you need the following dependencies. These dependencies should be saved in a file named `requirements.txt`:

```
annotated-types==0.5.0
anyio==3.7.1
click==8.1.7
exceptiongroup==1.1.3
fastapi==0.103.2
h11==0.14.0
idna==3.4
pydantic==2.4.2
pydantic_core==2.10.1
sniffio==1.3.0
starlette==0.27.0
typing_extensions==4.8.0
uvicorn==0.23.2
```

#### Step 2: Build a Docker Image
``
To build a Docker image, you first need to create a `Dockerfile`. A `Dockerfile` is a text document that defines the code, the runtime, and any dependencies that your code has, thus recreating the same environment every time it runs. This ensures reproducibility by allowing the code to run correctly on other machines.

In the same directory as your `main.py` and `requirements.txt`, create a file called Dockerfile and write the following content:

```dockerfile
FROM python:3.9

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./main.py /code

EXPOSE 80

ENV SOME_ENV_VAR value

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
```

This sets up the environment needed to run the app including an environment variable `SOME-ENV-VAR` and exposing port 80 for `http`.

Run the following command to create an image based on the `Dockerfile` just created. Tag the image with `-t` for easy identification:

```bash
docker build -t my-web-app .
```

This builds the image in your machine's local image registry. You can view the list of images with `docker images`. The app can be run locally with `docker run -p 80:80 my-web-app`.

#### Step 3: Upload your Docker Image

The image is still only in your local regsitry. To run it in production, you need to upload the image to a remote registry. Docker has a registry at [Docker Hubs](https://hubs.docker.com), however we will be using AWS's Elastic Container Registry. To create a registry, go to the [Services > Containers > Elastic Container Registry](https://console.aws.amazon.com/ecr) and follow the steps to create a new registry.

After creating the registry, you need to create an IAM Access Key to allow to allow you log in with docker. Do this from the `username > Security credentials > Access keys` section. Make sure you save the access key name and value somewhere for future reference.

The AWS CLI is required to have access to the registry, and any other AWS APIs.
[Click here to install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html), if you haven't already done so.

To configure AWS CLI with your access key, run the command:
```bash
aws configure
```

And paste your access key name and value as requested by the command
```
AWS Access Key ID [None]:  ACCESSKEYNAMEHERE
AWS Secret Access Key [None]: paste-the-access-key-value-here 
Default region name [None]: your-AWS-region-name
Default output format [None]: 
```

Once AWS CLI is installed and configured, run the following command to log into the registry (replace `<account_id>` with your AWS account id and `<region>` with your AWS region):

```bash
aws ecr get-login-password --region us-east-1 \
| docker login \
    --username AWS \
    --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
```

Now you have a registry and logged into it, run the following command to tag your local image with its fully-qualified destination path and use your registry name.

```bash
docker tag my-web-app <your-ecr-full-registry-name>/my-web-app
```

Once logged in, you can push your local image to the reposity:

```bash
docker push <your-ecr-full-registry-name>/my-web-app
```

You can pull this image and run a container from it in another machine with the following command:

```bash
docker run -p 80:80 <your-ecr-full-registry-name>/my-web-app
```

#### Step 4: Create a Cluster

Now you can create a Kubernetes cluster using AWS Elastic Kubernetes Service (EKS).
Go to the `Services > Containers > Elastic Kubernetes Service` page and click on `Add cluster > Create` button.
Follow the steps to create the cluster. Note that you would need to [create an IAM role](https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html#create-service-role) for the EKS cluster.

Once you have created the cluster, you need to authenticate `kubectl` to the cluster so it can access the container registry and the cluster.

To do this, use the `aws` CLI to automatically generate the `$HOME/.kube/config` file that `kubectl` needs. The config file allows `kubectl` to connect to your cluster.

Run the following command, replacing `<region-code>` with your region code and `<my-cluster>` with your EKS cluster name.

```bash
aws eks update-kubeconfig --region <region-code> --name <my-cluster>
```

#### Step 5: Create nodes for the cluster
First create an EKS node access role from IAM to allow the cluster to manage EC2 instances on your behalf.
1. From `IAM > Roles` select `Create Role`
2. Select `AWS service` as the Trusted entity type and select `EC2` from the Use case drop down.
3. Select `EC2` option and click Next
4. Search for the following 3 policies, check them, then click Next:
    - AmazonEKSWorkerNodePolicy
    - AmazonEC2ContainerRegistryReadOnly
    - AmazonEKS_CNI_Policy
5. Type in a name and description for the node role, then click Create Role

Create a managed node group, specifying the subnets and node IAM role that you created in previous steps.

1. Open the Amazon EKS console at https://console.aws.amazon.com/eks/home#/clusters.
2. Select the cluster and on the details page, do the following:
    - Choose the Compute tab
    - Choose Add Node Group
3. On the Configure Node Group page, do the following:
    - For Name, enter a unique name for your managed node group, such as my-nodegroup. The node group name can't be longer than 63 characters. It must start with letter or digit, but can also include hyphens and underscores for the remaining characters.
    - For Node IAM role name, choose the node IAM role that you created in the previous step. We recommend that each node group use its own unique IAM role.
    - Choose Next.
4. On the Set compute and scaling configuration page, accept the default values and choose Next.
5. On the Specify networking page, accept the default values and choose Next.
6. On the Review and create page, review your managed node group configuration and choose Create.
7. After several minutes, the Status in the Node Group configuration section will change from Creating to Active. Don't continue to the next step until the status is Active.

#### Step 6: Run your App on the Cluster

After properly setting up the cluster configuration, can run some commands to check you cluster status:

```bash
# Lists your cluster name, user, and namespace
kubectl config get-contexts

# Display addresses of the control plane and cluster services
kubectl cluster-info

# Display the client and server k8s version
kubectl version

# List all nodes created in the cluster
kubectl get nodes

# Displays commands that help manage your cluster
kubectl help
```

To run multiple instances of your applications at once, you can create a Deployment of the app. A Deployment is the object Kubernetes uses to maintain the desired state of your running containers. Run the following command to launch the app live on the cluster:

```bash
kubectl create deployment my-web-app-deployment --image=<your-ecr-full-registry-name>/my-web-app
```

One aspect of the Deployment you created is its default Replica Set, which is the object Kubernetes uses to maintain a stable number of replicas of your container. Each replica is a separate running instance of your container called a Pod. You can confirm that by running the following command, which lists all Replica Sets:

```bash
kubectl get rs
```

This returns an output similar to the following:

```
NAME                       DESIRED   CURRENT   READY   AGE
my-web-app-84b997f5b4      1         1         1       5s
```

And see that your Replica Set is just running one Pod, which is one replica, one instance of your application:

```bash
kubectl get pods
```

This returns an output similar to the following:
```
NAME                             READY   STATUS             RESTARTS   AGE
my-web-app-84b997f5b4-6j5pn      1/1     Running            0          27s
```

Try scaling up to run 20 replicas:

```
kubectl scale deployment/my-web-app --replicas=20
```

Now, when you call `kubectl get rs` and `kubectl get pods`, you see a lot more activity. If you repeatedly call `kubectl get pods`, you can watch the `Status` column change as Kubernetes gets the 19 new Pods up and running.

Next, run the following command to see how these Pods get divided over your nodes:

```bash
kubectl get pod -o=custom-columns=NODE:.spec.nodeName,NAME:.metadata.name --all-namespaces | grep my-web-app
```

This returns an output similar to the following:
```
mypool-cokph   my-web-app-84b997f5b4-25shx
mypool-cokph   my-web-app-84b997f5b4-2tkgz
mypool-cokpk   my-web-app-84b997f5b4-5dtbz
mypool-cokpk   my-web-app-84b997f5b4-5gl7h
mypool-cokpk   my-web-app-84b997f5b4-6j5pn
...
```

Since you named your node pool mypool, the two individual nodes have names with mypool, plus some random characters. Furthermore, the pods are being scheduled so that they are comfortably spread out on your available capacity.

Next, create a load balancer to expose your Deployment to the world. The load balancer runs in the cloud and routes the incoming traffic:

```bash
kubectl expose deployment my-web-app --type=LoadBalancer --port=80 --target-port=80
```

This command exposes the replicas of the sample Python app to the world behind a load balancer, which receives traffic at port 80 and routes that traffic to port 80 on the Pods.

You can check your EC2 dashboard to confirm that the loadbalancer has been deployed. Alternatively, use kubectl get services to see its status:

```bash
kubectl get services
```
```
NAME                   TYPE           CLUSTER-IP      EXTERNAL-IP          PORT(S)     AGE
kubernetes             ClusterIP      192.0.2.1       <none>               443/TCP     2h
sample-load-balancer   LoadBalancer   192.0.2.167     <pending>       80:32490/TCP     6s
```
When the load balancer creation is complete, `<pending>` will show the external IP address or domain name instead. In the `PORT(S)` column, the first port is the incoming port (80), and the second port is the `node port` (32490), not the container port supplied in the `targetPort` parameter.
