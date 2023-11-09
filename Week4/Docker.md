## Creating A Dockerfile

An example Dockerfile for a basic website using nginx.

### Step 1: Write the Dockerfile

```docker
# Specify the base image
FROM nginx

# Set the working directory inside the container
WORKDIR ./

# Copy files in the working folder to the document root in the nginx container
COPY . /usr/share/nginx/html


# Expose port 80, the port for websites
EXPOSE 80
```

In this Dockerfile, we start with the official Nginx base image. We set the working directory inside the container to `./` and copy the website files into the container, at the location specified by Nginx to be the **document root**, i.e. where website files will be taken from. We expose port 80 to allow access to the application by browsers.


### Step 2: Build the Docker Image
Once the Dockerfile is created, build the image using the docker `build` command. On the terminal, navigate to the directory containing the Dockerfile and application code and run the build command:

```bash
docker build -t my-web-app .
```

The `-t` flag allows you to specify a tag for the image. In this case, we named it `my-web-app`. The `.` at the end of the command indicates that the Dockerfile and the application code are in the current directory.

This command will build the Docker image using the instructions defined in the Dockerfile and package your application along with its dependencies into the image.

### Step 3: Running the Container
After successfully building the Docker image, you can run a container from it using the docker run command. Run the following command:

```bash
docker run -p 80:80 my-web-app
```

This command runs the container based on the my-web-app image and maps port 80 of the container to port 80 of the host machine using the `-p` flag. This allows you to access the application running inside the container through `localhost:80` (or just `localhost`) on your host machine.

Your Nginx webserver should now be running inside the Docker container, and you can access it by opening a web browser and navigating to `localhost`.

By following these steps, you’ve successfully built and run a containerized website using Docker. This approach provides portability and consistency, allowing you to easily package and distribute your application across different environments.

### Step 4: Mapping a Volume
In containerized environments, data persistence can be challenging. Docker Volumes solve this problem by providing a way to store and manage data outside the container’s file system, allowing it to survive container restarts and be shared across containers. Here’s an example:
```bash
docker run -v /path/on/host:/path/in/container my-web-app
```
In this command, we use the `-v` flag to create a Docker Volume. We specify the path on the host machine (`/path/on/host`) and the corresponding path inside the container (`/path/in/container`). Any data written to that path in the container will be stored in the Docker Volume on the host machine, ensuring persistence.

### Step 5: Creating a Docker Network
Containerized applications often require communication between containers. Docker provides networking capabilities to establish connections and enable seamless communication. By default, containers can communicate using their IP addresses. However, Docker also offers user-defined networks for better control and isolation.
Here’s an example:

```bash
docker network create my-network
```
```bash
docker run --network my-network --name container1 my-node-app
docker run --network my-network --name container2 my-other-app
```
In this example, we create a user-defined network named `my-network` using the `docker network create` command. Then, we run two containers, `container1` and `container2`, and connect them to `my-network` using the `—-network` flag. This allows the containers to communicate with each other using their respective container names.
