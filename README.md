# Portainer Nginx Template

This repository contains a Portainer application template to deploy a simple Nginx container. The container serves a custom HTML page and exposes a port that can be defined during deployment.

## Prerequisites

- Docker must be installed on your machine. If you don't have it, follow the official installation guide for your operating system: [Get Docker](https://docs.docker.com/get-docker/).

## How to Install and Use

### Step 1: Install Portainer

We will install the Portainer Community Edition (CE) which will manage your local Docker environment.

First, create a volume for Portainer to store its data:

```bash
docker volume create portainer_data
```

Next, run the Portainer container. It will automatically connect to your local Docker instance.

```bash
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
```

### Step 2: Initial Portainer Setup

1.  Open your web browser and navigate to `https://localhost:9443`.
2.  You will likely see a browser warning about a self-signed certificate. Proceed to the site.
3.  The first time you access Portainer, you will be prompted to create an administrator account. Choose a username and a secure password, then click **Create user**.
4.  On the next screen, select **Docker** and click **Connect**. You will be taken to the Portainer dashboard, which is now managing your local Docker environment.

### Step 3: Add the Custom App Template

1.  In the Portainer UI, navigate to **Settings** > **App Templates** from the left-hand menu.
2.  Click on **+ Add custom template**.
3.  Select the **Web editor** method.
4.  Give your template a **Title**, for example, `Nginx Custom Page`.
5.  Copy the entire content of the `template.json` file from this repository and paste it into the web editor.
6.  Click **Create custom template**.

### Step 4: Deploy the Nginx Application

1.  From the left-hand menu, go to **App Templates**.
2.  You should see your new "Nginx Custom Page" template. Click on it.
3.  On the deployment screen:
    -   Give your stack a **Name** (e.g., `my-nginx-site`).
    -   You can change the **Host Port** if you wish. The default is `8080`.
4.  Click **Deploy the stack**.

Portainer will now pull the Nginx image and create the container as defined in the template.

### Step 5: Access Your Nginx Site

Once the stack is deployed, you can access your Nginx site by navigating to `http://localhost:<port>` in your browser, where `<port>` is the host port you specified during deployment (e.g., `http://localhost:8080`).

You should see a page with the message: "Hello from my Nginx container!".
