## Deploy a scalable application with Kubernetes

In this tutorial we will be deploying a simple ReactJs frontend, Python backend app using `kubernetes`. We will be using a managed Kubernetes service provided by DigitalOcean (called DigitalOcean Kubernetes or DOKS), which allows us to deploy Kubernetes clusters without the complexities of handling the control plan and containerized infrastructure.

### Prerequisites
To follow this tutorial, you need to:
- Create a DigitalOcean account if you don't have one already. Other cloud providers can also be used (e.g. GCP, AWS, Azure, etc), however, you will have to setup image registries in those services.
- DigitalOcean API token, which can be [obtained here](https://cloud.digitalocean.com/account/api/tokens)
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

The image is still only in your local regsitry. To run it in production, you need to upload the image to a remote registry. Docker has a registry at [Docker Hubs](https://hubs.docker.com), however we will be using DigitalOcean's Container Registry. To create a registry, go to the [DigitalOcean Container Registry](https://cloud.digitalocean.com/registry) and follow the steps to create a new registry.

After creating the registry, you need to get an [API Token](https://cloud.digitalocean.com/account/api/tokens) to allow you log in with docker. Make sure you save the API token somewhere for future reference.

Now, to log into the registry, run the following command:

```bash
docker login registry.digitalocean.com
```

You will be prompted for a username and password. Paste the token as the username and the password.

```bash
# docker login registry.digitalocean.com
 Username: <paste-api-token>
 Password: <paste-api-token>
 ```

Now you have a registry, run the following command to tag your local image with its fully-qualified destination path and use your registry name:you can now push your image to the registry.

```bash
docker tag my-web-app registry.digitalocean.com/<your-registry-name>/my-web-app
```

Once logged in, you can push your local image to the reposity:

```bash
docker push registry.digitalocean.com/<your-registry-name>/my-web-app
```

You can pull this image and run a container from it in another machine with the following command:

```bash
docker run -p 80:80 registry.digitalocean.com/<your-registry-name>/my-web-app
```

#### Step 4: Create a Cluster

Now you can [create a DigitalOcean Kubernetes cluster](https://docs.digitalocean.com/products/kubernetes/how-to/create-clusters/) from your DigitalOcean dashboard.

Once you have created the cluster, you can integrate your existing container registry to it by visiting your [registry settings](https://cloud.digitalocean.com/registry/settings). Click edit next to the **DigitalOcean Kubernetes integration** settings, check the box next to the new cluster, and save.

You also need to authenticate `kubectl` to the cluster so it can access the container registry and the cluster.

To do this, download the cluster configuration file from the [cluster settings](https://cloud.digitalocean.com/kubernetes/clusters), then run the following command with the `--kubeconfig` pointing to the file just downloaded. The config file allows `kubectl` to connect to your cluster.

```bash
kubectl --kubeconfig=/<pathtodirectory>/cluster-kubeconfig.yaml get nodes
```

Copy the config file into the `$HOME/.kube/config`, which is the default config file, so you don't need to keep using the `--kubeconfig` flag each time.

```bash
mv /<pathtodirectory>cluster-kubeconfig.yaml ~/.kube/config
```

#### Step 5: Run your App on the Cluster

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
kubectl create deployment my-web-app --image=registry.digitalocean.com/<yoour-registry-name>/my-web-app
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

You can check your DigitalOcean dashboard to confirm that the loadbalancer has been deployed. Alternatively, use kubectl get services to see its status:

```bash
kubectl get services
```
```
NAME                   TYPE           CLUSTER-IP      EXTERNAL-IP          PORT(S)     AGE
kubernetes             ClusterIP      192.0.2.1       <none>               443/TCP     2h
sample-load-balancer   LoadBalancer   192.0.2.167     <pending>       80:32490/TCP     6s
```
When the load balancer creation is complete, `<pending>` will show the external IP address instead. In the `PORT(S)` column, the first port is the incoming port (80), and the second port is the `node port` (32490), not the container port supplied in the `targetPort` parameter.
