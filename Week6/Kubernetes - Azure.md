## Deploy a scalable application with Azure Kubernetes Service (AKS)

In this tutorial we will be deploying a simple ReactJs frontend, Python backend app using `kubernetes`. We will be using a managed Kubernetes service provided by Microsoft Azure (called Azure Kubernetes Service or AKS), which allows us to deploy Kubernetes clusters without the complexities of handling the control plane and containerized infrastructure.

### Prerequisites
To follow this tutorial, you need to:
- Create an [Azure account](https://azure.microsoft.com) if you don't have one already. Other cloud providers can also be used (e.g. GCP, AWS, DigitalOcean, etc), however, you will have to setup image registries in those services.
- Create an [Azure Container Registry (ACR)](https://portal.azure.com/#view/HubsExtension/BrowseResource/resourceType/Microsoft.ContainerRegistry%2Fregistries) repository for Docker images
- [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli), the Azure command line tool
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

The image is still only in your local regsitry. To run it in production, you need to upload the image to a remote registry. Docker has a registry at [Docker Hubs](https://hubs.docker.com), however we will be using Azure Container Registry (ACR). The Azure CLI is required to have access to ACR, or any other Azure APIs.
[Click here to install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli), if you haven't already done so.

You will have to create an [Azure Container Registry (ACR)](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-get-started-portal?tabs=azure-cli) first.
- To create a registry, go to the [Create a resource > Containers > Container Registry](https://portal.azure.com/#create/Microsoft.ContainerRegistry) and follow the steps to create a new registry. Remember you can create either a `Public` or `Private` registry.

Then, [create an Azure Service Principal](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-auth-service-principal) to allow you login to ACR with docker. Follow the steps below to create an Azure Service Principal.

1. From your Azure console, click on the Azure Cloud Shell icon to launch the cloud shell
2. Copy the below bash code snippet and save it within your Azure Cloud Shell:

```bash
#!/bin/bash
# This script requires Azure CLI version 2.25.0 or later. Check version with `az --version`.

# Modify for your environment.
# ACR_NAME: The name of your Azure Container Registry
# SERVICE_PRINCIPAL_NAME: Must be unique within your AD tenant
ACR_NAME=$1
SERVICE_PRINCIPAL_NAME=$2

# Obtain the full registry ID
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query "id" --output tsv)
# echo $registryId

# Create the service principal with rights scoped to the registry.
# Default permissions are for docker pull access. Modify the '--role'
# argument value as desired:
# acrpull:     pull only
# acrpush:     push and pull
# owner:       push, pull, and assign roles
PASSWORD=$(az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME --scopes $ACR_REGISTRY_ID --role acrpush --query "password" --output tsv)
USER_NAME=$(az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query "[].appId" --output tsv)

# Output the service principal's credentials; use these in your services and
# applications to authenticate to the container registry.
echo "Service principal ID: $USER_NAME"
echo "Service principal password: $PASSWORD"
```
3. Ensure the script has execute permissions with `sudo chmod +x scriptname`, then run the script:
```bash
./scriptname <name-of-container-registry> <service-principal-name>
```

The script will print out the service principal ID and password. Now login with `docker`
```bash
docker login registryname.azurecr.io
```
Docker will request for username and password. Use the service principal ID and password respectively to log in.

Now you have a registry and logged into it, run the following commands to tag your local image with its fully-qualified destination path and registry name, and push to the registry:

```bash
docker tag my-web-app <registry-name>.azurecr.io/my-web-app
docker push <registry-name>.azurecr.io/my-web-app
```

You can pull this image and run a container from it in another machine with the following command:

```bash
docker run -p 80:80 <registry-name>.azurecr.io/my-web-app
```

#### Step 4: Create a Cluster

Now you can create a Kubernetes cluster using Azure Kubernetes Service (AKS).
Go to [`Create a resource > Containers > Azure Kubernetes Service`](https://portal.azure.com/#create/microsoft.aks).
Follow the steps to create the cluster.

Once you have created the cluster, you need to authenticate `kubectl` to the cluster so it can access the container registry and the cluster.

To do this, use the `az` CLI to automatically generate the `$HOME/.kube/config` file that `kubectl` needs. The config file allows `kubectl` to connect to your cluster.

Run the following command in Azure Cloud Shell, replacing `<subscription-id>` with your subscription ID, `<my-cluster>` with your AKS cluster name, and `<my-cluster-group>` with your cluster resource group name.

```bash
az account set --subscription <subscription-id>
az aks get-credentials --resource-group <my-cluster-group> -name <my-cluster>
```

#### Step 5: Run your App on the Cluster

After properly setting up the cluster configuration, run some commands to check you cluster status:

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
kubectl create deployment my-web-app-deployment --image=<registry-name>.azurecr.io/my-web-app
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
