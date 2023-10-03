## Docker Compose
Below is a simple example of a `docker-compose.yml` file for a web application using Docker Compose. This example is for a web application with a front-end built using Node.js and a back-end using MongoDB.

```yaml
version: '3'

services:
  # Frontend service
  web:
    image: nginx:latest
    ports:
      - "80:80"
    volumes:
      - ./frontend:/usr/share/nginx/html
    depends_on:
      - api

  # Backend service
  api:
    image: node:14
    working_dir: /app
    volumes:
      - ./backend:/app
    command: npm start
    environment:
      NODE_ENV: production
    ports:
      - "3000:3000"
    depends_on:
      - database

  # Database service
  database:
    image: mongo:latest
    ports:
      - "27017:27017"
    volumes:
      - ./data:/data/db
```

Explanation:

- **`version: '3'`:** Specifies the version of the Docker Compose file syntax.

- **`services`:** Defines the services that make up the application.

  - **`web`:** Frontend service using the Nginx image.

    - **`ports`:** Maps the host's port 80 to the container's port 80.
    - **`volumes`:** Mounts the local `./frontend` directory into the container at `/usr/share/nginx/html`.

  - **`api`:** Backend service using the Node.js image.

    - **`working_dir`:** Sets the working directory in the container to `/app`.
    - **`volumes`:** Mounts the local `./backend` directory into the container at `/app`.
    - **`command`:** Specifies the command to run when the container starts.
    - **`environment`:** Sets the `NODE_ENV` environment variable to "production".
    - **`ports`:** Maps the host's port 3000 to the container's port 3000.
    - **`depends_on`:** Specifies that this service depends on the `database` service.

  - **`database`:** Database service using the MongoDB image.

    - **`ports`:** Maps the host's port 27017 to the container's port 27017.
    - **`volumes`:** Mounts the local `./data` directory into the container at `/data/db`.

This example demonstrates a simple three-service architecture with a web frontend, a Node.js backend, and a MongoDB database. Adjust the details according to the specific needs and structure of your application.
